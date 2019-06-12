//
//  KHStartController.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/14.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHStartController.h"
#import "ViewController.h"

@interface KHStartController ()

@end

@implementation KHStartController

- (UIViewController *)get_homeController {
    return [[KHNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
}

- (BOOL)set_initInfo {
    return YES;
}

- (void)services_getAD {
    [self kh_successWithImageUrl:@"https://wx3.sinaimg.cn/mw690/006r2HqOgy1g3pbugu5auj30p00xch5n.jpg"];
}

- (void)kh_successWithImageUrl:(NSString *)imageUrl {
    KHWeakObj(self);
    [UIView kh_downloadImage:imageUrl PlaceholderImage:nil Complete:^(UIImage *image) {
        if (image == nil) {
            [weakSelf kh_goHomeWithAnimDelay:0];
            return;
        }
        
        weakSelf.adView.image = image;
        weakSelf.adView.alpha = 0.0f;
        [UIView animateWithDuration:0.25f animations:^{
            weakSelf.adView.alpha = 1.0;
        }];
        
        [[KHTimerManager share] countDownWithName:@"KHStartControllerTimerDeasd" time:3 action:^(NSInteger i) {
            weakSelf.goBtn.alpha  = 1.0;
            NSString *str = [@"跳过 " stringByAppendingFormat:@"%ld", (long)i];
            [weakSelf.goBtn setTitle:str forState:(UIControlStateNormal)];
            
        } endAction:^{
            [weakSelf kh_goHomeWithAnimDelay:0];
        }];
    }];
}

@end

