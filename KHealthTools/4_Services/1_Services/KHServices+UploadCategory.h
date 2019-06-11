//
//  KHServices+UploadCategory.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/22.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHServices.h"

@interface KHServices (UploadCategory)

///单个图片数据上传 - 如使用默认域名，则doMain传nil
- (void)uploadWithDoMain:(NSString *)doMain
                    Path:(NSString *)path
                   Param:(NSDictionary *)param
               ImageData:(NSData *)imgData
                Complete:(KHServicesAnyOption)cBlock;

/**
 批量多图片上传 - 如使用默认域名，则doMain传nil

 @param doMain 域名
 @param path 路径
 @param param 请求参数
 @param imageDataArray 图片数据
 @param pBlock 进度回调，假的没做
 @param cBlock 结果回调
 */
- (void)multiFileUploadWithDoMain:(NSString *)doMain
                             Path:(NSString *)path
                            Param:(NSDictionary *)param
                     ImageDataArr:(NSArray <NSData *>*)imageDataArray
                         Progress:(void(^)(CGFloat currentProgress))pBlock
                         Complete:(KHServicesArrayOption)cBlock;

@end
