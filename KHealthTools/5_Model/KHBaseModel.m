//
//  KHBaseModel.m
//  AFNetworking
//
//  Created by 李云新 on 2018/11/12.
//

#import "KHBaseModel.h"
#import "YYModel.h"

@implementation KHBaseModel

+ (instancetype)kh_modelWithDictionary:(NSDictionary *)dictionary {
    return [self yy_modelWithDictionary:dictionary];
}

- (BOOL)kh_modelSetWithDictionary:(NSDictionary *)dic {
    return [self yy_modelSetWithDictionary:dic];
}

- (BOOL)yy_modelSetWithDictionary:(NSDictionary *)dic {
    BOOL b = [super yy_modelSetWithDictionary:dic];
    [self setupData];
    return b;
}

+ (NSArray *)kh_modelWithArray:(NSArray *)dictArray {
    NSMutableArray *dataArray = [NSMutableArray array];
    
    if (![dictArray isKindOfClass:[NSArray class]]){
        return dictArray;
    }
    
    for (NSDictionary *dict in dictArray) {
        [dataArray addObject:[self kh_modelWithDictionary:dict]];
    }
    return dataArray;
}

- (NSDictionary *)kh_modelToJSONDict {
    return [self yy_modelToJSONObject];
}

- (void)setupData {
    
}

@end
