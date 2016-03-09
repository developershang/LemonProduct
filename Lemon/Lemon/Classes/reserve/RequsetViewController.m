//
//  RequsetViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/9.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "RequsetViewController.h"

@interface RequsetViewController ()

@end

@implementation RequsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RefuseReuestUserAction:(UIButton *)sender {
    NSLog(@"拒绝");
}

- (IBAction)AgreeRequestUserAction:(UIButton *)sender {
    DLog(@"同意");
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
