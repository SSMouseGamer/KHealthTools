//
//  KHToolsBaseFont.h
//  KHealthTools
//
//  Created by 李云新 on 2019/3/8.
//

#define KHFont11 [KHTools share].font11
#define KHFont12 [KHTools share].font12
#define KHFont13 [KHTools share].font13
#define KHFont14 [KHTools share].font14
#define KHFont15 [KHTools share].font15
#define KHFont16 [KHTools share].font16
#define KHFont18 [KHTools share].font18

#define KHAutoFont11 [KHTools share].autoFont11
#define KHAutoFont12 [KHTools share].autoFont12
#define KHAutoFont13 [KHTools share].autoFont13
#define KHAutoFont14 [KHTools share].autoFont14
#define KHAutoFont15 [KHTools share].autoFont15
#define KHAutoFont16 [KHTools share].autoFont16
#define KHAutoFont18 [KHTools share].autoFont18

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KHToolsBaseFont : NSObject

///工具单例
+ (instancetype)share;

///用于字体缩放的比例系数，默认1.0，最大2.0
@property (nonatomic, assign, readonly) CGFloat fontScale;
///保存设置的缩放比例
- (void)saveFontScale:(CGFloat)fontScale;

#pragma mark -
@property (nonatomic, strong, readonly) UIFont *font11;
@property (nonatomic, strong, readonly) UIFont *font12;
@property (nonatomic, strong, readonly) UIFont *font13;
@property (nonatomic, strong, readonly) UIFont *font14;
@property (nonatomic, strong, readonly) UIFont *font15;
@property (nonatomic, strong, readonly) UIFont *font16;
@property (nonatomic, strong, readonly) UIFont *font18;
@property (nonatomic, strong, readonly) UIFont *autoFont11;
@property (nonatomic, strong, readonly) UIFont *autoFont12;
@property (nonatomic, strong, readonly) UIFont *autoFont13;
@property (nonatomic, strong, readonly) UIFont *autoFont14;
@property (nonatomic, strong, readonly) UIFont *autoFont15;
@property (nonatomic, strong, readonly) UIFont *autoFont16;
@property (nonatomic, strong, readonly) UIFont *autoFont18;

@end
