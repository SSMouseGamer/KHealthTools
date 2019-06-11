//
//  KHSelPhotoView.m
//  KHealthModules
//
//  Created by kim on 2018/12/28.
//

#import "KHealthToolsHeader.h"
#import "KHServicesHeader.h"

#import "KHSelPhotoView.h"
#import "KHSelPhotoCollectionCell.h"
#import "KHSelPhotoView+FuncCategory.h"

///尾部预留间距
#define BOTTOM_MARGIN 21 * KHScale
///cellId
#define PHOTO_CELL_ID @"selPhotoCellId"

@interface KHSelPhotoView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,   copy) void(^updateUIBlock)(void);
///图片上限 - 默认9，需改变请初始化时设置
@property (nonatomic, assign) NSInteger maxCount;
///每一行多少张
@property (nonatomic, assign) NSInteger lineNumber;
///每一张的高度
@property (nonatomic, assign) CGFloat itemH;

@end

@implementation KHSelPhotoView

#pragma mark - action
- (void)updateUIWithImageArr:(NSArray *)imageArr {
    self.modelArray = [NSMutableArray array];
    [self buildImageArray:imageArr];
    [self reloadUI];
}
///展示图片
- (void)showPhotoWithIndex:(NSInteger)index ContainerView:(UIView *)containerView {
    KHShowPhotoVC *vc = [[KHShowPhotoVC alloc] initWithDataArr:self.modelArray selIndex:index];
    vc.showType = self.style;
    vc.delegate = self;
    [[KHTools kh_getNaviVC] pushViewController:vc animated:YES];
}
///添加图片
- (void)addPhoto {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    if (self.modelArray.count >= self.maxCount) {
        [KHHUD kh_showMessage:[NSString stringWithFormat:@"已有%ld张照片\n不能再添加了", (long)self.modelArray.count]];
        return;
    }
    KHWeakObj(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *oA = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf c_openCameraVC];
    }];
    [alertController addAction:oA];
    
    UIAlertAction *pA = [UIAlertAction actionWithTitle:@"从手机相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf c_openPhotoLibVCWithMaxCount:weakSelf.maxCount - weakSelf.modelArray.count];
    }];
    [alertController addAction:pA];
    
    UIAlertAction *cA = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertController addAction:cA];
    [[KHTools kh_getNaviVC] presentViewController:alertController animated:YES completion:nil];
}

///获取图片数据
- (void)getImageDataArrayWithTipMsg:(NSString *)tipMsg CompleteOption:(void (^)(NSArray <NSData *> *pDataS, NSArray *pIndexS, NSArray *pUrlS))cOption {
    if (tipMsg) {
        [KHHUD kh_showLoad:tipMsg toView:nil delay:100.f];
    }
    [self c_getImageArray:cOption];
}

///获取当前视图的图片资源
- (void)getImageImageArray:(void(^)(NSArray <UIImage *> *pImgS))cOption {
    [self c_getImageImageArray:cOption];
}

#pragma mark - private func
///构建初始化数据
- (void)buildImageArray:(NSArray *)array {
    if (array.count <= 0) return;
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:array];
    if ([dataArr.firstObject isKindOfClass:[NSNull class]]) {
        [dataArr removeObjectAtIndex:0];
    }
    if ([dataArr.firstObject isKindOfClass:[NSString class]]) {
        if (dataArr.count < array.count) {
            [dataArr insertObject:@"" atIndex:0];
        }
        for(NSString *urlStr in dataArr) {
            KHPhotoModel *model = [KHPhotoModel initWithAsset:nil cacheImage:nil urlStr:urlStr];
            model.is_sel = YES;
            [self.modelArray addObject:model];
        }
    } else if ([dataArr.firstObject isKindOfClass:[UIImage class]]) {
        if (dataArr.count < array.count) {
            [dataArr insertObject:[UIImage imageNamed:@""] atIndex:0];
        }
        for(UIImage *image in dataArr) {
            KHPhotoModel *model = [KHPhotoModel initWithAsset:nil cacheImage:image urlStr:nil];
            model.is_sel = YES;
            [self.modelArray addObject:model];
        }
    }
}

///刷新UI
- (void)reloadUI {
    //计算真实的高度
    NSInteger count = self.modelArray.count;
    switch (self.style) {
        case KHSelPhotoViewStyleJustAdd:
        case KHSelPhotoViewStyleEdit:
            count += 1;
            break;
        case KHSelPhotoViewStyleShow:
            break;
    }
    NSInteger lineCount = (count / self.lineNumber) + (count % self.lineNumber == 0 ? 0 : 1);
    self.kh_height = lineCount * (self.itemH + BOTTOM_MARGIN);
    [self reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //通知刷新
        if (self.updateUIBlock) {
            self.updateUIBlock();
        }
    });
}

#pragma mark - 初始化
- (instancetype)initWithLineCount:(NSInteger)count style:(KHSelPhotoViewStyle)style maxCount:(NSInteger)maxCount frame:(CGRect)frame imageArr:(NSArray *)imageArray updateUIBlock:(void(^)(void))updateUIBlock {
    count = count > 0 ? count : 4;
    CGFloat width = frame.size.width;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    CGFloat leftMargin = KH15Margin;
    ///item之间的间隙
    CGFloat margin = 18 * KHScale;
    CGFloat itemW = -0.1 + (width - (count - 1) * margin - 2 * leftMargin) / count;
    CGFloat itemH = itemW;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = margin;//每一行之间的间距(最小值)
    flowLayout.minimumInteritemSpacing = margin;//item间距(最小值)
    flowLayout.sectionInset = UIEdgeInsetsMake(0.01, leftMargin, BOTTOM_MARGIN, leftMargin);
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.style = style;
        self.updateUIBlock = updateUIBlock;
        self.maxCount = maxCount == 0 ? 9 : maxCount;
        self.lineNumber = count;
        self.itemH = itemH;
        [self buildImageArray:imageArray];
        [self setupSubView];
        [self reloadUI];
    }
    return self;
}

- (void)setupSubView {
    self.delegate = self;
    self.dataSource = self;
    self.scrollsToTop = NO;
    self.scrollEnabled = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[KHSelPhotoCollectionCell class] forCellWithReuseIdentifier:PHOTO_CELL_ID];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.style == KHSelPhotoViewStyleShow) {
        return self.modelArray.count;
    } else {
        return self.modelArray.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __block KHSelPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_CELL_ID forIndexPath:indexPath];
    if (self.style != KHSelPhotoViewStyleShow && indexPath.row >= self.modelArray.count) {
        cell.imageView.image = [KHTools kh_getToolsBundleImage:@"kht_photo_sel_picture+"];
    } else {
        cell.model = self.modelArray[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.style != KHSelPhotoViewStyleShow && indexPath.row >= self.modelArray.count) {
        [self addPhoto];
    } else {
        [self showPhotoWithIndex:indexPath.row ContainerView:collectionView];
    }
}

#pragma mark - lazy load
- (NSMutableArray <KHPhotoModel *>*)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
