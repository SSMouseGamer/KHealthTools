//
//  KHPhotoLibraryVC.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"

#import "KHPhotoLibraryVC.h"
#import "KHPhotoCollectionVC.h"
#import "KHPhotoModel.h"
#import "KHPhotoTool.h"
#import "KHTableView.h"
#import "KHBarButton.h"
#import "KHTableListCell.h"
#import "KHPhotoModel+AssetDataCategory.h"

@interface KHPhotoLibraryVC () <UITableViewDelegate,UITableViewDataSource,KHPhotoCollectionVCDelegate>
///资源名称
@property (nonatomic, strong) NSArray *nameArr;
///资源数组
@property (nonatomic, strong) NSArray <PHFetchResult *>*assetArr;
///支持的最大值
@property (nonatomic, assign) NSInteger maxCount;
///列表
@property (nonatomic, strong) KHTableView *tableView;
///代理
@property (nonatomic,   weak) id<KHPhotoLibraryVCDelegate> delegate;

@end

@implementation KHPhotoLibraryVC

- (void)dealloc {
    self.assetArr = nil;
}

+ (UINavigationController *)initWithMaxCount:(NSInteger)count delegate:(id<KHPhotoLibraryVCDelegate>)delegate{
    return [[UINavigationController alloc] initWithRootViewController:[[self alloc] initWithMaxCount:count delegate:delegate]];
}

- (instancetype)initWithMaxCount:(NSInteger)count delegate:(id<KHPhotoLibraryVCDelegate>)delegate{
    self = [super init];
    if (self) {
        self.maxCount = count;
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"照片";
    [self setupSubView];
    [self setupService];
}

- (void)setupSubView {
    KHWeakObj(self);
    ///取消
    self.navigationItem.rightBarButtonItem = [[KHBarButton rightBtnWithTitle:@"取消" Color:KH_RGBA( 38, 183, 188, 1) ClickOption:^{
        [weakSelf backBtnClick];
    }] getBarItem];
    CGFloat tH = self.kh_H + 49.0;///self.kh_H默认栈的第一个VC的可用高度 -49.0
    self.tableView = [[KHTableView alloc] initWithFrame:CGRectMake(0, 0, self.kh_W, tH)];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)setupService {
    KHWeakObj(self);
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf loadData];
            });
        }
    }];
}

- (void)loadData{
    if (!KHPhotoToolInstance.nameArr || KHPhotoToolInstance.nameArr.count == 0) {
        [KHPhotoToolInstance initPhotoAssetData];
    }
    self.nameArr = KHPhotoToolInstance.nameArr;
    self.assetArr = KHPhotoToolInstance.assetArr;
    [self.tableView reloadData];
    
    //3.默认选中第一个
    if (self.nameArr.count > 0) {
        [self gotoPhotoLibraryWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO];
    }

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[KHTableListCell alloc] init].kh_height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __block KHTableListCell *cell = [KHTableListCell cellWithTableView:tableView];
    [cell setIcon:nil];
    [KHPhotoModel getThumialImageWithAsset:[self.assetArr[indexPath.row] lastObject] Complete:^(UIImage *image, NSDictionary *info) {
        cell.iconV.image = image;
    }];
    cell.titleL.text = self.nameArr[indexPath.row];
    cell.textL.text = [NSString stringWithFormat:@"%lu",(long)[self.assetArr[indexPath.row] count]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self gotoPhotoLibraryWithIndexPath:indexPath animated:YES];
}

#pragma mark - KHPhotoCollectionVCDelegate
- (void)photoCollectionVC:(KHPhotoCollectionVC *)photoVC photoArr:(NSArray <KHPhotoModel*>*)photoArr {
    if ([self.delegate respondsToSelector:@selector(photoLibraryVC:photoArr:)]) {
        [self.delegate photoLibraryVC:self photoArr:photoArr];
    }
    [self backBtnClick];
}

#pragma mark - private func
///返回
- (void)backBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

///选中具体的相册并跳转
- (void)gotoPhotoLibraryWithIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    KHPhotoCollectionVC *vc = [[KHPhotoCollectionVC alloc] initWithDataArray:self.assetArr[indexPath.row] maxCount:self.maxCount];
    vc.navigationItem.title = self.nameArr[indexPath.row];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:animated];
}

@end

