//
//  Dem_LeanCloudData.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_LeanCloudData.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Dem_UserModel.h"
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface Dem_LeanCloudData ()<AVIMClientDelegate>

@end


@implementation Dem_LeanCloudData

#pragma 用户注册
+(void)addUserWithUser:(Dem_UserModel *)user block:(void (^)(NSError *value))block{
    AVUser *u = [AVUser user];
    u.username =user.username;
    u.password = user.password;
    u.email = user.email;
    
    NSError *error = nil;
    [u signUp:&error];
    
    if (error) {
        
        NSLog(@"%@",error);
        return;
    }
    //    u.mobilePhoneNumber = user.mobilePhoneNumber;
    AVObject *Users = [AVObject objectWithClassName:@"Users"];
    [Users setObject:u forKey:@"user"];
    [Users setObject:user.token forKey:@"token"];
    [Users setObject:user.username forKey:@"nid"];
    NSData *data = UIImagePNGRepresentation(user.photo);
    AVFile *file = [AVFile fileWithName:[NSString stringWithFormat:@"%@.png",user.username] data:data];
       UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       [view setTag:108];
       [view setBackgroundColor:[UIColor colorWithRed:0.546 green:0.541 blue:0.539 alpha:1.000]];
       [view setAlpha:0.5];
       UIViewController *vc = [UIApplication sharedApplication].windows[2].rootViewController;
       [vc.view addSubview:view];
       UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
       [act setCenter:view.center];//设置旋转菊花的中心位置
       [act setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置菊花的样式
       [view addSubview: act];
       [act startAnimating];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%d",succeeded);
        if (succeeded == 1) {
//            [file deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                NSLog(@"%@ // %d",error,succeeded);
//                             }];
            [Users setObject:file forKey:@"photo"];
            
            AVObject *Group = [AVObject objectWithClassName:@"Group"];
            NSArray *array = @[@"我的好友",@"其他"];
            [Group setObject:array forKey:@"groupName"];
            [Group setObject:u forKey:@"user"];
            NSError *error1 = nil;
            [Group save:&error1];
            if (error1) {
                NSLog(@"%@",error1);
            }
            [Users saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"%d",succeeded);
                if (succeeded == 1) {
                       UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
                       [act stopAnimating];
                       [view removeFromSuperview];
                       [vc removeFromParentViewController];
                }
                   block(error);
            }];
        }
    } progressBlock:^(NSInteger percentDone) {
        
                  NSLog(@"%ld",percentDone);
    }];
}

#pragma mark用户登录
+(void)loginWithUserName:(NSString *)userName pwd:(NSString *)pwd block:(void (^)(AVUser *))block error:(void(^)(NSError*err))err{
    [AVUser logInWithUsernameInBackground:userName password:pwd block:^(AVUser *user, NSError *error) {
        block(user);
        err(error);
    }];
}

#pragma mark调取组
+(void)groupWithUser:(AVUser*)user block:(void(^)(AVObject *group))block{
    AVQuery *query = [AVQuery queryWithClassName:@"Group"];
    [query whereKey:@"user" equalTo:user];
    AVObject *group = [[query findObjects]firstObject];
    block(group);
}

#pragma mark修改密码
+(void)CreatUsername:(NSString *)username password:(NSString*)password andNewPassword:(NSString*)newpwd{
    //    [AVUser logInWithUsername:username  password:password]; //请确保用户当前的有效登录状态
    [[AVUser currentUser] updatePassword:password  newPassword:newpwd block:^(id object, NSError *error) {
        //处理结果
    }];
}

#pragma mark 查询用户名
+(NSArray<AVUser*>*)searchUserWithUserName:(NSString*)name{
     AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" hasPrefix:name];
    NSArray *array=  [query findObjects];
    return array;
}

#pragma mark 用户信息查询
+(void)intermationWithUser:(AVUser*)user block:(void(^)(AVObject *users))block{
    AVQuery *query = [AVQuery queryWithClassName:@"Users"];
    [query whereKey:@"user" equalTo:user];
    AVObject *users = [[query findObjects]firstObject];
    block(users);
}

#pragma mark添加好友
+(void)addBuddyWithUser:(AVUser *)user buddy:(AVUser *)buddy group:(NSString *)group{
    AVObject *Bud = [AVObject objectWithClassName:@"Buddy"];
    [Bud setObject:user forKey:@"user"];
    [Bud setObject:buddy forKey:@"friend"];
    [Bud setObject:group forKey:@"group"];
    [Bud saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@" ==%d==",succeeded);
//        NSLog(@"error==%@",error);
    }];
}

#pragma mark所有好友
+(NSArray <AVObject *>*)buddyWithUser:(AVUser *)user{
    AVQuery *query = [AVQuery queryWithClassName:@"Buddy"];
    [query whereKey:@"user" equalTo:user];
    NSArray *arr = [query findObjects];
    NSLog(@"%@",arr);
    return arr;
}

#pragma mark删除好友
+(void)delectWithUser:(AVUser *)user buddy:(AVUser *)buddy{
    AVQuery *priorityQuery = [AVQuery queryWithClassName:@"Buddy"];
    [priorityQuery whereKey:@"user" equalTo:user];
    
    AVQuery *statusQuery = [AVQuery queryWithClassName:@"Buddy"];
    [statusQuery whereKey:@"friend" equalTo:buddy];
    
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:statusQuery,priorityQuery,nil]];
    
    AVObject *bud =[[query findObjects]firstObject];
    [bud delete];
}

#pragma mark好友分组
+(NSArray <AVObject *>*)groupByUser:(AVUser *)user group:(NSString *)group{
    AVQuery *priorityQuery = [AVQuery queryWithClassName:@"Buddy"];
    [priorityQuery whereKey:@"user" equalTo:user];
    
    AVQuery *statusQuery = [AVQuery queryWithClassName:@"Buddy"];
    [statusQuery whereKey:@"group" equalTo:group];
    
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:statusQuery,priorityQuery,nil]];
    NSArray *arr = [query findObjects];
    return arr;
}

+(AVUser *)searchWithUser:(NSString *)name{
     AVQuery *userQuery = [AVQuery queryWithClassName:@"_User"];
    [userQuery whereKey:@"username" equalTo:name];
    AVUser *user = [[userQuery findObjects]firstObject];
    return user;
}



@end
