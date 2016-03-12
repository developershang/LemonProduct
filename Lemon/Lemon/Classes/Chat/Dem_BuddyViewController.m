//
//  Dem_BuddyViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_BuddyViewController.h"
#import "Dem_UserData.h"
#import "Dem_GroupViewController.h"
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface Dem_BuddyViewController ()


@property (weak, nonatomic) IBOutlet UILabel *ageLab;

@property (weak, nonatomic) IBOutlet UILabel *sexLab;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *group;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSMutableArray *budArr;
@property(nonatomic,assign)int num;
@property(nonatomic,strong)AVIMClient *client;


@end

@implementation Dem_BuddyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.budArr = [NSMutableArray array];
    [Dem_LeanCloudData intermationWithUser:self.user block:^(AVObject *users) {
        self.name.text = [users objectForKey:@"nid"];
        AVFile *file = [users objectForKey:@"photo"];
        NSData *data = [file getData];
        self.photo.image = [UIImage imageWithData:data];
    }];
    
    _num = 0;
    [Dem_LeanCloudData groupWithUser:[Dem_UserData shareInstance].user block:^(AVObject *group) {
        self.array = [NSMutableArray array];
        self.array = [group objectForKey:@"groupName"];
        
    }];
    [self.group addTarget:self action:@selector(groupAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = [Dem_LeanCloudData buddyWithUser:[Dem_UserData shareInstance].user];
    for (AVObject *friend in arr) {
        AVUser *user = [friend objectForKey:@"friend"];
        [self.budArr addObject:user];
    }
    
    if ([self.user isEqual:[Dem_UserData shareInstance].user] ) {
        self.group.hidden = YES;
        [self.button setTitle:@"编辑资料" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        BOOL isAdd = [self.budArr containsObject:self.user];
        if (isAdd == YES) {
            self.group.hidden = YES;
            [self.button setTitle:@"删除好友" forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(delAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            self.group.hidden = NO;
            [self.button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    // Do any additional setup after loading the view.
}
#pragma mark 编辑资料
-(void)editAction{
    
}
#pragma mark 删除好友
-(void)delAction{
    [Dem_LeanCloudData delectWithUser:[Dem_UserData shareInstance].user buddy:self.user];
    [Dem_LeanCloudData delectWithUser:self.user buddy:[Dem_UserData shareInstance].user];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark 选择组
-(void)groupAction{
    Dem_GroupViewController *gvc = [[Dem_GroupViewController alloc]init];
    gvc.group = self.array;
    [self.navigationController pushViewController:gvc animated:YES];
    gvc.block =^ (int value){
        _num = value;
    };
}
#pragma mark添加好友
-(void)addAction{
    [Dem_LeanCloudData addBuddyWithUser:[Dem_UserData shareInstance].user buddy:self.user group:self.array[_num]];
    
    [self chatWithUser:[Dem_UserData shareInstance].user.username andFriend:self.user.username];
    
       
}

#pragma markh好友发送通知
-(void)chatWithUser:(NSString *)user andFriend:(NSString *)friends{
    // Tom 创建了一个 client，用自己的名字作为 clientId
    self.client = [[AVIMClient alloc] initWithClientId:user];
    // Tom 打开 client
    [ self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 建立了与 Jerry 的会话
        NSLog(@"error !!! %@",error);
        [ self.client createConversationWithName:[NSString stringWithFormat:@"%@ add %@",user,friends] clientIds:@[friends] callback:^(AVIMConversation *conversation, NSError *error) {
            NSLog(@"error ~~~ %@",error);
            // Tom 发了一条消息给 Jerry
            [conversation sendMessage:[AVIMTextMessage messageWithText:[NSString stringWithFormat:@"%@",user] attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"发送成功！");
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                    NSLog(@"error == = %@",error);
            }];
        }];
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [self.group setTitle:self.array[_num] forState:UIControlStateNormal];
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
