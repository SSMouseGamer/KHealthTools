//
//  UIImage+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "UIImage+KHTsCategory.h"
#import "UIView+KHTsCategory.h"

@implementation UIImage (KHTsCategory)

+ (UIImage *)kh_getImage:(UIImage *)image size:(CGSize)size{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = image;
    return [imageView kh_getViewImage];
}

- (UIImage *)kh_zipImage {
    UIImage *newImage = self;
    NSData *imageData = UIImageJPEGRepresentation(newImage, 1.0);
    
    CGFloat scale = 1.0;
    while (imageData.length / 1000 > 10 && scale >= 0) {
        
        UIGraphicsBeginImageContext(CGSizeMake(newImage.size.width * 0.1, newImage.size.height * 0.1));
        [newImage drawInRect:CGRectMake(0,0,newImage.size.width * 0.1,newImage.size.height * 0.1)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imageData = UIImageJPEGRepresentation(newImage,scale);
        scale -= 0.1;
        NSLog(@"scale = %f 大于啊 %d",scale,(int)(imageData.length / 1000));
    }
    return newImage;
}

- (NSData *)kh_zipImageToByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

@end
