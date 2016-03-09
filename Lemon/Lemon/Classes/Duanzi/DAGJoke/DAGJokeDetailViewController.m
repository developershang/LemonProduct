//
//  DAGJokeDetailViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGJokeDetailViewController.h"
#import "DAGJokeDetailTableViewCell.h"
#import "DAG_JokeManager.h"
#import "DAGJokeModel.h"
#import <AVOSCloud/AVOSCloud.h>

@interface DAGJokeDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)DAGJokeModel *model;

@property (nonatomic, strong)NSMutableArray *commentArray;

@end

@implementation DAGJokeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.commentArray = [NSMutableArray array];
       
       self.DetailTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
       [self.view addSubview:self.DetailTableView];
       
       self.DetailTableView.dataSource = self;
       self.DetailTableView.delegate = self;
       
       [self.DetailTableView registerNib:[UINib nibWithNibName:@"DAGJokeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
       
       self.model = [DAG_JokeManager shareInstance].JokeArray[self.indexPath.row];
       
       [self commentCount];
//       [self.DetailTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return self.commentArray.count + 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
       if (indexPath.row == 0) {
              
              DAGJokeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
              cell.updateLab.text = self.updateText;
              cell.contentLab.text = self.contentText;
              [cell.clickBtn setTitle:self.clickText forState:UIControlStateNormal];
              return cell;
       }
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
       if (!cell) {
              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
       }
       cell.textLabel.text = self.commentArray[indexPath.row - 1][@"comment"];
       
       return cell;
       
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       if (indexPath.row == 0) {
       return [self heightForLab:self.contentText] + 130;
              
       }
       return 50;
}


- (void)commentCount {
       
       AVQuery *query = [AVQuery queryWithClassName:@"Submit"];
       [query whereKey:@"hashId" equalTo:self.model.hashId];
       [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
          
              if (objects.count != 0) {
                     self.commentArray = objects.mutableCopy;
                     [self.DetailTableView reloadData];
              } else {
                     NSLog(@"暂时还没有评论");
              }
              
       }];
       
       
}


- (CGFloat)heightForLab:(NSString *)text {
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
