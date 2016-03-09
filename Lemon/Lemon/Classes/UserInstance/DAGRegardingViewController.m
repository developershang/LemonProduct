//
//  DAGRegardingViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/8.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGRegardingViewController.h"

@interface DAGRegardingViewController ()

@end

@implementation DAGRegardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
       self.view.backgroundColor = [UIColor whiteColor];
       UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 310, kScreenWidth - 100, 100)];
       label.numberOfLines = 0;
       label.text = @"";
       label.alpha = 0.7;
       label.textAlignment = NSTextAlignmentCenter;
       [self.view addSubview:label];
       
       
       
       
    // Do any additional setup after loading the view.
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
