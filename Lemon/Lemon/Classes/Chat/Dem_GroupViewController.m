//
//  Dem_GroupViewController.m
//  Lemon
//
//  Created by shang on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_GroupViewController.h"

@interface Dem_GroupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *table;
@end

@implementation Dem_GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.dataSource = self;
    self.table.delegate = self;
    // Do any additional setup after loading the view.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"group_cell"];
    cell.textLabel.text = self.group[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.group.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
    self.block((int)indexPath.row);
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
