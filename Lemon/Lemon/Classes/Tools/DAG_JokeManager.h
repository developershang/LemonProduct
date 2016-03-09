//
//  DAG_JokeManager.h
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAG_JokeManager : NSObject

@property (nonatomic, strong)NSMutableArray *JokeArray; // 笑话数组

@property (nonatomic, strong)NSMutableArray *FunPicArray; // 趣图数组


// 创建单例
+ (instancetype)shareInstance;

// 请求笑话的数据
- (void)requestJokeWithUrl:(NSString *)url finish:(void(^)())finish;

// 请求趣图的数据
- (void)requestFunPicWithUrl:(NSString *)url finish:(void (^)())finish;

@end
