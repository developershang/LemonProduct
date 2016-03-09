//
//  DAG_NewsListManager.h
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAG_NewsListManager : NSObject

// 用来存储实时热点的标题
@property (nonatomic, strong)NSMutableArray *NewsTitleArray;

// 用来存储详细信息
@property (nonatomic, strong)NSMutableArray *NewsDetailArray;

#pragma mark - 单例
+ (instancetype)shareInstance;

#pragma mark - 实时热点新闻的标题的获取
- (void)requestWithUrl:(NSString *)url finish:(void(^)())finish;

#pragma mark - 详细信息的获取
- (void)requestWithDetailUrl:(NSString *)url finish:(void (^)())finish;

@end
