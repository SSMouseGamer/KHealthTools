//
//  NSString+KHAttributes.m
//  KHealthTools
//
//  Created by zhi fang on 2018/11/21.
//

#import "NSString+KHAttributesCategory.h"

@implementation NSString (KHAttributesCategory)

- (NSMutableAttributedString *)setAttributeWithConfig:(NSArray<KHAttributesConfig *> * (^)(void))config{
    if(!self) return nil;
    
    if(config){
        NSArray *configArr = config();
        NSString *str = (NSString *)self;
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        for(KHAttributesConfig *cf in configArr){
            NSRange range = [str rangeOfString:cf.characterStr];
            if (range.location == NSNotFound) {
                continue;
            }
            [attributeStr addAttributes:cf.attributesDic range:range];
        }
        return attributeStr;
    }
    return nil;
}

@end

@implementation KHAttributesConfig

- (KHAttributesConfig * (^) (NSDictionary *))attributes_dic{
    return ^id(NSDictionary *attributesDic){
        self.attributesDic = attributesDic?:@{};
        return self;
    };
}

- (KHAttributesConfig * (^) (NSString *))character_str{
    return ^id(NSString *characterStr){
        self.characterStr = characterStr?:@"";
        return self;
    };
}

@end
