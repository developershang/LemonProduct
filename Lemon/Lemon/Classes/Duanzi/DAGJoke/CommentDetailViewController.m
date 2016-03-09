//
//  CommentDetailViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "CommentDetailViewController.h"

@interface CommentDetailViewController ()

@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
       self.view.backgroundColor = [UIColor orangeColor];
       
       self.navigationItem.title = @"提交评论";
       
       self.field = [[UITextField alloc] initWithFrame:CGRectMake(10, 64, self.view.frame.size.width - 20, self.view.frame.size.height * 0.3)];
       self.field.borderStyle = UITextBorderStyleRoundedRect;
       self.field.placeholder = @"请输入评论";
       [self.view addSubview:self.field];
       
       self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
       self.cancelBtn.frame = CGRectMake(50, 104 + self.field.frame.size.height, 50, 30);
       [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
       [self.view addSubview:self.cancelBtn];
       
       self.submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
       
       self.submitBtn.frame = CGRectMake(150, 104 + self.field.frame.size.height, 50, 30);
       [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
       [self.view addSubview:self.submitBtn];
       
       [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
       
       [self.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
       
       
       
       
    // Do any additional setup after loading the view.
}

- (void)cancelAction {
       
       [self dismissViewControllerAnimated:YES completion:nil];
       
}

- (void)submitAction {
       
       [self dismissViewControllerAnimated:YES completion:nil];
       
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
