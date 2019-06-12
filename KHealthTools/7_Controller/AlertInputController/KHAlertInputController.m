//
//  KHAlertInputController.m
//  KHealthTools
//
//  Created by 李云新 on 2019/6/12.
//

#import "KHealthToolsHeader.h"
#import "KHAlertInputController.h"

@interface KHAlertInputController () <UITextFieldDelegate>

@property (nonatomic,   copy) NSString      *i_title;
@property (nonatomic, assign) NSInteger      i_maxLength;
@property (nonatomic,   copy) NSString      *i_placeholder;
@property (nonatomic, assign) UIKeyboardType i_keyboardType;
@property (nonatomic,   copy) void (^completeOption)(NSString *outputTitle);

@end

@implementation KHAlertInputController

+ (void)inputWithTitle:(NSString *)title Placeholder:(NSString *)placeholder MaxLength:(NSInteger)length KeyboardType:(UIKeyboardType)keyboardType CompleteOption:(void (^)(NSString *outputTitle))completeOption {
    
    KHAlertInputController *alert = [self alertControllerWithTitle:placeholder message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    alert.completeOption = completeOption;
    alert.i_title        = title;
    alert.i_maxLength    = length;
    alert.i_keyboardType = keyboardType;
    alert.i_placeholder  = placeholder;
    [alert setupSubView];
    [[KHTools kh_getTopVC] presentViewController:alert animated:YES completion:nil];
}

- (void)setupSubView {
    KHWeakObj(self);
    [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = weakSelf.i_title;
        textField.delegate     = weakSelf;
        textField.textColor    = KHColor333333;
        textField.keyboardType = weakSelf.i_keyboardType;
        textField.placeholder     = weakSelf.i_placeholder;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    [self addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textF = weakSelf.textFields.firstObject;
        if (weakSelf.completeOption) {
            weakSelf.completeOption(textF.text);
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }]];
    [self addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return textField.text.length >= self.i_maxLength ? NO : YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length > self.i_maxLength) {
        textField.text = [textField.text substringFromIndex:self.i_maxLength];
    }
}

@end
