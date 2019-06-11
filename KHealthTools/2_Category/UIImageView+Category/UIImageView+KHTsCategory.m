//
//  UIImageView+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "KHealthToolsHeader.h"
#import "UIImageView+KHTsCategory.h"

@implementation UIImageView (KHTsCategory)

- (void)kh_addRadiusMask {
    CALayer *mask = [CALayer layer];
    
    static UIImage *maskImg = nil;
    if (maskImg == nil) {
       maskImg = [KHTools kh_getToolsBundleImage:@"kht_icon_mask"];
    }
    mask.contents = (id)maskImg.CGImage;
    mask.frame = self.bounds;
    self.layer.mask = mask;
    self.layer.masksToBounds = YES;
}

@end
