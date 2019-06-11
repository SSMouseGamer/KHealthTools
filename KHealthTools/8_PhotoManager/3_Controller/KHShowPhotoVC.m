//
//  KHShowPhotoVC.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHShowPhotoVC.h"
#import "KHShowPhotoCell.h"
#import "KHPhotoNavBarView.h"
#import "KHPhotoToolBarView.h"

#define cellId @"showPhotoCollectionCellId"

@interface KHShowPhotoVC () <UICollectionViewDelegate,UICollectionViewDataSource>
///数据
@property (nonatomic, strong) NSArray<KHPhotoModel *>*dataArr;
///容器
@property (nonatomic, strong) UICollectionView *collectionV;
///选中的字典
@property (nonatomic, strong) NSMutableDictionary *selDic;
///导航栏
@property (nonatomic, strong) KHPhotoNavBarView *navBV;
///下方工具栏
@property (nonatomic, strong) KHPhotoToolBarView *toolBV;
///选中的下标
@property (nonatomic, assign) NSInteger selIndex;

@end

@implementation KHShowPhotoVC

#pragma mark - private func
///编辑修改后返回
- (void)editAndPop {
    NSArray *keyArr = [self.selDic allKeys];
    if (keyArr.count == self.dataArr.count) {///无更改
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSArray *sortArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }];
        if ([self.delegate respondsToSelector:@selector(showPhotoVC:refreshPhotoArr:)]) {
            NSMutableArray <KHPhotoModel *>*array = [NSMutableArray array];
            for (NSString *keyStr in sortArr) {
                NSInteger index = [keyStr integerValue];
                [array addObject:self.dataArr[index]];
            }
            [self.delegate showPhotoVC:self refreshPhotoArr:array];
        }
    }
}

#pragma mark - 初始化
- (instancetype)initWithDataArr:(NSArray<KHPhotoModel *> *)dataArr selIndex:(NSInteger)selIndex {
    self = [super init];
    if (self) {
        self.selIndex = selIndex;
        self.dataArr = dataArr;
        for (int i = 0; i < dataArr.count; i++) {
            NSString *selKey = [NSString stringWithFormat:@"%d",i];
            [self.selDic setValue:@"" forKey:selKey];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
    ///默认滚动到指定的row
    if (self.dataArr.count > 0) {
        [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:MIN(self.selIndex, self.dataArr.count-1) inSection:0]
                                 atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)setupSubView {
    KHWeakObj(self);
    ///0. 屏蔽左滑返回 只有在可编辑模式下
    if (self.showType == KHSelPhotoViewStyleEdit) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    CGFloat iY       = KH_IS_iPhoneX ? KH_StatusBar_Height : 0;
    CGFloat iW   = KHScreenWidth;
    CGFloat iH  = KHScreenHeight - iY - KH_Bottom_Height;
    flowLayout.itemSize = CGSizeMake(iW - 0.02, iH - 0.02);
    flowLayout.minimumLineSpacing = 0.01;//每一行之间的间距(最小值)
    flowLayout.minimumInteritemSpacing = 0.01;//item间距(最小值)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ///1. 容器
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, iY, iW, iH) collectionViewLayout:flowLayout];
    self.collectionV.showsVerticalScrollIndicator = NO;
    self.collectionV.showsHorizontalScrollIndicator = NO;
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.pagingEnabled = YES;
    [self.collectionV registerClass:[KHShowPhotoCell class] forCellWithReuseIdentifier:cellId];
    [self.view addSubview:self.collectionV];
    
    ///2. 导航栏
    self.navBV = [[KHPhotoNavBarView alloc] init];
    self.navBV.backgroundColor = KH_RGBA(33, 33, 33, 0.8);
    self.navBV.selBtn.selected = YES;
    self.navBV.titleL.text = [NSString stringWithFormat:@"%ld/%ld",(long)(self.selIndex + 1),(long)self.dataArr.count];
    self.navBV.selBtn.tag = self.selIndex;
    ///2.1 选中
    self.navBV.selClick = ^(BOOL is_sel) {
        [weakSelf reloadSelDicWithSel:is_sel];
    };
    ///2.2 返回
    self.navBV.backClick = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        if ([weakSelf.delegate respondsToSelector:@selector(showPhotoVC:backClick:)]) {
            [weakSelf.delegate showPhotoVC:weakSelf backClick:@""];
        }
    };
    [self.view addSubview:self.navBV];
    ///3. 工具栏
    self.toolBV = [KHPhotoToolBarView initWithBottomY:KHScreenHeight];
    self.toolBV.sureClick = ^{
        [weakSelf editAndPop];
    };
    self.toolBV.sureBtn.enabled = YES;
    self.toolBV.preViewBtn.hidden = YES;
    self.toolBV.backgroundColor = KH_RGBA(33, 33, 33, 0.8);
    NSString *sureStr = [NSString stringWithFormat:@"确定%ld/%ld",(long)self.dataArr.count,(long)self.dataArr.count];
    [self.toolBV.sureBtn setTitle:sureStr forState:UIControlStateNormal];
    [self.view addSubview:self.toolBV];
    
    ///根据查看模式设置是否可以编辑
    if (self.showType != KHSelPhotoViewStyleEdit) {
        self.navBV.selBtn.hidden = YES;
        self.toolBV.hidden = YES;
    }

}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KHWeakObj(self);
    KHShowPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    cell.clickImage = ^{
        weakSelf.navBV.alpha = weakSelf.navBV.alpha == 0 ? 1 : 0;
        weakSelf.toolBV.alpha  = weakSelf.toolBV.alpha == 0 ? 1 : 0;
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(KHShowPhotoCell *)cell setZoomScale];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (scrollView.contentOffset.x + 1)/ KHScreenWidth;
    KHPhotoModel *model = self.dataArr[index];
    self.navBV.titleL.text = [NSString stringWithFormat:@"%ld/%ld",(long)(index + 1), (long)self.dataArr.count];
    self.navBV.selBtn.tag = index;
    self.navBV.selBtn.selected = model.is_sel;
}

#pragma mark - private func
- (void)reloadSelDicWithSel:(BOOL)isSel {
    NSInteger tag = self.navBV.selBtn.tag;
    KHPhotoModel *model = self.dataArr[tag];
    model.is_sel = !model.is_sel;
    NSString *index = [NSString stringWithFormat:@"%ld",(long)tag];
    if (isSel) {
        [self.selDic setValue:@"" forKey:index];
    } else {
        [self.selDic removeObjectForKey:index];
    }
    NSInteger count = [self.selDic allKeys].count;
    NSString *sureStr = [NSString stringWithFormat:@"确定%ld/%lu",(long)count,(long)self.dataArr.count];
    [self.toolBV.sureBtn setTitle:sureStr forState:UIControlStateNormal];
}

#pragma mark - lazy
- (NSMutableDictionary *)selDic {
    if (!_selDic) {
        _selDic = [NSMutableDictionary dictionaryWithCapacity:self.dataArr.count];
    }
    return _selDic;
}

- (NSArray <KHPhotoModel *>*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

@end
