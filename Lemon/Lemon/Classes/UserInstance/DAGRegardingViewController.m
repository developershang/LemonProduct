//
//  DAGRegardingViewController.m
//  Lemon
//
//  Created by shang on 16/3/8.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGRegardingViewController.h"
#import "DHSlideMenuController.h"
@interface DAGRegardingViewController ()

@end

@implementation DAGRegardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationItem.title = @"关于我们";
       self.view.backgroundColor = [UIColor whiteColor];
       UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 310, kScreenWidth - 100, 100)];
       label.numberOfLines = 0;
       label.text = @"我们是一个是三个人的团队，这里将是单身狗的乐园，我们的宗旨就是让您得到快乐，我们本着方便您的态度，愉悦您的身心，您快乐就是我们最大的愿望！！！！";
       label.alpha = 0.7;
       label.textAlignment = NSTextAlignmentCenter;
       [self.view addSubview:label];
       
       UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
       self.navigationItem.leftBarButtonItem = left;
       
       UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
       [imageView setImage:[UIImage imageNamed:@"742565.jpg"]];
       [self.view addSubview:imageView];
       
    // Do any additional setup after loading the view.
}

- (void)leftAction {
       [[DHSlideMenuController sharedInstance]hideSlideMenuViewController:NO];
       [self dismissViewControllerAnimated:YES completion:^{
              
       }];
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
