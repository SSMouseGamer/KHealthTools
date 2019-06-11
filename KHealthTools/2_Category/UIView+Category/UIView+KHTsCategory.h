//
//  UIView+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import <UIKit/UIKit.h>

@interface UIView (KHTsCategory)

/**设置view中所有控件的scrollsToTop */
+ (void)kh_scrollsToTopWithViews:(NSArray *)views;

/**找到View所在的控制器*/
- (UIViewController *)kh_getViewController;
- (UINavigationController *)kh_getNavigationController;

///找到指定名称的子视图
- (UIView *)kh_subViewOfClassName:(NSString *)className;

///获取View的截图
- (UIImage *)kh_getViewImage;

///获取Label的Size相关
- (CGFloat)kh_getHeight;
- (CGFloat)kh_getHeightWithMaxWidth:(CGFloat)maxWidth;

@end
