//
//  ViewController.m
//  KHealthTools
//
//  Created by 李云新 on 2018/8/8.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "ViewController.h"
#import "KHealthTools/KHealthTools.h"

#import "TextLayerController.h"
#import "KHFontSizeSettingController.h"
#import "KHPhotoDemoController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KHWeakObj(self);
    self.navigationItem.title = [KHTools kh_appBundleName];
    
    NSDictionary *shareDict = @{@"title":@"测试网络访问", @"text":@"666", @"block":^(){
        [weakSelf cheackServices];
    }};
    
    NSDictionary *selServicesDict = @{@"title":@"选择网络配置", @"text":@"666", @"block":^(){
        [weakSelf.navigationController pushViewController:[[KHSelServicesController alloc] init] animated:YES];
    }};
    
    NSDictionary *textLayerLineDict = @{@"title":@"textLayer换行", @"text":@"666", @"block":^(){
        [weakSelf.navigationController pushViewController:[[TextLayerController alloc] init] animated:YES];
    }};
    
    NSDictionary *fontSizeDict = @{@"title":@"设置字体大小", @"text":@"666", @"block":^(){
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:[[KHFontSizeSettingController alloc] init]];
        [weakSelf presentViewController:nvc animated:YES completion:nil];
    }};
    
    NSDictionary *photoDemo = @{@"title":@"图片相关", @"text":@"666", @"block":^(){
        KHPhotoDemoController *vc = [[KHPhotoDemoController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }};
    
    self.dataArray = @[@[shareDict, selServicesDict, textLayerLineDict, fontSizeDict, photoDemo]];
}


#pragma mark -
- (void)cheackServices {
    KHWeakObj(self);
    KHServicesTask *task = [KHServicesTask getPath:@"flickerImg/forStaff/findAdvertising" Param:@{@"organizationId":@"ORG0000000000001"}];
    task.doMain = @"https://docapi.kanghehealth.com/";
    
    [[KHServices share] requestWithTask:task DictComplete:^(NSDictionary *jDict, BOOL success, NSInteger code, NSString *msg) {
        
        if (success) {
            NSString *imageUrl = jDict[@"imageUrl"];
            [UIView kh_downloadImage:imageUrl Complete:^(UIImage *image) {
                UIViewController *vc = [[UIViewController alloc] init];
                vc.navigationItem.title = @"闪屏获取";
                vc.view.layer.contents = (id)image.CGImage;
                vc.view.backgroundColor = [UIColor whiteColor];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
        } else {
            KHLog(@"获取闪屏报错了 %@", msg);
        }
    }];
}

#pragma mark -
- (void)cell:(KHTableListCell *)cell Data:(id)dataModel IndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = dataModel;
    cell.titleL.text = dict[@"title"];
    cell.textL.text = dict[@"text"];
    if (indexPath.row == 0 && indexPath.section == 0) {
        [cell setIcon:@"http://d.ifengimg.com/mw1000_mh666/p2.ifengimg.com/2018_44/F34CFD8D4A2423D5C344CE8C43BD7EFB9D571C9D_w1000_h667.jpg"];
    } else {
        [cell setIconHidden:YES];
    }
}

- (void)didSelectRowAtData:(id)dataModel IndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = dataModel;
    void (^block)(void) = dict[@"block"];
    if (block) {
        block();
    }
}

@end
