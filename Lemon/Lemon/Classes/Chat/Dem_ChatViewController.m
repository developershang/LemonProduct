//
//  Dem_ChatViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_ChatViewController.h"



@interface Dem_ChatViewController ()

@end

@implementation Dem_ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(returnAction)];
    self.navigationItem.leftBarButtonItem = left;
    // Do any additional setup after loading the view.
}

-(void)returnAction{
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
