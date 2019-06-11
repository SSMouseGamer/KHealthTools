//
//  UIButton+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import <UIKit/UIKit.h>

@interface UIButton (KHTsCategory)

- (void)kh_setBgImgWithNormal:(UIColor *)normal;
- (void)kh_setBgImgWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted;
- (void)kh_setBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected;

- (void)kh_setRBgImgWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted;
- (void)kh_setRBgImgWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted Radius:(CGFloat)r;
- (void)kh_setRBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected;
- (void)kh_setRBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected Radius:(CGFloat)r;
- (void)kh_setRBgImgWithNormal:(UIColor *)normal Selected:(UIColor *)selected Highlighted:(UIColor *)highlighted Radius:(CGFloat)r;

- (void)kh_setTitleColor:(UIColor *)color;
- (void)kh_setTitleColorWithNormal:(UIColor *)normal Highlighted:(UIColor *)highlighted;
- (void)kh_setTitleColorWithNormal:(UIColor *)normal Selected:(UIColor *)selected;
- (void)kh_setTitleColorWithNormal:(UIColor *)normal Selected:(UIColor *)selected Highlighted:(UIColor *)highlighted;

@end
