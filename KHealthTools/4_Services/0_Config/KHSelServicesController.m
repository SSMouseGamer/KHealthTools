//
//  KHSelServicesController.m
//  AFNetworking
//
//  Created by 李云新 on 2018/11/13.
//

#import "KHSelServicesController.h"
#import "KHBaseUserDefault.h"
#import "UIFont+KHTsCategory.h"

@interface KHSelServicesController ()

@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@end

@implementation KHSelServicesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择地址";
    self.tableView.rowHeight  = 64;
    [self setupData];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [backBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    backBtn.titleLabel.font = KHFont(15.0f);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)backBtnClick:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupData {
    NSString *originPath = [[NSBundle mainBundle] pathForResource:@"kh_services_domain_config"
                                                           ofType:@"plist"];
    NSArray *serviceDomainArray = [[NSArray alloc] initWithContentsOfFile:originPath];
    NSAssert(serviceDomainArray.count != 0, @"\n\n\nkh_services_domain_config 配置出错\n\n\n");
    
    NSInteger selKey = [KHBaseUserDefault kh_integerValueForKey:@"KHTools_ServicesConfig_SelKey"];
    
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < serviceDomainArray.count; i++) {
        NSDictionary *dict = serviceDomainArray[i];
        
        NSString *sel    = i == selKey ? @"已选择" : @"切换至";
        NSString *name   = [dict objectForKey:@"name"];
        NSString *domain = [dict objectForKey:@"domain"];
        
        [mArray addObject:[NSString stringWithFormat:@"%@：%@ - %@", sel, name, domain]];
    }
    
    self.dataArray = mArray;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hahahahaha"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault)
                                      reuseIdentifier:@"hahahahaha"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [KHBaseUserDefault kh_saveIntegerValue:indexPath.row key:@"KHTools_ServicesConfig_SelKey"];
    UIAlertController *av = [UIAlertController alertControllerWithTitle:@"切换成功" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [av addAction: [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            abort();
        });
    }]];
    [self presentViewController:av animated:YES completion:nil];
}

@end
