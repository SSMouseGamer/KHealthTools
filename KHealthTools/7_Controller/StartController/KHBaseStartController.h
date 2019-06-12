//
//  KHBaseStartController.h
//  KHealthModules
//
//  Created by 李云新 on 2019/3/18.
//

#import "KHClearNaviController.h"

@interface KHBaseStartController : KHClearNaviController

@property (nonatomic, strong) UIButton *goBtn;
@property (nonatomic, strong) UIImageView *adView;

///配置跳转主页
- (UIViewController *)get_homeController;

///进行闪屏页获取之前的应用or用户信息获取。@return YES:信息初始化成功，可进行广告获取
- (BOOL)set_initInfo;

///网络访问获取闪屏
- (void)services_getAD;

#pragma mark -
///广告页获取成功，进行展示
- (void)kh_successWithImageUrl:(NSString *)imageUrl;
///去主页
- (void)kh_goHomeWithAnimDelay:(CGFloat)delay;

@end
