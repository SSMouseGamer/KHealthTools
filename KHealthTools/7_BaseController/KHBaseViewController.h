//
//  KHBaseViewController.h
//  KHealthModules
//
//  Created by 李云新 on 2018/10/12.
//

#import <UIKit/UIKit.h>

@interface KHBaseViewController : UIViewController

@property (nonatomic, strong) UIView  *naviBGV;
@property (nonatomic, strong) CALayer *naviBGL;

/**适配用到的*/
@property (nonatomic, assign) CGFloat kh_Top;
@property (nonatomic, assign) CGFloat kh_Bottom;
@property (nonatomic, assign) CGFloat kh_W;
@property (nonatomic, assign) CGFloat kh_H;
@property (nonatomic, assign) CGRect  kh_Rect;

@end
