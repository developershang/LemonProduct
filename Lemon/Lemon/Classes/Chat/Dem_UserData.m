//
//  Dem_UserData.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_UserData.h"
#import <AVOSCloud/AVOSCloud.h>
#import <RongIMKit/RongIMKit.h>
static Dem_UserData *handle = nil;
@implementation Dem_UserData

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[self alloc]init];
    });
    return handle;
}

-(instancetype)init{
    _isLog = NO;
    _reLoad = NO;
    if (self.user != nil) {
        [self loginWithUser:self.user];
        
    }
    return self;
}

#pragma mark 懒加载
-(Dem_UserModel *)model{
    if (!_model) {
        _model = [[Dem_UserModel alloc]init];
    }
    return _model;
}

-(AVUser *)user{
    if (!_user) {
        _user = [AVUser currentUser];
    }
    return _user;
}

#pragma mark 用户登陆
-(void)loginWithUser:(AVUser*)user{
    self.user = user;
    if (user == nil) {
        return;
    }
    _isLog = YES;
    AVQuery *query = [AVQuery queryWithClassName:@"Users"];
    [query whereKey:@"user" equalTo:self.user];
    AVObject *Users = [[query findObjects]firstObject];
    self.model.username = [Users objectForKey:@"nid"];
    
    self.model.token = [Users objectForKey:@"token"];
    AVFile *file = [Users objectForKey:@"photo"];
    NSData *data = [file getData];
    self.model.photo = [UIImage imageWithData:data];
    [self RCIM];
}

-(void)RCIM{
    //连接服务器
    [[RCIM sharedRCIM] connectWithToken:self.model.token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        [Dem_UserData shareInstance].isLog = YES;
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

#pragma mark用户退出
-(void)logoutUser{
    self.model = nil;
    self.isLog = NO;
    self.user = nil;
    [AVUser logOut];
    [[RCIM sharedRCIM]disconnect:YES];
    [AVUser currentUser];
}

@end
