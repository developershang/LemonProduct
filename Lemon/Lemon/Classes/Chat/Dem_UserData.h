//
//  Dem_UserData.h
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dem_UserModel.h"
@class AVUser;
@interface Dem_UserData : NSObject
//登陆状态
@property(nonatomic,assign)BOOL isLog;
//用户模型
@property(nonatomic,strong)Dem_UserModel *model;
//AVUser类型
@property(nonatomic,strong)AVUser *user;

//好友table刷新
@property(nonatomic,assign)BOOL reLoad;

/**
 *@param 单例
 *@return
 **/
+(instancetype)shareInstance;

/**
 *@param 用户登陆
 *@return
 **/
-(void)loginWithUser:(AVUser*)user;

/**
 *@param 用户退出
 *@return
 **/
-(void)logoutUser;

@end
