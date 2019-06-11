//
//  KHFontSizeSettingController.m
//  KHealthTools
//
//  Created by kim on 2019/4/11.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHFontSizeSettingController.h"

///一共有6个缩放等级
#define KH_ELEMENT_NUM 6
///一个缩放等级的长度
#define KH_LINE_FIX_WIDTH (KHScreenWidth - KH15Margin * 4.0) / KH_ELEMENT_NUM
///目前一共有6个缩放等级，计算时为1-6的个位数，除以scale 然后 + 1.0，即为缩放倍率
#define KH_ELEMENT_SCALE 10.0

@interface KHFontSizeSettingController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

///列表数据
@property (nonatomic, strong) NSArray *dataArr;
///列表
@property (nonatomic, strong) UITableView *tableView;
///滑动手势
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
///滑动指示器
@property (nonatomic, strong) UIImageView *guideImgV;
///工具栏容器
@property (nonatomic, strong) UIView *toolBarView;

@property (nonatomic, assign) CGFloat currentScale;

@end

@implementation KHFontSizeSettingController

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:touch.view];
    CGFloat num = (location.x - KH15Margin * 2.0) / (float)(KH_LINE_FIX_WIDTH);
    self.guideImgV.kh_centerX = (int)num * KH_LINE_FIX_WIDTH + KH15Margin * 2.0;
    [self calculateFontSizeScale];
    return YES;
}

#pragma mark - 手势事件
///扫动
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    ///手指在视图上移动的位置（x,y）向下和向右为正，向上和向左为负
    CGPoint location = [pan locationInView:pan.view];
    if (pan.state == UIGestureRecognizerStateChanged) {
        //正在滑动
        CGFloat fix_w = KH15Margin * 2.0;
        if (location.x > KHScreenWidth - fix_w || location.x < fix_w) {
            return;
        }
        int avilable = (int)(KH_LINE_FIX_WIDTH * 0.5);
        if (self.guideImgV.kh_centerX > location.x && self.guideImgV.kh_centerX - location.x > avilable) {
            self.guideImgV.kh_centerX -= KH_LINE_FIX_WIDTH;
            [self calculateFontSizeScale];
        } else if (self.guideImgV.kh_centerX < location.x && location.x - self.guideImgV.kh_centerX > avilable) {
            self.guideImgV.kh_centerX += KH_LINE_FIX_WIDTH;
            [self calculateFontSizeScale];
        }
    }
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)calculateFontSizeScale {
    self.currentScale = (self.guideImgV.kh_centerX - KH15Margin * 2.0) / (KH_LINE_FIX_WIDTH * 10.0) + 1.0;
    [self.tableView reloadData];
}

#pragma mark - action
- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sure {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.currentScale == [KHTools share].fontScale) {
        return;
    }
    [[KHTools share] saveFontScale:self.currentScale];
    ///通知更改
    [[NSNotificationCenter defaultCenter] postNotificationName:@"wahahahah" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置字体大小";
    self.view.backgroundColor = KH_RGBOF(0xF5F5F5);
    self.currentScale = [KHTools share].fontScale;
    [self setupSubView];
}

- (void)setupSubView {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(sure)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancle)];

    CGFloat toH = 120.0;
    CGFloat tY = KH_Navi_Height;
    CGFloat tH = KHScreenHeight - KH_Bottom_Height - tY - toH;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tY, KHScreenWidth, tH) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KHScreenWidth, KH15Margin)];
    [self.view addSubview:self.tableView];
    
    ///0.工具栏
    CGFloat toW = KHScreenWidth;
    CGFloat toY = self.tableView.kh_maxY;
    self.toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, toY, toW, toH)];
    self.toolBarView.userInteractionEnabled = YES;
    self.toolBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.toolBarView];
    [self.toolBarView kh_addLineTopWithX:0];
    
    ///0.1标注
    CGFloat sX = KH15Margin * 2.0;
    CGFloat sY = toH * 0.3;
    CATextLayer *smallA = [CATextLayer kh_textLayerWithFrame:CGRectMake(sX, sY, 20.0, 0) Font:KHFont13 Auto:YES];
    smallA.string = @"A";
    smallA.foregroundColor = [UIColor blackColor].CGColor;
    [self.toolBarView.layer addSublayer:smallA];
    
    CATextLayer *normalL = [CATextLayer kh_textLayerWithFrame:CGRectMake(0, sY, 29, 0) Font:KHFont14 Auto:YES];
    normalL.string = @"标准";
    normalL.foregroundColor = [UIColor blackColor].CGColor;
    [self.toolBarView.layer addSublayer:normalL];
    normalL.kh_y = smallA.kh_maxY - normalL.kh_height;
    normalL.kh_centerX = 2 * KH15Margin + KH_LINE_FIX_WIDTH;
    
    CGFloat bW = sX;
    CGFloat bX = KHScreenWidth - sX * 2;
    CATextLayer *bigL = [CATextLayer kh_textLayerWithFrame:CGRectMake(bX, sY, bW, 0) Font:KHFont(22) Auto:YES];
    bigL.string = @"A";
    bigL.foregroundColor = [UIColor blackColor].CGColor;
    [self.toolBarView.layer addSublayer:bigL];
    bigL.kh_y = smallA.kh_maxY - bigL.kh_height;
    
    CGFloat gW = 30.0;
    CGFloat pH = 1.0;
    CGFloat pY = normalL.kh_maxY + KH15Margin * 2 - pH * 0.5;
    [self.toolBarView kh_addLineWithX:KH15Margin * 2 Y:pY];
    
    for(int i = 0;i <= KH_ELEMENT_NUM; i++) {
        CALayer *line0 = [self.toolBarView kh_addLineVerticalWithX:KH15Margin * 2.0 + i * KH_LINE_FIX_WIDTH Height:KH15Margin];
        line0.kh_centerY = pY + 0.5;
    }
   
    self.guideImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, gW, gW)];
    self.guideImgV.backgroundColor = [UIColor whiteColor];
    self.guideImgV.layer.cornerRadius = gW * 0.5;
    self.guideImgV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.guideImgV.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    self.guideImgV.layer.shadowOpacity = 0.4;
    [self.toolBarView addSubview:self.guideImgV];
    CGFloat currentCenterX = ([KHTools share].fontScale - 1.0) * 10.0 * KH_LINE_FIX_WIDTH + 2.0 * KH15Margin;
    self.guideImgV.kh_centerX = currentCenterX;
    self.guideImgV.kh_y = normalL.kh_maxY + KH15Margin;
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.pan.delegate = self;
    [self.toolBarView addGestureRecognizer:self.pan];
    
    self.dataArr = @[@{@"title":@"预览字体大小", @"fontSize":@(20)},
                     @{@"title":@"拖动下面的滑块，可设置字体大小",@"fontSize":@(16)},
                     @{@"title":@"设置后，会改变首页、发现和我的中的字体大小。设置后，会改变首页、发现和我的界面中的字体大小。\n设置后，会改变首页、发现和我的中的字体大小。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。人类的本质就是复读机。",@"fontSize":@(12)}];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [KHFontSizeSettingCell calculateCellHeightWithDict:self.dataArr[indexPath.row] CurrentScale:self.currentScale];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KHFontSizeSettingCell *cell = [KHFontSizeSettingCell registerTableCellWithTableView:tableView];
    cell.currentScale = self.currentScale;
    [cell setTitleLabelWithDict:self.dataArr[indexPath.row]];
    return cell;
}

@end

@interface KHFontSizeSettingCell ()

@property (nonatomic, strong) UILabel *titleL;

@end

@implementation KHFontSizeSettingCell

+ (CGFloat)calculateCellHeightWithDict:(NSDictionary *)dict CurrentScale:(CGFloat)currentScale {
    NSString *str = dict[@"title"];
    CGFloat fontSize = [dict[@"fontSize"] floatValue] * currentScale;
    CGFloat tW = KHScreenWidth - KH15Margin * 2;
    return [str boundingRectWithSize:CGSizeMake(tW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:KHFont(fontSize)} context:nil].size.height + KH15Margin * 2;
}

+ (instancetype)registerTableCellWithTableView:(UITableView *)tableView {
    KHFontSizeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testlalal"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"testlalal"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    CGFloat tW = KHScreenWidth - KH15Margin * 2;
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(KH15Margin, 0, tW, 0)];
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.font = KHAutoFont14;
    self.titleL.numberOfLines = 0;
    [self.contentView addSubview:self.titleL];
    
}

- (void)setTitleLabelWithDict:(NSDictionary *)dict {
    NSString *titleStr = dict[@"title"];
    CGFloat fontSize = [dict[@"fontSize"] floatValue];
    self.titleL.font = KHFont(fontSize * self.currentScale);
    self.titleL.text = titleStr;
    CGFloat tMW = KHScreenWidth - KH15Margin * 2;
    [self.titleL sizeToFit];
    self.titleL.kh_width = tMW;
    self.frame = CGRectMake(0, 0, KHScreenWidth, self.titleL.kh_maxY + KH15Margin * 2);
}

@end
