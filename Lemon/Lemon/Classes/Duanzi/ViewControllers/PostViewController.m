//
//  PostViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController


- (void)viewWillAppear:(BOOL)animated{
    
       self.navigationItem.leftBarButtonItem.title = @"取消";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DoneAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
//  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem.title = @"取消";
    
    // Do any additional setup after loading the view from its nib.
}



- (void)DoneAction:(UIBarButtonItem *)sender{
    NSLog(@"发表");
    
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
