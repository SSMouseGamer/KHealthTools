//
//  CALayer+WebCacheOperation.h
//  KHealthTools
//
//  Created by kim on 2019/2/22.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SDWebImageCompat.h"
#import "SDWebImageOperation.h"

@interface CALayer (WebCacheOperation)

/**
 设置图片的缓存

 @param operation operation description
 @param key 缓存的key
 */
- (void)sd_setImageLoadOperation:(nullable id<SDWebImageOperation>)operation forKey:(nullable NSString *)key;


/**
 取消当前layer的图片缓存和key

 @param key 标志当前操作的key
 */
- (void)sd_cancelImageLoadOperationWithKey:(nullable NSString *)key;


/**
 在未取消缓存之前，移除当前layer的缓存和key

 @param key 标志当前操作的key
 */
- (void)sd_removeImageLoadOperationWithKey:(nullable NSString *)key;

@end
