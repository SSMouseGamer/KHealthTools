//
//  KHBaseViewController.m
//  KHealthModules
//
//  Created by 李云新 on 2018/10/12.
//

#import "KHealthToolsHeader.h"
#import "KHBaseViewController.h"

@interface KHBaseViewController ()

@end

@implementation KHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = KHColorF5F5F5;
    
    //返回按钮文字隐藏
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //设置适配用到的Frame
    [self setFrameParameter];
    
    //自定义导航栏背景
    self.naviBGV = [[UIView alloc] initWithFrame:CGRectMake(0, -self.kh_Top, self.kh_W, self.kh_Top)];
    self.naviBGV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.naviBGV];
    self.naviBGL = [self.naviBGV kh_addLineBottomWithX:0];
}

-(void)dealloc {
    KHLog(@"dealloc - %@",[self class]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - 适配使用
-(void)setFrameParameter{
    self.kh_Top = KH_Navi_Height;
    self.kh_Bottom = KH_Bottom_Height;
    
    //计算可用高度，kh_H = 屏幕高度 - 状态栏高度 - 导航栏高度 - 工具栏底部高度
    self.kh_H = KHScreenHeight - self.kh_Top - self.kh_Bottom;
    if (self.navigationController.viewControllers.count == 1) {
        //若为控制器第一个，则减去工具栏高度
        self.kh_H -= 49.0;
    }
    self.kh_W = KHScreenWidth;
    self.kh_Rect = CGRectMake(0, 0, self.kh_W, self.kh_H);
}

@end
