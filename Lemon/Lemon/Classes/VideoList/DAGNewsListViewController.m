//
//  DAGNewsListViewController.m
//  Lemon
//
//  Created by shang on 16/3/1.
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
       self.view.backgroundColor = [UIColor clearColor];
       UIImageView *image = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       image.image = [UIImage imageNamed:@"sky.jpg"];
       self.dlv.table.backgroundView = image;
       self.navigationItem.title = @"实时热点";
       
       UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];
       self.navigationItem.rightBarButtonItem = right;
       
       self.dlv.table.dataSource = self;
       self.dlv.table.delegate = self;

       [self p_setupProgressHud];
       [self loadData];

       
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.0 *NSEC_PER_SEC), dispatch_get_main_queue(), ^{
              [self loadShowCells];
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

// 加载当前显示的cell
- (void)loadShowCells {
       
       NSArray *indexArray = [self.dlv.table indexPathsForVisibleRows];
       
       for (NSIndexPath *indexPath in indexArray) {
              NewsListTableViewCell *cell = [self.dlv.table cellForRowAtIndexPath:indexPath];
              DAGNewsDetailList *model = self.DetailArray[indexPath.row];
              [cell setimageWithModel:model];
       }
       
       
}

// 结束滑动时候的事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
       [self loadShowCells];
}


// 结束拖曳的时候的事件
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
       if (!decelerate) {
              [self loadShowCells];
       }
}

// 滑动不加载的代理的方法实现
- (void)modelIsCellDelegateWith:(UITableViewCell *)cell {
       NSIndexPath *indexPath = [self.dlv.table indexPathForCell:cell];
       DAGNewsDetailList *model = self.DetailArray[indexPath.row];
       [model setIsLoading:YES];
}

// 加载数据
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
                            DAGNewsDetailList *model = self.DetailArray[i];
                            model.isLoading = NO;
                            [self.dlv.table reloadData];
                     }];
              }
              
       }];
}

// 搜索按钮的点击事件
- (void)searchAction {
       
       DAGSearchNewsViewController *dsvc = [[DAGSearchNewsViewController alloc] init];
       [self.navigationController pushViewController:dsvc animated:YES];
       
}

#pragma mark - tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return self.DetailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
       NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell" forIndexPath:indexPath];
       cell.backgroundColor = [UIColor clearColor];
       [cell setDelegate:self];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
              DAGNewsDetailList *model = self.DetailArray[indexPath.row];
              cell.TitleLab.text = model.full_title;
              cell.UpdateTimeLab.text = model.pdate_src;
       if (model.isLoading) {
              [cell setimageWithModel:model];
       } else {
              [cell setimageWithModel:nil];
       }
       
       return cell;
}

#pragma mark - 指定cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       return 140;
}

#pragma mark - tableViewcell的点击事件
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
