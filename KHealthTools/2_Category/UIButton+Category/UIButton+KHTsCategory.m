//
//  UIButton+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "KHealthToolsHeader.h"
#import "UIButton+KHTsCategory.h"

@implementation UIButton (KHTsCategory)

- (void)kh_setBgImgWithNormal:(UIColor *)normal {
    UIImage *nImage = [normal kh_getImageWithSize:self.kh_size Radius:0];
    [self setBackgroundImage:nImage forState:(UIControlStateNormal)];
    
    CGFloat r=0, g=0, b=0, a=0;
    BOOL success = [normal getRed:&r green:&g blue:&b alpha:&a];
    UIColor *highlighted = normal;
    if (success) {
        highlighted = KH_RGBA(r * 255, g * 255, b * 255, a * 0.5);
    }
    UIImage *hImage = [highlighted kh_getImageWithSize:self.kh_size Radius:0];
    [self setBackgroundImage:hImage forState:(UIControlStateHighlighted)];
    [self setBackgroundImage:hImage forState:(UIControlStateDisabled)];
}

- (void)kh_setBgImgWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted {
    UIImage *nImage = [normal kh_getImageWithSize:self.kh_size Radius:0];
    UIImage *hImage = [highlighted kh_getImageWithSize:self.kh_size Radius:0];
    [self setBackgroundImage:nImage forState:(UIControlStateNormal)];
    [self setBackgroundImage:hImage forState:(UIControlStateHighlighted)];
    [self setBackgroundImage:hImage forState:(UIControlStateDisabled)];
}

- (void)kh_setBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected {
    UIImage *nImage = [normal kh_getImageWithSize:self.kh_size Radius:0];
    UIImage *sImage = [selected kh_getImageWithSize:self.kh_size Radius:0];
    [self setBackgroundImage:nImage forState:(UIControlStateNormal)];
    [self setBackgroundImage:sImage forState:(UIControlStateHighlighted)];
    [self setBackgroundImage:sImage forState:(UIControlStateSelected)];
}

- (void)kh_setRBgImgWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted {
    [self kh_setRBgImgWithNormal:normal Highlighted:highlighted Radius:self.kh_height * 0.5];
}

- (void)kh_setRBgImgWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted Radius:(CGFloat)r {
    UIImage *nImage = [normal kh_getImageWithSize:self.kh_size Radius:r];
    UIImage *hImage = [highlighted kh_getImageWithSize:self.kh_size Radius:r];
    [self setBackgroundImage:nImage forState:(UIControlStateNormal)];
    [self setBackgroundImage:hImage forState:(UIControlStateHighlighted)];
    [self setBackgroundImage:hImage forState:(UIControlStateDisabled)];
}

- (void)kh_setRBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected {
    [self kh_setRBgImgWithNormal:normal Selected:selected Highlighted:selected Radius:self.kh_height * 0.5];
}

- (void)kh_setRBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected Radius:(CGFloat)r {
    [self kh_setRBgImgWithNormal:normal Selected:selected Highlighted:selected Radius:r];
}

- (void)kh_setRBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected Highlighted:(UIColor *)highlighted Radius:(CGFloat)r {
    UIImage *nImage = [normal kh_getImageWithSize:self.kh_size Radius:r];
    UIImage *sImage = [selected kh_getImageWithSize:self.kh_size Radius:r];
    UIImage *hImage = [highlighted kh_getImageWithSize:self.kh_size Radius:r];
    [self setBackgroundImage:nImage forState:(UIControlStateNormal)];
    [self setBackgroundImage:sImage forState:(UIControlStateSelected)];
    [self setBackgroundImage:hImage forState:(UIControlStateHighlighted)];
}

- (void)kh_setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:(UIControlStateNormal)];
    CGFloat r=0, g=0, b=0, a=0;
    BOOL success = [color getRed:&r green:&g blue:&b alpha:&a];
    if (success) {
        [self setTitleColor:KH_RGBA(r * 255, g * 255, b * 255, a * 0.5) forState:(UIControlStateHighlighted)];
    } else {
        [self setTitleColor:KH_RGBA(0, 0, 0, 0.5) forState:(UIControlStateHighlighted)];
    }
}

- (void)kh_setTitleColorWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted {
    [self setTitleColor:normal forState:(UIControlStateNormal)];
    [self setTitleColor:highlighted forState:(UIControlStateHighlighted)];
}

- (void)kh_setTitleColorWithNormal:(UIColor *)normal Selected:(UIColor *)selected {
    [self setTitleColor:normal forState:(UIControlStateNormal)];
    [self setTitleColor:selected forState:(UIControlStateSelected)];
}

- (void)kh_setTitleColorWithNormal:(UIColor *)normal Selected:(UIColor *)selected Highlighted:(UIColor *)highlighted {
    [self setTitleColor:normal forState:(UIControlStateNormal)];
    [self setTitleColor:selected forState:(UIControlStateSelected)];
    [self setTitleColor:highlighted forState:(UIControlStateHighlighted)];
}

@end
