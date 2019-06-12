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
    return [UIImage imageNamed:@"kh_head_placeholder"];
}

///获取占位图
+ (UIImage *)kh_getImage_normal_placeholder {
    return [UIImage imageNamed:@"kh_normal_placeholder"];
}

#pragma mark - 获取主题配置
+ (NSDictionary *)getNaviConfigDict {
    static NSDictionary *serviceDomainDict;
    if (serviceDomainDict == nil) {
        NSString *originPath = [[NSBundle mainBundle] pathForResource:@"khts_navi_config" ofType:@"plist"];
        serviceDomainDict = [[NSDictionary alloc] initWithContentsOfFile:originPath];
    }
    return serviceDomainDict;
}

+ (UIColor *)getConfigColor:(NSString *)key NormalColor:(UIColor *)nColor {
    NSString *colorStr = [NSString kh_str:[self getNaviConfigDict][key] Normal:@"a"];
    NSArray *colorS = [colorStr componentsSeparatedByString:@","];
    
    if (colorS.count < 3) {
        return nColor;
    } else {
        return KH_RGB([colorS[0] integerValue], [colorS[1] integerValue], [colorS[2] integerValue]);
    }
}

+ (UIImage *)getConfigImage:(NSString *)key NormalImage:(NSString *)nImgStr {
    NSString *backIcon = [self getNaviConfigDict][key];
    if (![[NSString kh_str:backIcon Normal:@"abc"] isEqualToString:@"abc"]) {
        return [UIImage imageNamed:backIcon];
    } else {
        return [KHTools kh_getToolsBundleImage:nImgStr];
    }
}

#pragma mark - 导航栏
+ (UIImage *)naviBackImg {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools getConfigImage:@"navi_back_icon" NormalImage:@"kht_nav_back"];
    }
    return img;
}

+ (UIImage *)naviBackImg_White {
    static UIImage *img = nil;
    if (img == nil) {
        img = [KHTools getConfigImage:@"navi_back_icon_white" NormalImage:@"kht_nav_back_white"];
    }
    return img;
}

+ (UIFont *)naviTitleFont {
    static UIFont *font = nil;
    if (font == nil) {
        NSInteger fontSize = [([self getNaviConfigDict][@"navi_title_font"]) integerValue];
        if (fontSize <= 0) {
            font = KHFont(17.0);
        } else {
            if (fontSize > 100) {
                font = KHBoldFont(fontSize % 100);
            } else {
                font = KHFont(fontSize);
            }
        }
    }
    return font;
}

+ (UIColor *)naviTitleColor {
    return [KHTools getConfigColor:@"navi_title_color" NormalColor:KHColor333333];
}

#pragma mark - 主题颜色
+ (UIColor *)themeColor {
    static UIColor *theMeColor;
    if (theMeColor == nil) {
        theMeColor = [KHTools getConfigColor:@"theme_color" NormalColor:KH_RGB(38, 183, 188)];
    }
    return theMeColor;
}

+ (UIColor *)themeColor2 {
    static UIColor *theMeColor;
    if (theMeColor == nil) {
        theMeColor = [KHTools getConfigColor:@"theme_color2" NormalColor:KH_RGB(146, 219, 221)];
    }
    return theMeColor;
}

#pragma mark - 箭头
+ (UIImage *)arrowImg_Right {
    return [KHTools kh_getToolsBundleImage:@"kht_arrow_right"];
}

+ (UIImage *)arrowImg_Up {
    return [KHTools kh_getToolsBundleImage:@"kht_arrow_up"];
}

+ (UIImage *)arrowImg_Down {
    return [KHTools kh_getToolsBundleImage:@"kht_arrow_down"];
}

#pragma mark - 选择按钮
+ (UIImage *)chooseImg_Sel {
    return [KHTools kh_getToolsBundleImage:@"kht_choose_sel"];
}

+ (UIImage *)chooseImg_Sel_White {
    return [KHTools kh_getToolsBundleImage:@"kht_choose_sel_white"];
}

+ (UIImage *)chooseImg_Nor {
    return [KHTools kh_getToolsBundleImage:@"kht_choose_nor"];
}

+ (UIImage *)chooseImg_End {
    return [KHTools kh_getToolsBundleImage:@"kht_choose_end"];
}

@end
