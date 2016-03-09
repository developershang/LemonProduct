//
//  Dem_TestChatListViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_TestChatListViewController.h"
#import "Dem_ChatViewController.h"
#import <RongIMKit/RongIMKit.h>


@interface Dem_TestChatListViewController ()<RCIMReceiveMessageDelegate>

@end

@implementation Dem_TestChatListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"会话列表";
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"好友列表" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = left;

       
//       [[RCIM sharedRCIM] setUserInfoDataSource:self];
       [[RCIM sharedRCIM] setReceiveMessageDelegate:self];

    // Do any additional setup after loading the view.
}

-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    Dem_ChatViewController*conversationVC = [[Dem_ChatViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = conversationVC.targetId;
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:conversationVC];
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
    
}



//
//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
//   RCUserInfo *user = [[RCUserInfo alloc]init];
//   user.userId = userId;
//   return completion(user);
//}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    NSLog(@"%@",message.content);
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
