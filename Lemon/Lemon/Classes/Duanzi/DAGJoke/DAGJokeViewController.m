//
//  DAGJokeViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGJokeViewController.h"
#import "DAG_JokeManager.h"
#import "DAGJokeModel.h"
#import "DAGFunPicModel.h"
#import "DAGJokeTableViewCell.h"
#import "DAGJokeTableViewCell2.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "XU_ImageTools.h"
#import "Dem_UserData.h"
#import "LoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "DAGJokeDetailViewController.h"
#import "CommentDetailViewController.h"
#import "DAGImageManager.h"
#import "Dem_LeanCloudData.h"
@interface DAGJokeViewController ()<UITableViewDataSource, UITableViewDelegate,DAGFunPicModelDelegate>

@property (nonatomic, strong)UITableView *JoketableView;

@property (nonatomic, strong)UITableView *FunPicTableView;

@property (nonatomic, strong)NSMutableArray *JokeArray;

@property (nonatomic, strong)NSMutableArray *FunPicArray;

@property (nonatomic, strong)UISegmentedControl *segment;

@property (nonatomic, assign)CGSize imageSize;

@property (nonatomic, strong)UIImageView *photo;

@property (nonatomic, strong)DAGJokeModel *model;

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, copy)NSString *clickNum;

@end

static NSString *reuseIdentifier = @"JokeCell";
static NSString *reuseIdentifier2 = @"JokeCell2";
static NSInteger i = 1;
@implementation DAGJokeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationItem.title = @"最新笑话";
       self.imageSize = CGSizeMake(self.view.frame.size.width, 10);
       
             // 设置segment
       self.segment = [[UISegmentedControl alloc] initWithItems:@[@"纯文字", @"图文结合"]];
       self.segment.frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
       self.segment.selectedSegmentIndex = 0;
       self.segment.backgroundColor = [UIColor whiteColor];
       self.segment.tintColor = [UIColor colorWithRed:0.227 green:0.532 blue:1.000 alpha:1.000];
       [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
       [self.view addSubview:self.segment];
       
       self.JoketableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 153) style:UITableViewStylePlain];
       [self.view addSubview:self.JoketableView];
       
       self.FunPicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 153) style:UITableViewStylePlain];

       
       self.JoketableView.dataSource = self;
       self.JoketableView.delegate = self;
       [self loadData];
        [self.JoketableView addFooterWithTarget:self action:@selector(JokeLoadRefresh)];
       // 下拉刷新
       
       UIBarButtonItem *right= [[UIBarButtonItem alloc] initWithTitle:@"清缓" style:UIBarButtonItemStyleDone target:self action:@selector(clearAction)];
       self.navigationItem.rightBarButtonItem = right;
      
}

#pragma mark - 清除缓存
- (void)clearAction {
              [[SDImageCache sharedImageCache] clearDisk];
           [[SDImageCache sharedImageCache] clearMemory];
              float tmpSize = [[SDImageCache sharedImageCache] getSize];
              NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
//       NSLog(@"%f", tmpSize);
              [self.FunPicTableView reloadData];
}

#pragma mark - 笑话的上拉刷新
- (void)JokeLoadRefresh {
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
              i++;
              NSString *url = [NSString stringWithFormat:kJokeUrl, i];
              [[DAG_JokeManager shareInstance] requestJokeWithUrl:url finish:^{
                     self.JokeArray = [NSMutableArray array];
                     self.JokeArray = [DAG_JokeManager shareInstance].JokeArray;
                     [self.JoketableView reloadData];
              }];
       [self.JoketableView footerEndRefreshing];
       });
}

#pragma mark - 趣图的上拉刷新
- (void)FunPicLoadRefresh {
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
              i++;
              NSString *url = [NSString stringWithFormat:kFunPicURL, i];
              [[DAG_JokeManager shareInstance] requestFunPicWithUrl:url finish:^{
                     self.FunPicArray = [NSMutableArray array];
                     self.FunPicArray = [DAG_JokeManager shareInstance].FunPicArray;
                    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
                     NSLog(@"%lu",(unsigned long)size);
                     [self.FunPicTableView reloadData];
              }];
              
              [self.FunPicTableView footerEndRefreshing];
              
       });

}

// 趣图的下拉刷新
- (void)FunPicRefresh {
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
              NSInteger a = 1;
              NSString *url = [NSString stringWithFormat:kFunPicURL, a];
              [[DAG_JokeManager shareInstance] requestFunPicWithUrl:url finish:^{
                 
                     self.FunPicArray = [NSMutableArray array];
                     self.FunPicArray = [DAG_JokeManager shareInstance].FunPicArray;
                     [self.FunPicTableView reloadData];
              }];
              [self.FunPicTableView headerEndRefreshing];
       });
}


#pragma mark segment的点击事件
- (void)segmentAction:(UISegmentedControl *)sender {
       // 点击segment的时候进行数据显示的切换
       switch (sender.selectedSegmentIndex) {
              case 0:
                     if (self.JoketableView.superview == nil) {
                            
                            
                            [self.FunPicTableView removeFromSuperview];
                            [self.view addSubview:self.JoketableView];
                     }
                     break;
              case 1:
                     if (self.FunPicTableView.superview == nil) {
                            [self.JoketableView removeFromSuperview];
                            self.FunPicTableView.delegate = self;
                            self.FunPicTableView.dataSource = self;
                            [self.view addSubview:self.FunPicTableView];
                             [self.FunPicTableView addFooterWithTarget:self action:@selector(FunPicLoadRefresh)];
                            [self.FunPicTableView addHeaderWithTarget:self action:@selector(FunPicRefresh)];
                     }
                     break;
              default:
                     break;
       }
}

//加载已经显示出来的CELL
-(void)loadShowCells{
       //返回可见的行数
       //拿到下标
       NSArray *indexArray = [self.FunPicTableView indexPathsForVisibleRows];
       
              //便利数组拿到所有下标
       for (NSIndexPath *indexPath in indexArray) {
              //根据下标创建cell
              DAGJokeTableViewCell *cell = [self.FunPicTableView cellForRowAtIndexPath:indexPath];
              //赋值
              DAGFunPicModel *model = self.FunPicArray[indexPath.row];
              //加载图片
              [cell setimageWithModel:model];
       }

}

//滑动结束加载图片
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
       [self loadShowCells];
}
//滑动进行时不加载图片
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
       if (!decelerate) {
              [self loadShowCells];
       }
}

#pragma mark===celldelegate========

-(void)modelIsCellDeletageWith:(UITableViewCell *)cell{
       //获取当前点击按钮的NSIndexPath
       NSIndexPath *indexpath = [self.FunPicTableView indexPathForCell:cell];
       DAGFunPicModel *model = self.FunPicArray[indexpath.row];
       [model setIsLoading:YES];
}

#pragma mark  数据的加载
- (void)loadData {
       
       self.JokeArray = [NSMutableArray array];
       self.FunPicArray = [NSMutableArray array];
       if (self.segment.selectedSegmentIndex == 0) {
           // 笑话数据的加载
              [[DAG_JokeManager shareInstance] requestJokeWithUrl:[NSString stringWithFormat:kJokeUrl,i] finish:^{
                    
                     [self.JoketableView registerNib:[UINib nibWithNibName:@"DAGJokeTableViewCell2" bundle:nil] forCellReuseIdentifier:reuseIdentifier2];

                     self.JokeArray = [DAG_JokeManager shareInstance].JokeArray;
                     [self.JoketableView reloadData];
              }];
       }
       // 趣图数据的加载
              [[DAG_JokeManager shareInstance] requestFunPicWithUrl:[NSString stringWithFormat:kFunPicURL,i] finish:^{
                     [self.FunPicTableView registerNib:[UINib nibWithNibName:@"DAGJokeTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
                     self.FunPicArray = [DAG_JokeManager shareInstance].FunPicArray;
                     [self.FunPicTableView reloadData];
              }];
}

#pragma mark  tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       
       if (self.segment.selectedSegmentIndex == 0) {
              return self.JokeArray.count;
       }
       return self.FunPicArray.count;
       
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
       self.indexPath = indexPath;
       if (tableView == self.JoketableView && self.segment.selectedSegmentIndex == 0) {
              // 笑话cell
              DAGJokeTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2 forIndexPath:indexPath];
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              DAGJokeModel *model = self.JokeArray[indexPath.row];
              cell.updateLab.text = model.updatetime;
              cell.contentLab.text = model.content;
              cell.model = model;
              [cell.ClickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
              [cell.CommmentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
              [cell.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
              return cell;
       }else if (tableView == self.FunPicTableView && self.segment.selectedSegmentIndex == 1){
              // 趣图 cell
              DAGJokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
              cell.delegate = self;
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              DAGFunPicModel *model = self.FunPicArray[indexPath.row];
              cell.updateLab.text = model.updatetime;
              cell.contentLab.text = model.content;
       // 滑动不加载的数据赋值
              if (model.isLoading) {
              [cell setimageWithModel:model];
              } else {
              [cell setimageWithModel:nil];
              }
              // 为image添加手势 进行轻拍放大
              UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
              cell.photoView.userInteractionEnabled = YES;
              [cell.photoView addGestureRecognizer:tap];
              self.photo = cell.photoView;
              self.imageSize = [XU_ImageTools getImageSizeWithURL:model.url];
              cell.model = model;
              return cell;
       }
  
       return nil;
}


#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       
       self.model = self.JokeArray[indexPath.row];
       
       if ([Dem_UserData shareInstance].isLog != YES) {

              [self alertController];
       
       } else {
              if (self.segment.selectedSegmentIndex == 0) {
                     
              DAGJokeDetailViewController *ddvc = [[DAGJokeDetailViewController alloc] init];
              ddvc.updateText = self.model.updatetime;
              ddvc.contentText = self.model.content;
              ddvc.clickText = self.clickNum;
              ddvc.indexPath = indexPath;
                     [self.navigationController pushViewController:ddvc animated:YES];
              } else {
              
//       DAGJokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
//       cell.selectionStyle = UITableViewCellSelectionStyleNone;
//       DAGFunPicModel *model = self.FunPicArray[indexPath.row];
//       cell.updateLab.text = model.updatetime;
//       cell.contentLab.text = model.content;
//       [cell.photoView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//                     
//       // 为image添加手势 进行轻拍放大
//       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//       cell.photoView.userInteractionEnabled = YES;
//       [cell.photoView addGestureRecognizer:tap];
//       self.photo = cell.photoView;
//       self.imageSize = [XU_ImageTools getImageSizeWithURL:model.url];
//       cell.model = model;
       }
       }
}

#pragma mark - 轻拍的手势事件
- (void)tapAction {
       [DAGImageManager viewWithImage:self.photo.image];
}

#pragma mark - 弹框的显示
- (void)alertController {
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您还没有登录" message:@"注册后才能执行此操作" preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *dAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              
              LoginViewController *lvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"lvc"];
              [self presentViewController:lvc animated:YES completion:nil];
       }];
       UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
              return ;
       }];
       [alert addAction:dAction];
       [alert addAction:cancel];
       [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - cell的按钮点击事件
- (void)clickAction {
       if ([Dem_UserData shareInstance].isLog != YES) {
              [self alertController];
       } else {
              
              [self submitData];
       }
   
}

#pragma mark - 向leancloud保存点击数
- (void)submitData {
       static int i = 1;
       AVQuery *query = [AVQuery queryWithClassName:@"Submit"];
       [query whereKey:@"hashId" equalTo:self.model.hashId];
       [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
              if (objects.count != 0) {
                     i++;
                     ((AVObject *)objects[0]).fetchWhenSave = YES;
                     [objects[0] setObject:[NSString stringWithFormat:@"%d", i] forKey:@"click"];
                     [objects[0] save];
                     [self getPraise];
              } else {
                     AVObject *Submit = [AVObject objectWithClassName:@"Submit"];
                     [Submit setObject:@"1" forKey:@"click"];
                     [Submit setObject:@"很不错的笑话😀" forKey:@"comment"];
                     [Submit setObject:self.model.hashId forKey:@"hashId"];
                     [Submit save];
                     [self getPraise];
              }
       }];

}

#pragma mark - 获取leancloud的点赞数
-(void)getPraise
{
       // 获取点赞数.
       AVQuery *query = [AVQuery queryWithClassName:@"Submit"];
       [query whereKey:@"hashId" equalTo:self.model.hashId];
       [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
              if (objects.count != 0) {
                     // 找到了这条记录.
                     self.clickNum = [NSString stringWithFormat:@"点赞：%@", [objects[0] valueForKey:@"click"]];
              } else {
                     // 没有找到该条记录.
                     self.clickNum = @"点赞：0";
              }
       }];
}

#pragma mark - 评论事件
- (void)commentAction {
       if ([Dem_UserData shareInstance].isLog != YES) {
              
              [self alertController];
       }
       
       CommentDetailViewController *cdvc = [[CommentDetailViewController alloc] init];
       [self presentViewController:cdvc animated:YES completion:nil];
       
       
}

#pragma mark - 分享事件
- (void)shareAction {
       NSLog(@"分享");
       if ([Dem_UserData shareInstance].isLog != YES) {
              [self alertController];
       }
}



#pragma mark -定义cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       if (self.segment.selectedSegmentIndex == 1) {
              return self.imageSize.height * 1.75 ;
       }
       
       DAGJokeModel *model = [DAG_JokeManager shareInstance].JokeArray[indexPath.row];
       return [self heightForCell:model.content]+110;
}

#pragma mark - cell的自适应高度
- (CGFloat)heightForCell:(NSString *)text {
       // 计算1 准备工作
       CGSize size = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 20, 20000);
       NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
       // 计算2 通过字符串获得rect
       CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
       return rect.size.height + 21;
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
