//
//  Dem_UserModel.h
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Dem_UserModel : NSObject
//头像
@property(nonatomic,strong)UIImage *photo;
//昵称
@property(nonatomic,copy)NSString *username;
//用户名
@property(nonatomic,copy)NSString *userID;
//token
@property(nonatomic,copy)NSString *token;
//性别
@property(nonatomic,copy)NSString *sex;
//密码
@property(nonatomic,copy)NSString *password;
//emalll
@property(nonatomic,copy)NSString *email;
//年龄
@property(nonatomic,copy)NSString *age;

@end
