//
//  Dem_LeanMethod.h
//  Lemon
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dem_Fpuser;
@class AVUser;
@class AVObject;
@class Dem_UserModel;
@interface Dem_LeanMethod : NSObject

/**
 *@param
 *@return 添加帖子
 **/
+(void)addFpuserWithUser:(AVUser *)user fpuser:(Dem_Fpuser*)fpuser block:(void(^)(BOOL save))block;

/**
 *@param
 *@return 根据页数查询
 **/
+(NSArray<AVObject*>*)theFpuserWithPage:(NSInteger)page;

/**
 *@param
 *@return 根据fpuser类型进行查找数据
 **/
+(void)theContentWithFpuser:(AVObject *)fpuser fpus:(void(^)(Dem_Fpuser*fpusers))fpus mo:(void(^)(Dem_UserModel *user))mo;

@end
