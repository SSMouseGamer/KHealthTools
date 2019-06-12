//
//  KHAlertInputController.h
//  KHealthTools
//
//  Created by 李云新 on 2019/6/12.
//

#import <UIKit/UIKit.h>

@interface KHAlertInputController : UIAlertController

+ (void)inputWithTitle:(NSString *)title
           Placeholder:(NSString *)placeholder
             MaxLength:(NSInteger)length
          KeyboardType:(UIKeyboardType)keyboardType
        CompleteOption:(void (^)(NSString *outputTitle))completeOption;

@end

