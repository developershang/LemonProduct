   //
//  Dem_LeanCloudData.h
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@class Dem_UserModel;
@interface Dem_LeanCloudData : NSObject
/**
 *@param 用户注册
 *@return block用户注册
 **/
+(void)addUserWithUser:(Dem_UserModel *)user block:(void (^)(NSError *value))block;

/**
 *@param 用户登录
 *@return block用户登录
 **/
+(void)loginWithUserName:(NSString*)userName pwd:(NSString*)pwd block:(void(^)(AVUser*user))block error:(void(^)(NSError*err))err;

/**
 *@param 查找组
 *@return block 组
 **/
+(void)groupWithUser:(AVUser*)user block:(void(^)(AVObject *group))block;

/**
 *@param 查询用户
 *@return AVUser 查询用户
 **/
+(NSArray<AVUser*>*)searchUserWithUserName:(NSString*)name;

/**
 *@param 用户信息
 *@return return用户信息
 **/
+(void)intermationWithUser:(AVUser*)user block:(void(^)(AVObject *users))block;

/**
 *@param 添加好友
 *@return 添加好友
 **/
+(void)addBuddyWithUser:(AVUser *)user buddy:(AVUser *)buddy group:(NSString *)group;

/**
 *@param 所有好友
 *@return 所有好友
 **/
+(NSArray <AVObject *>*)buddyWithUser:(AVUser *)user;

/**
 *@param 删除好友
 *@return 删除好友
 **/
+(void)delectWithUser:(AVUser *)user buddy:(AVUser *)buddy;

/**
 *@param 好友分组
 *@return 好友分组
 **/
+(NSArray <AVObject *>*)groupByUser:(AVUser *)user group:(NSString *)group;

/**
 *@param
 *@return 根据用户名查询
 **/
+(AVUser *)searchWithUser:(NSString *)name;

/**
 *@param
 *@return 修改用户信息
 **/
+(void)editInformationWithUser:(AVUser*)user nid:(NSString *)nid oldPassword:(NSString*)oldpass password:(NSString *)password photo:(UIImage *)photo sex:(NSString *)sex birthday:(NSString *)birth;

@end
