//
//  KHTools+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/10.
//

#import "KHTools.h"

@interface KHTools (KHTsCategory)

///获取KHealthTools这个Bundle的图片
+ (UIImage *)kh_getToolsBundleImage:(NSString *)imageName;
///获取指定的Bundle
+ (NSBundle *)kh_getBundleWithClassName:(NSString *)className Resource:(NSString *)resource;
///在Bundle中获取图片
+ (UIImage *)kh_getImageWithBundle:(NSBundle *)bundle ImageName:(NSString *)imageName;

///获取当前的导航控制器。注意，不考虑present
+ (UINavigationController *)kh_getNaviVC;
///获取当前顶部的控制器。注意，不考虑present
+ (UIViewController *)kh_getTopVC;
///获取指定View所在的导航控制器
+ (UINavigationController *)kh_getNaviVCForView:(UIView *)forView;


@end
