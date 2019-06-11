//
//  UIView+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "KHealthToolsHeader.h"
#import "UIView+KHTsCategory.h"

@implementation UIView (KHTsCategory)

#pragma mark 找到View所在的控制器
- (UINavigationController *)kh_getNavigationController{
    return [self kh_getViewController].navigationController;
}

- (UIViewController *)kh_getViewController{
    /// 找到view所在的控制器
    // 遍历响应者链条，找到第一个控制器就为该View所在的控制器
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])){
        
        if ([responder isKindOfClass: [UIViewController class]]){
            return ((UIViewController *)responder);
        }
    }
    return nil;
}

///找到指定名称的子视图
- (UIView *)kh_subViewOfClassName:(NSString *)className {
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
            
        }
        UIView* resultFound = [subView kh_subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
            
        }
    }
    return nil;
}

#pragma mark 设置view中所有控件的scrollsToTop
+ (void)kh_scrollsToTopWithViews:(NSArray *)views{
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        if ([[obj class] isSubclassOfClass:[UIScrollView class]]){
            
            ((UIScrollView *)obj).scrollsToTop = NO;
        }
        [self kh_scrollsToTopWithViews:view.subviews];
    }];
}

#pragma mark - 获取控件Text的Size
- (CGFloat)kh_getHeight{
    return [self kh_getHeightWithMaxWidth:self.kh_width];
}

- (CGFloat)kh_getHeightWithMaxWidth:(CGFloat)maxWidth{
    NSString *text = @"";
    UIFont   *font = nil;
    
    if ([[self class] isSubclassOfClass:[UILabel class]]){
        text = ((UILabel *)self).text;
        font = ((UILabel *)self).font;
    }
    if ([[self class] isSubclassOfClass:[UIButton class]]){
        text = ((UIButton *)self).titleLabel.text;
        font = ((UIButton *)self).titleLabel.font;
    }
    if (font == nil) {
        font = KHFont(0.1f);
    }
    
    return [NSString kh_sizeWithText:text font:font maxSize:CGSizeMake(maxWidth, MAXFLOAT)].height;
}

///获取View的截图
-(UIImage *)kh_getViewImage{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.将控制器view的layer渲染到上下文
    [self.layer renderInContext:ctx];
    
    //3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.结束上下文
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:newImage.CGImage];
}

@end
