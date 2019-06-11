//
//  NSString+KHAttributes.h
//  KHealthTools
//
//  Created by zhi fang on 2018/11/21.
//

#import <Foundation/Foundation.h>
@class KHAttributesConfig;

@interface NSString (KHAttributesCategory)

//设置富文本相对应的字符串属性
- (NSMutableAttributedString *)setAttributeWithConfig:(NSArray<KHAttributesConfig *>*(^)(void))config;

@end

@interface KHAttributesConfig : NSObject

//属性字典
@property (nonatomic, strong) NSDictionary *attributesDic;
//对于字符串
@property (nonatomic, strong) NSString *characterStr;

- (KHAttributesConfig *(^)(NSDictionary *attributes))attributes_dic;

- (KHAttributesConfig * (^)(NSString *character))character_str;

@end
