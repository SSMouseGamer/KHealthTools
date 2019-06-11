//
//  KHPhotoDemoController.m
//  KHealthModules
//
//  Created by 李云新 on 2018/12/8.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHPhotoDemoController.h"
#import "KHPhotoTool.h"
#import "KHealthTools/KHealthTools.h"

@interface KHPhotoDemoController ()

@property (nonatomic, strong) KHSelPhotoView *photoView;

@end

@implementation KHPhotoDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    KHWeakObj(self);
    NSArray *urlArr = @[];
    self.photoView = [KHPhotoTool initPhotoViewWithFrame:CGRectMake(0, 10, KHScreenWidth, 100) style:(KHSelPhotoViewStyleEdit) maxCount:100 imageArr:urlArr updateUIBlock:^{
        
    }];
    [self.view addSubview:self.photoView];
    self.navigationItem.rightBarButtonItem = [[KHBarButton rightBtnWithTitle:@"测试数据" Color:[UIColor blackColor] ClickOption:^{
        [weakSelf getData];
    }] getBarItem];
}

- (void)getData {
    KHWeakObj(self);
    [self.photoView getImageDataArrayWithTipMsg:@"正在上传" CompleteOption:^(NSArray<NSData *> *pDataS, NSArray *pIndexS ,NSArray *pUrlS) {
        KHLog(@"需要上传的图片下标数组：%@",pIndexS);
        [KHHUD kh_hideHUD];
        [weakSelf uploadImageWithDataArray:pDataS];
    }];
}

- (void)uploadImageWithDataArray:(NSArray <NSData *>*)dataArr {

}

@end
