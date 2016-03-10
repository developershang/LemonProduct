//
//  DAGSearchNewsViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGSearchNewsViewController.h"
#import "DAG_NewsListManager.h"
#import "DAGNewsDetailList.h"
#import "DAGNewsDeatilViewController.h"
@interface DAGSearchNewsViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *titleArray;

@end

@implementation DAGSearchNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
       UISearchBar *searchNews = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 28)];
       searchNews.delegate = self;
       searchNews.placeholder = @"请输入要搜索的信息";
       self.navigationItem.titleView = searchNews;
       
       self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
       [self.view addSubview:self.tableView];
       
       self.tableView.dataSource = self;
       self.tableView.delegate = self;
       
       [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchCell"];
}


#pragma mark - 搜索的事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
       if ([searchBar.text isEqualToString:@""]) {
              return;
       }
       self.titleArray = [NSMutableArray array];
       NSArray *array = [DAG_NewsListManager shareInstance].NewsDetailArray;
       for (DAGNewsDetailList *model in array) {
              if ([model.full_title containsString:searchBar.text]) {
                     [self.titleArray addObject:model];
                     NSLog(@"%@",model.full_title);
              }
       }
       [self.tableView reloadData];
}

#pragma mark - tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
       DAGNewsDetailList *model = self.titleArray[indexPath.row];
       cell.textLabel.text = model.full_title;
       return cell;
}

#pragma mark - tableViewcell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       DAGNewsDeatilViewController *ddvc = [[DAGNewsDeatilViewController alloc] init];
       DAGNewsDetailList *model = self.titleArray[indexPath.row];
       ddvc.detailUrl = model.url;
       [self.navigationController pushViewController:ddvc animated:YES];
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
