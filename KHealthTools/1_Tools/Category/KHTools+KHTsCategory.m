//
//  KHTools+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/10.
//

#import "KHealthToolsHeader.h"
#import "KHTools+KHTsCategory.h"

@implementation KHTools (KHTsCategory)

///获取指定的Bundle
+ (NSBundle *)kh_getBundleWithClassName:(NSString *)className Resource:(NSString *)resource {
    return [NSBundle bundleWithPath:[[NSBundle bundleForClass:NSClassFromString(className)] pathForResource:resource ofType:@"bundle"]];
}

///在Bundle中获取图片
+ (UIImage *)kh_getImageWithBundle:(NSBundle *)bundle ImageName:(NSString *)imageName {
    if (imageName == nil || [imageName isEqualToString:@""]) {
        return nil;
    }
    
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    if (image == nil) {
        image = [UIImage imageNamed:imageName];
    }
    return image;
}

///获取KHealthTools这个Bundle的图片
+ (UIImage *)kh_getToolsBundleImage:(NSString *)imageName {
    static NSBundle *bundle;
    if (bundle == nil) {
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:NSClassFromString(@"KHealthTools")] pathForResource:@"KHealthTools" ofType:@"bundle"]];
    }
    
    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    if (image == nil) {
        image = [UIImage imageNamed:imageName];
    }
    
    return image;
}

#pragma mark - 
///获取指定View所在的导航控制器
+ (UINavigationController *)kh_getNaviVCForView:(UIView *)forView {
    return [KHTools kh_getNaviVC];
}

+ (UINavigationController *)kh_getNaviVC {
    id tb = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //1.最底层是Tabbar
    if ([tb isKindOfClass:[UITabBarController class]]) {
        UINavigationController *selVC = ((UITabBarController *)tb).selectedViewController;
        
        //1.1 有模态弹框
        if (selVC.presentedViewController) {
            if ([selVC.presentedViewController isKindOfClass:[UINavigationController class]]) {
                return (UINavigationController *)selVC.presentedViewController;
            }
            
            if ([selVC.presentedViewController isKindOfClass:[UIViewController class]]) {
                return selVC.presentedViewController.navigationController;
            }
            
            return [[UINavigationController alloc] init];
        }
        
        //1.2 直接拿到
        if ([selVC isKindOfClass:[UINavigationController class]]) {
            return selVC;
        }
        
        //1.3 呵呵
        return [[UINavigationController alloc] init];
    }
    
    //2.最底层是导航控制器
    if ([tb isKindOfClass:[UINavigationController class]]) {
        UINavigationController *selVC = tb;
        
        if (selVC.presentedViewController) {
            if ([selVC.presentedViewController isKindOfClass:[UINavigationController class]]) {
                return (UINavigationController *)selVC.presentedViewController;
            }
            
            if ([selVC.presentedViewController isKindOfClass:[UIViewController class]]) {
                return selVC.presentedViewController.navigationController;
            }
            
            return [[UINavigationController alloc] init];
        }
        
        return selVC;
    }
    
    //3.呵呵
    return [[UINavigationController alloc] init];
}

+ (UIViewController *)kh_getTopVC {
    return [KHTools kh_getNaviVC].topViewController;
}

@end
