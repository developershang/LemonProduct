//
//  DAGMyViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGMyViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "DAGDownLoadViewController.h"
#import "DKNightVersion.h"

@interface DAGMyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *data;

@end

@implementation DAGMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
       self.navigationItem.title = @"设置";
       
       self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
       [self.view addSubview:self.tableView];
       
       self.tableView.dataSource = self;
       self.tableView.delegate = self;
       [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCell"];
       
       [DKNightVersionManager setUseDefaultNightColor:YES];
       
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       switch (section) {
              case 0:
                     return 1;
                     break;
               case 1:
                     return 1;
                     break;
              default:
                     break;
       }
       return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
       return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.000];
       if (indexPath.section == 0) {
              
              if (indexPath.row == 0) {
                     cell.textLabel.text = @"我的下载";
                     
              }
       } else {
              cell.textLabel.text = @"夜间模式";
              UISwitch *switchBtn= [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 5, 60, 34)];
              switchBtn.layer.masksToBounds = YES;
              switchBtn.layer.cornerRadius = 17;
              
              switchBtn.on = NO;
              
              [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
              
              [cell.contentView addSubview:switchBtn];
       }
       
       return cell;
}

- (void)switchAction:(UISwitch *)sender {
       
       if (sender.on == YES) {
              [DKNightVersionManager nightFalling];
       } else {
              [DKNightVersionManager dawnComing];
       }
       
       
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       
       if (indexPath.section == 0 && indexPath.row == 0) {
              DAGDownLoadViewController *ddlc = [[DAGDownLoadViewController alloc] init];
              [self.navigationController pushViewController:ddlc animated:YES];
       }
       
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
