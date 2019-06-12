//
//  KHTools+KHTsGetImageCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/19.
//

#import "KHealthToolsHeader.h"
#import "KHTools+KHTsGetImageCategory.h"

@implementation KHTools (KHTsGetImageCategory)

///获取头像占位图
+ (UIImage *)kh_getImage_head_placeholder {
    static UIImage *img = nil;
    if (img == nil) {
        img = [UIImage imageNamed:@"kh_head_placeholder"];
    }
    return img;
}

///获取占位图
+ (UIImage *)kh_getImage_normal_placeholder {
    static UIImage *img = nil;
    if (img == nil) {
        img = [UIImage imageNamed:@"kh_normal_placeholder"];
    }
    return img;
}

#pragma mark -
+ (NSDictionary *)kh_getNaviConfigDict {
    static NSDictionary *serviceDomainDict;
    if (serviceDomainDict == nil) {
        NSString *originPath = [[NSBundle mainBundle] pathForResource:@"khts_navi_config"
                                                               ofType:@"plist"];
        serviceDomainDict = [[NSDictionary alloc] initWithContentsOfFile:originPath];
    }
    
    return serviceDomainDict;
}

+ (UIFont *)kh_getNaviTitleFont {
    NSInteger fontSize = [([self kh_getNaviConfigDict][@"navi_title_font"]) integerValue];
    if (fontSize <= 0) {
        return KHFont(17.0);
    }
    if (fontSize > 100) {
        return KHBoldFont(fontSize % 100);
    } else {
        return KHFont(fontSize);
    }
}

+ (UIColor *)kh_getNaviTitleColor {
    NSString *colorStr = [self kh_getNaviConfigDict][@"navi_title_color"];
    
    if ([[NSString kh_str:colorStr Normal:@"abc"] isEqualToString:@"abc"]) {
        return KHColor333333;
    }
    
    NSArray *colorS = [colorStr componentsSeparatedByString:@","];
    if (colorS.count < 3) {
        return KHColor333333;
    }
    
    return KH_RGB([colorS[0] integerValue], [colorS[1] integerValue], [colorS[2] integerValue]);
}

+ (UIColor *)kh_getThemeColor {
    NSString *colorStr = [self kh_getNaviConfigDict][@"theme_color"];
    
    if ([[NSString kh_str:colorStr Normal:@"abc"] isEqualToString:@"abc"]) {
        return KH_RGBA( 38, 183, 188, 1);
    }
    
    NSArray *colorS = [colorStr componentsSeparatedByString:@","];
    if (colorS.count < 3) {
        return KH_RGBA( 38, 183, 188, 1);
    }
    
    return KH_RGB([colorS[0] integerValue], [colorS[1] integerValue], [colorS[2] integerValue]);
    
}

#pragma mark - - 导航栏返回按钮 ------------------------------------------------------
+ (UIImage *)kh_getImage_naviBack {
    static UIImage *img = nil;
    if (img == nil) {
        NSString *backIcon = [self kh_getNaviConfigDict][@"navi_back_icon"];
        if (![[NSString kh_str:backIcon Normal:@"abc"] isEqualToString:@"abc"]) {
            img = [UIImage imageNamed:backIcon];
        } else {
            img = [KHTools kh_getToolsBundleImage:@"kht_nav_back"];
        }
    }
    return img;
}

+ (UIImage *)kh_getImage_naviBack_White {
    static UIImage *img = nil;
    if (img == nil) {
        NSString *backIcon = [self kh_getNaviConfigDict][@"navi_back_icon_white"];
        if (![[NSString kh_str:backIcon Normal:@"abc"] isEqualToString:@"abc"]) {
            img = [UIImage imageNamed:backIcon];
        } else {
            img = [KHTools kh_getToolsBundleImage:@"kht_nav_back_white"];
        }
    }
    return img;
}

#pragma mark - - 箭头 ------------------------------------------------------
+ (UIImage *)kh_getImage_Aarrow_Right {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools kh_getToolsBundleImage:@"kht_arrow_right"];
    }
    return img;
}

+ (UIImage *)kh_getImage_Aarrow_Up {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools kh_getToolsBundleImage:@"kht_arrow_up"];
    }
    return img;
}

+ (UIImage *)kh_getImage_Aarrow_Down {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools kh_getToolsBundleImage:@"kht_arrow_down"];
    }
    return img;
}

#pragma mark - - 选择按钮 --------------------------------------------------
+ (UIImage *)kh_getImage_Choose_Sel {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools kh_getToolsBundleImage:@"kht_choose_sel"];
    }
    return img;
}

+ (UIImage *)kh_getImage_Choose_Sel_White {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools kh_getToolsBundleImage:@"kht_choose_sel_white"];
    }
    return img;
}

+ (UIImage *)kh_getImage_Choose_Nor {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools kh_getToolsBundleImage:@"kht_choose_nor"];
    }
    return img;
}

+ (UIImage *)kh_getImage_Choose_End {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools kh_getToolsBundleImage:@"kht_choose_end"];
    }
    return img;
}

@end
