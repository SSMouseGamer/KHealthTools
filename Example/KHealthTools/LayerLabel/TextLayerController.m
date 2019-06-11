//
//  TextLayerController.m
//  KHealthTools
//
//  Created by kim on 2019/3/7.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "TextLayerController.h"
#import <KHealthTools/KHealthTools.h>
#import "LayerLabel.h"
#import "TextLayerCell.h"

@interface TextLayerController()

@property (nonatomic, strong) LayerLabel *textL;

@property (nonatomic, strong) UILabel *text;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TextLayerController

- (void)valueChange:(UITextField *)textField {
    NSString *text = textField.text;
    if ([text kh_deal_intBit5_decimalBit2]) {
        NSLog(@"正确");
    } else {
        KHLog(@"2333 ----- %ld",(long)text.length);
    }
}

- (void)changeClick {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
//        NSMutableAttributedString *astr = [@"阿斯顿发就阿斯利2qwahaaahahhah大家放假就放假放假放假放假放假大家放假就放就放" setAttributeWithConfig:^NSArray<KHAttributesConfig *> *{
//            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//            paragraph.lineSpacing = 20.0;
//            KHAttributesConfig *config = [[KHAttributesConfig alloc] init];
//            config.character_str(@"阿斯顿发就阿斯利");
//            config.attributes_dic(@{NSFontAttributeName:KHBFontOfSize(18),
//                                    NSParagraphStyleAttributeName:paragraph});
//            return @[config];
//        }];
        do {
            [self.dataArray addObject:@"阿斯顿发就阿斯利2qwahaaahahhah大家放假就放假放假放假放假放假大家放假就放就放"];
        } while (self.dataArray.count < 1);
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"调整" style:(UIBarButtonItemStyleDone) target:self action:@selector(changeClick)];
    
    self.tableView.rowHeight = 60.0;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, KHScreenWidth, 100)];
    [textField addTarget:self action:@selector(valueChange:) forControlEvents:(UIControlEventEditingChanged)];
    textField.keyboardType = UIKeyboardTypePhonePad;
    textField.font = KHFont15;
//    textField.backgroundColor = KHColorF5F5F5;
    self.tableView.tableHeaderView = textField;
    
    [[UIApplication sharedApplication] kh_setStatusBarHidden:YES];
}

- (void)dealloc {
    [[UIApplication sharedApplication] kh_setStatusBarHidden:NO];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextLayerCell *cell = [TextLayerCell aaaCellWithTable:tableView];
    cell.textL.text = self.dataArray[indexPath.row];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [cell testFunc];
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
