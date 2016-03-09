//
//  DAGNewsListViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGNewsListViewController.h"
#import "DAG_NewsListManager.h"
#import "DAGNewsLiatModel.h"
#import "NewsListTableViewCell.h"
#import "DAGNewsDetailList.h"
#import "UIImageView+WebCache.h"
#import "DAGNewsDeatilViewController.h"
#import "DAGSearchNewsViewController.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
@interface DAGNewsListViewController ()<UITableViewDataSource,UITableViewDelegate,DAGNewsDetailDelegate>

@property (nonatomic, strong)NSMutableArray *NewsListArray; // 标题数组

@property (nonatomic, strong)NSMutableArray *DetailArray; // 详情数组

@property (nonatomic, strong)MBProgressHUD *hud;

@end

@implementation DAGNewsListViewController

- (void)loadView {
       [super loadView];
       self.dlv = [[DAGNewsListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       self.view = self.dlv;
}


- (void)viewDidLoad {
    [super viewDidLoad];
       
       UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"06-magnifying-glass"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
       self.navigationItem.rightBarButtonItem = right;
       
       self.dlv.table.dataSource = self;
       self.dlv.table.delegate = self;

       [self p_setupProgressHud];
       [self loadData];
       
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.0 *NSEC_PER_SEC), dispatch_get_main_queue(), ^{
          
              [self.hud removeFromSuperview];
              
       });
       
       // Do any additional setup after loading the view.
}

// 小菊花.
- (void)p_setupProgressHud
{
       self.hud = [[MBProgressHUD alloc] initWithView:self.view];
       _hud.frame = self.view.bounds;
       _hud.minSize = CGSizeMake(100, 100);
       _hud.mode = MBProgressHUDModeIndeterminate;
       [self.view addSubview:_hud];
       
       [_hud show:YES];
}

- (void)loadData {
       [[DAG_NewsListManager shareInstance] requestWithUrl:kHotUrl finish:^{
              self.NewsListArray = [NSMutableArray array];
              
              self.NewsListArray = [DAG_NewsListManager shareInstance].NewsTitleArray;
              
              
              
              [self.dlv.table registerNib:[UINib nibWithNibName:@"NewsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsListCell"];
              self.DetailArray = [NSMutableArray array];
              for (int i = 0; i < self.NewsListArray.count; i++) {
                     
                     DAGNewsLiatModel *m = self.NewsListArray[i];
                     NSString *title = m.title;
                     NSString *encode = [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                     NSString *detailUrl = [NSString stringWithFormat:kDetailUrl, encode];
                     [[DAG_NewsListManager shareInstance] requestWithDetailUrl:detailUrl finish:^{
                            self.DetailArray = [DAG_NewsListManager shareInstance].NewsDetailArray;
                            
                            [self.dlv.table reloadData];
                     }];
              }
              
       }];
}


- (void)searchAction {
       
       DAGSearchNewsViewController *dsvc = [[DAGSearchNewsViewController alloc] init];
       [self.navigationController pushViewController:dsvc animated:YES];
       
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return self.DetailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell" forIndexPath:indexPath];
       
       
              DAGNewsDetailList *model = self.DetailArray[indexPath.row];
       
              cell.TitleLab.text = model.full_title;
              cell.UpdateTimeLab.text = model.pdate_src;
              [cell.PhotoView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
       
       return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       
       DAGNewsDeatilViewController *dvc = [[DAGNewsDeatilViewController alloc] init];
       
       DAGNewsDetailList *model = self.DetailArray[indexPath.row];
       dvc.detailUrl = model.url;
       [self.navigationController pushViewController:dvc animated:YES];
       
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
