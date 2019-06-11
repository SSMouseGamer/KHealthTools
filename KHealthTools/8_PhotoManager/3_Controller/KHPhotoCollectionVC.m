//
//  KHPhotoCollectionVC.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"

#import "KHPhotoCollectionVC.h"
#import "KHPhotoModel.h"
#import "KHPhotoCell.h"
#import "KHPhotoToolBarView.h"
#import "KHShowPhotoVC.h"
#import "KHPhotoModel+AssetDataCategory.h"

@interface KHPhotoCollectionVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionV;
///下方工具栏
@property (nonatomic, strong) KHPhotoToolBarView *toolBarV;
///cell 数据模型
@property (nonatomic, strong) NSArray <KHPhotoModel *>*dataArr;
///选中的数据模型下标
@property (nonatomic, strong) NSMutableArray *selIndexArr;
///最大值
@property (nonatomic, assign) NSInteger maxCount;
@end

@implementation KHPhotoCollectionVC

- (void)makeSureTheSourceEnableWithIndexPath:(NSIndexPath*)indexPath {
    KHWeakObj(self);
    __block KHPhotoModel *model = self.dataArr[indexPath.row];
    if (model.is_sel) {
        [self selectPhotoWithPhotoModel:model indexPath:indexPath];
        return;
    }
    [KHPhotoModel makeSureIsICloudDataWithAsset:model.asset Complete:^(BOOL isSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isSuccess) {
                [weakSelf selectPhotoWithPhotoModel:model indexPath:indexPath];
                return ;
            }
            [weakSelf kh_simpleAlertWithTitle:@"无法下载图片" Message:@"从“iCloud照片图库“下载这张照片时出错请稍后再试" CompleteTitle:@"我知道了" Complete:nil];
        });
    }];
}

- (void)selectPhotoWithPhotoModel:(KHPhotoModel *)model indexPath:(NSIndexPath *)indexPath {
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (!model.is_sel) {
        if (self.selIndexArr.count >= self.maxCount) {
            [self kh_showMessage:[NSString stringWithFormat:@"最多只能添加%ld张照片", (long)self.maxCount]];
            return;
        }
        [self.selIndexArr addObject:index];
    } else {
        [self.selIndexArr removeObject:index];
    }
    model.is_sel = !model.is_sel;
    [self setToolBarBtnStatus];
    KHPhotoCell *cell = (KHPhotoCell *)[self.collectionV cellForItemAtIndexPath:indexPath];
    cell.model = model;
}

#pragma mark - init
- (instancetype)initWithDataArray:(PHFetchResult *)dataArr maxCount:(NSInteger)maxCount{
    self = [super init];
    if (self) {
        NSMutableArray <KHPhotoModel *>*modelArr = [NSMutableArray array];
        for (int i = 0; i < dataArr.count; i++) {
            __block KHPhotoModel *model = [[KHPhotoModel alloc] init];
            model.asset = dataArr[i];
            model.is_sel = NO;
            [modelArr addObject:model];
        }
        self.dataArr = modelArr;
        self.maxCount = maxCount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
    [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionBottom) animated:NO];
    self.collectionV.contentOffset = CGPointMake(self.collectionV.contentOffset.x, self.collectionV.contentOffset.y + 50.0);
}

- (void)setupSubView {
    KHWeakObj(self);
    CGFloat cW = self.kh_W;
    CGFloat cH = self.kh_H;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    //item的大小
    int number = 4;
    CGFloat margin = 5;
    CGFloat itemWidth  = (KHScreenWidth - margin*(number+1))/number;
    CGFloat itemHeight = itemWidth;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumLineSpacing = margin;//每一行之间的间距(最小值)
    flowLayout.minimumInteritemSpacing = margin * 0.5;//item间距(最小值)
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, KH_Bottom_Height + 49, margin);
    ///0. 容器
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, cW, cH) collectionViewLayout:flowLayout];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    [self.collectionV registerClass:[KHPhotoCell class] forCellWithReuseIdentifier:@"photoCellId"];
    self.collectionV.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.collectionV];
    
    self.toolBarV = [KHPhotoToolBarView initWithBottomY:self.kh_H];
    ///0.1 去预览
    self.toolBarV.preViewClick = ^{
        KHShowPhotoVC *vc = [[KHShowPhotoVC alloc] initWithDataArr:[weakSelf getSelPhotoArr] selIndex:0];
        vc.showType = KHSelPhotoViewStyleShow;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    ///0.2 确定
    self.toolBarV.sureClick = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(photoCollectionVC:photoArr:)]) {
            [weakSelf.delegate photoCollectionVC:weakSelf photoArr:[weakSelf getSelPhotoArr]];
        }
    };
    [self.view addSubview:self.toolBarV];
    ///1. 界面调整
    [self setToolBarBtnStatus];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KHPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCellId" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self makeSureTheSourceEnableWithIndexPath:indexPath];
}

#pragma mark - private func
- (void)setToolBarBtnStatus {
    NSInteger count = self.selIndexArr.count;
    [self.toolBarV.sureBtn setTitle:[NSString stringWithFormat:@"确定 %ld/%ld",(long)count,(long)self.maxCount] forState:UIControlStateNormal];
    BOOL enabled = count > 0;
    self.toolBarV.sureBtn.enabled = enabled;
    self.toolBarV.preViewBtn.enabled = enabled;
}

///获取选中的图片
- (NSArray <KHPhotoModel *>*)getSelPhotoArr {
    NSArray *keyArr = self.selIndexArr;
    
    NSMutableArray <KHPhotoModel *>*array = [NSMutableArray arrayWithCapacity:keyArr.count];
    for (NSString *keyStr in keyArr) {
        [array addObject:[self.dataArr objectAtIndex:[keyStr integerValue]]];
    }
    return array;
}

#pragma mark - lazy load
- (NSMutableArray *)selIndexArr {
    if (!_selIndexArr) {
        _selIndexArr = [[NSMutableArray alloc] init];
    }
    return _selIndexArr;
}

@end
