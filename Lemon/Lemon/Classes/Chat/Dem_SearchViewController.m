//
//  Dem_SearchViewController.m
//  Lemon
//
//  Created by shang on 16/3/3.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_SearchViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Dem_LeanCloudData.h"
#import "Dem_BuddyViewController.h"

@interface Dem_SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UISearchBar *search;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *data;


@end

@implementation Dem_SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, 50)];
    [self.search setPlaceholder:@"Search"];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-110) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    
    [self.view addSubview:self.search];
    self.search.delegate = self;
    self.table.delegate = self;
    self.table.dataSource =self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    AVUser *user = self.data[indexPath.section][indexPath.row];
    cell.textLabel.text = user.username;
    cell.detailTextLabel.text = [user objectForKey:@"nid"];
    cell.imageView.image = [UIImage imageWithData:[[user objectForKey:@"photo"] getData]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data[section]count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AVUser *user = self.data[indexPath.section][indexPath.row];
    Dem_BuddyViewController *bvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"bvc"];
    bvc.user = user;
    [self.search resignFirstResponder];
    [self.navigationController pushViewController:bvc animated:YES];
}

#pragma mark开始编辑时
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.search setShowsCancelButton:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.search.center;
        point.y -=44;
        self.search.center = point;
    }];
    
    return YES;
}
#pragma mark结束编辑时
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [self.search setShowsCancelButton:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.search.center;
        point.y +=44;
        self.search.center = point;
    }];
    
    return YES;
}
#pragma mark按下按钮搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text isEqualToString:@""]) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *username= [Dem_LeanCloudData searchUserWithUserName:self.search.text];
        if (username.count == 0) {
            NSLog(@"无此用户");
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"无此用户" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            });
            return ;
        }
        NSArray *array = @[username];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.data  = [NSMutableArray arrayWithArray:array];
            [self.table reloadData];
        });
    });
}
#pragma mark搜索内容变化
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

}
#pragma mark取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.search resignFirstResponder];
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
