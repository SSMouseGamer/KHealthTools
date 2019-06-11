//
//  KHBaseModel.h
//  AFNetworking
//
//  Created by 李云新 on 2018/11/12.
//

#import <Foundation/Foundation.h>

@interface KHBaseModel : NSObject

+ (instancetype)kh_modelWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)kh_modelWithArray:(NSArray *)dictArray;

- (NSDictionary *)kh_modelToJSONDict;

- (void)setupData;

//DEPRECATED_ATTRIBUTE 不建议使用

@end
