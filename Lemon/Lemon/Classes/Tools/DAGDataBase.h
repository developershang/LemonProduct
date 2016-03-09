//
//  DAGDataBase.h
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class DAGImageDownLoad;
@interface DAGDataBase : NSObject

// 创建单例
+ (instancetype)shareInstance;

- (void)addImage:(NSString *)image user:(NSString *)name;

- (DAGImageDownLoad *)selectByName:(NSString *)name;

@end
