//
//  KHBaseStartController.m
//  KHealthModules
//
//  Created by 李云新 on 2019/3/18.
//

#import "KHealthToolsHeader.h"
#import "KHServicesHeader.h"
#import "KHTimerManager.h"

#import "KHBaseStartController.h"

@interface KHBaseStartController ()

@end

@implementation KHBaseStartController

#pragma mark - 交互
- (UIViewController *)get_homeController {
    return [[UIViewController alloc] init];
}

- (BOOL)set_initInfo {
    return YES;
}

- (void)services_getAD {
    
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.拿到启动页，闪屏过渡
    self.adView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.adView.contentMode = UIViewContentModeScaleAspectFill;
    self.adView.userInteractionEnabled = YES;
    self.adView.image = ({
        UIStoryboard *lsStoryboard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
        UIViewController *lsStoryboardVC = [lsStoryboard instantiateInitialViewController];
        [lsStoryboardVC.view kh_getViewImage];
    });
    [self.view addSubview:self.adView];
    if ([KHTools isDEBUG]) {
        [self.adView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adViewClick)]];
    }
    
    //2.初始化相关信息
    if (![self set_initInfo]) {
        return;
    }
    
    //3.闪屏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat gW = 67;
        CGFloat gH = 30;
        CGFloat gX = KHScreenWidth - gW - KH15Margin;
        CGFloat gY = self.kh_Top - 44 + KH15Margin;
        self.goBtn = [[UIButton alloc] initWithFrame:CGRectMake(gX, gY, gW, gH)];
        [self.goBtn kh_setRBgImgWithNormal:KH_RGBA(0, 0, 0, 0.5) Selected:KH_RGBA(0, 0, 0, 0.5)];
        [self.goBtn addTarget:self action:@selector(adViewClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.goBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.goBtn setTitle:@"跳过" forState:(UIControlStateNormal)];
        self.goBtn.titleLabel.font = KHFont12;
        self.goBtn.alpha = 0;
        [self.view addSubview:self.goBtn];
        
        ///获取广告页
        [self services_getAD];
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)kh_successWithImageUrl:(NSString *)imageUrl {
    KHWeakObj(self);
    [UIView kh_downloadImage:imageUrl PlaceholderImage:nil Complete:^(UIImage *image) {
        if (image == nil) {
            [weakSelf adViewClick];
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
            NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:str];
            [aStr addAttribute:NSForegroundColorAttributeName
                         value:[KHTools kh_getThemeColor]
                         range:NSMakeRange(3, str.length - 3)];
            [weakSelf.goBtn setAttributedTitle:aStr forState:(UIControlStateNormal)];
            
        } endAction:^{
            [weakSelf adViewClick];
            
        }];
    }];
}

///点击了闪屏
- (void)adViewClick {
    [self kh_goHomeWithAnimDelay:0];
}

///去主页
- (void)kh_goHomeWithAnimDelay:(CGFloat)delay {
    if (self.adView.tag != 0) {
        return;
    }
    self.adView.tag = 10086;
    
    //这里要进行骚操作
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController = [self get_homeController];
    
    //过渡动画
    UIImageView *aView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    aView.contentMode = UIViewContentModeScaleAspectFill;
    aView.image = self.adView.image;
    [[UIApplication sharedApplication].keyWindow addSubview:aView];
    [UIView animateWithDuration:0.3 delay:delay options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        aView.alpha = 0;
    } completion:^(BOOL finished) {
        [aView removeFromSuperview];
    }];
}

@end
