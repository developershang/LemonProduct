//
//  DAGDataBase.h
//  Lemon
//
//  Created by shang on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class DAGImageDownLoad;
@interface DAGDataBase : NSObject

// 创建单例
+ (instancetype)shareInstance;

#pragma mark - 根据用户存储图片
- (void)addImage:(NSString *)image user:(NSString *)name;


#pragma mark - 根据当前用户查看已保存的数据
- (DAGImageDownLoad *)selectByName:(NSString *)name;

- (void)deleteByname:(NSString *)name;

@end
