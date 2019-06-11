//
//  KHPhotoModel.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHPhotoModel.h"

@implementation KHPhotoModel

+ (instancetype)initWithAsset:(PHAsset *)asset cacheImage:(UIImage *)cacheImage urlStr:(NSString *)urlStr {
    NSMutableDictionary *adict = [NSMutableDictionary dictionary];
    [adict setValue:asset forKey:@"asset"];
    [adict setValue:cacheImage forKey:@"cacheImage"];
    [adict setValue:urlStr forKey:@"imageUrlStr"];
    KHPhotoModel *model = [super kh_modelWithDictionary:adict];
    return model;
}

@end
