//
//  DAGDownLoadViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGDownLoadViewController.h"
#import "DAGDataBase.h"
#import "DAGImageDownLoad.h"
#import "Dem_UserData.h"
#import <AVOSCloud/AVOSCloud.h>
@interface DAGDownLoadViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *imageArray;

@end

@implementation DAGDownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
       [self.view addSubview:self.tableView];
       
      
       [self loadData];
       
       
    // Do any additional setup after loading the view.
}

- (void)loadData {
       
       self.imageArray = [NSMutableArray array];
       
       NSString *currentUserName = [Dem_UserData shareInstance].user.username;
       if (currentUserName == nil) {
              return;
       }
       self.tableView.dataSource = self;
       self.tableView.delegate = self;
       
       [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];

       DAGImageDownLoad *model = [[DAGDataBase shareInstance] selectByName:currentUserName];
       [self.imageArray addObject:model];

       
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
       DAGImageDownLoad *model = self.imageArray[0];
       cell.textLabel.text = model.name;
       NSData *imageData = [[NSData alloc] initWithBase64Encoding:model.imageUrl];
       UIImage *image = [UIImage imageWithData:imageData];
       cell.imageView.image = image;
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

@end
