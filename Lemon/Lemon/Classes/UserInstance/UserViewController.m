//
//  UserViewController.m
//  Lemon
//
//  Created by shang on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "UserViewController.h"
#import "Dem_UserData.h"
#import <AVOSCloud/AVOSCloud.h>
#import "DHSlideMenuController.h"
#import "LoginViewController.h"

#import "DAGRegardingViewController.h"
#import "DAGEditViewController.h"
#import "RoserViewController.h"

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ageLab;

@property (weak, nonatomic) IBOutlet UILabel *sexLab;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    NSArray *arr1 = @[@"修改信息",@"关于我们"];
    NSArray *arr2 = @[@"更换用户",@"注销"];
    [self.array addObject:arr1];
    [self.array addObject:arr2];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NSNotificationAction) name:@"reInfor" object:@"reInfor"];
    // Do any additional setup after loading the view.
}

-(void)NSNotificationAction{
    AVQuery *query = [AVQuery queryWithClassName:@"Users"];
    [query whereKey:@"user" equalTo:[Dem_UserData shareInstance].user];
    AVObject *Users = [[query findObjects]firstObject];
    [Dem_UserData shareInstance].model.username = [Users objectForKey:@"nid"];
    
    AVFile *file = [Users objectForKey:@"photo"];
    NSData *data = [file getData];
   [Dem_UserData shareInstance].model.photo = [UIImage imageWithData:data];
    [Dem_UserData shareInstance].model.age = [Users objectForKey:@"birth"];
    [Dem_UserData shareInstance].model.sex = [Users objectForKey:@"sex"];
}

-(void)viewWillAppear:(BOOL)animated{
    self.photo.image = [Dem_UserData shareInstance].model.photo;
    self.name.text = [Dem_UserData shareInstance].model.username;
    self.sexLab.text = [Dem_UserData shareInstance].model.sex;
    self.ageLab.text =  [Dem_UserData shareInstance].model.age;
}
#pragma mark row的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array[section] count];
}
#pragma mark section 的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}
#pragma mark cell的设置
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user_cell" forIndexPath:indexPath];
    cell.textLabel.text = self.array[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"xiugai");
            [Dem_UserData shareInstance].reLoad = YES;
            
               DAGEditViewController *devc =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"devc"];
               UINavigationController *ndevc = [[UINavigationController alloc] initWithRootViewController:devc];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:ndevc animated:YES completion:^{
                    
                }];
            });
        }
        else if (indexPath.row == 1){
               DAGRegardingViewController *drvc = [[DAGRegardingViewController alloc] init];
               UINavigationController *ndrvc = [[UINavigationController alloc] initWithRootViewController:drvc];
               [self presentViewController:ndrvc animated:YES completion:nil];
        }
    }
    else if(indexPath.section == 1){
        if (indexPath.row == 0) {
                LoginViewController *lvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"lvc"];
            [[DHSlideMenuController sharedInstance]hideSlideMenuViewController:YES];
                [self presentViewController:lvc animated:YES completion:^{
//                    [Dem_UserData shareInstance].reLoad = YES;
                }];
            
        }
        else if (indexPath.row == 1){
            [[Dem_UserData shareInstance]logoutUser];
            [Dem_UserData shareInstance].reLoad = YES;
            [[DHSlideMenuController sharedInstance]hideSlideMenuViewController:NO];
            [DHSlideMenuController sharedInstance].leftViewController = nil;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reload" object:@"refresh"];
        }
    }
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
