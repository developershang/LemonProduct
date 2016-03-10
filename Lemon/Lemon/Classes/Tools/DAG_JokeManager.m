//
//  DAG_JokeManager.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAG_JokeManager.h"
#import "XU_NetTools.h"
#import "DAGJokeModel.h"
#import "DAGFunPicModel.h"
#import "DAGRequestData.h"
static DAG_JokeManager *manager = nil;
@implementation DAG_JokeManager

#pragma mark - 单例
+ (instancetype)shareInstance {
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
              manager = [self new];
       });
       return manager;
}

#pragma mark - 懒加载
- (NSMutableArray *)JokeArray {
       if (!_JokeArray) {
              _JokeArray = [NSMutableArray array];
       }
       return _JokeArray;
}

- (NSMutableArray *)FunPicArray {
       if (!_FunPicArray) {
              _FunPicArray = [NSMutableArray array];
       }
       return _FunPicArray;
}

#pragma mark - 请求笑话数据
- (void)requestJokeWithUrl:(NSString *)url finish:(void (^)())finish {
       // 判断当前的网络状态
       NSDictionary * dataDict = nil;
       if ( (dataDict = [DAGRequestData requestDatawithUrl:url]) == nil) {
              return;
       }
       
       [XU_NetTools newSolveDataWithUrl:url httpMethod:@"GET" httpBody:nil revokeBloc:^(NSData *data) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
              
              NSDictionary *dict = dic[@"result"];
              for (NSDictionary *dic1 in dict[@"data"]) {
                     DAGJokeModel *model = [DAGJokeModel new];
                     [model setValuesForKeysWithDictionary:dic1];
                     [self.JokeArray addObject:model];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                     finish();
              });
              
       }];
       
       
}

#pragma mark - 请求趣图数据
- (void)requestFunPicWithUrl:(NSString *)url finish:(void (^)())finish {
       
       // 判断当前的网络状态
       NSDictionary * dataDict = nil;
       if ( (dataDict = [DAGRequestData requestDatawithUrl:url]) == nil) {
              return;
       }
       
       [XU_NetTools newSolveDataWithUrl:url httpMethod:@"GET" httpBody:nil revokeBloc:^(NSData *data) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
              
              NSDictionary *dict = dic[@"result"];
              for (NSDictionary *dic1 in dict[@"data"]) {
                     DAGFunPicModel *model = [DAGFunPicModel new];
                     [model setValuesForKeysWithDictionary:dic1];
                     model.isLoading = NO;
                     [self.FunPicArray addObject:model];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                     finish();
              });
              
       }];
       
}

@end
