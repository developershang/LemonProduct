//
//  CommentViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentTable.delegate = self;
    self.commentTable.dataSource = self;
    [self.commentTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"main_cell"];
    
    // Do any additional setup after loading the view from its nib.
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 12;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main_cell" forIndexPath:indexPath];
    
    
    cell.textLabel.text  = @"罗小黑";
    return cell;
    
    
    
    
    
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

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

@end
