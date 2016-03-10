 //
//  DAG_NewsListManager.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAG_NewsListManager.h"
#import "XU_NetTools.h"
#import "DAGNewsLiatModel.h"
#import "DAGNewsDetailList.h"
#import "DAGRequestData.h"
static DAG_NewsListManager *manager = nil;

@implementation DAG_NewsListManager

#pragma mark 单例
+ (instancetype)shareInstance {
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
              manager = [self new];
       });
       return manager;
}

#pragma mark 懒加载
- (NSMutableArray *)NewsTitleArray {
       if (!_NewsTitleArray) {
              _NewsTitleArray = [NSMutableArray array];
       }
       return _NewsTitleArray;
}

- (NSMutableArray *)NewsDetailArray {
       if (!_NewsDetailArray) {
              _NewsDetailArray = [NSMutableArray array];
       }
       return _NewsDetailArray;
}

#pragma mark - 实时热点新闻的标题的获取
- (void)requestWithUrl:(NSString *)url finish:(void (^)())finish{
      
       NSDictionary * dataDict = nil;
       if ( (dataDict = [DAGRequestData requestDatawithUrl:url]) == nil) {
              return;
       }
       
       [XU_NetTools newSolveDataWithUrl:url httpMethod:@"GET" httpBody:nil revokeBloc:^(NSData *data) {

              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
              
              if (dic[@"result"] == nil) {
                     return ;
              }
              
              for (NSString *str in dic[@"result"]) {
                     DAGNewsLiatModel *model = [DAGNewsLiatModel new];
                     model.title = str;
                     [self.NewsTitleArray addObject:model];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                     finish();
              });
       }];
           
}

#pragma mark - 根据热点新闻获取详细内容
- (void)requestWithDetailUrl:(NSString *)url finish:(void (^)())finish {
       
       NSDictionary * dataDict = nil;
       if ( (dataDict = [DAGRequestData requestDatawithUrl:url]) == nil) {
              return;
       }
       
       [XU_NetTools newSolveDataWithUrl:url httpMethod:@"GET" httpBody:nil revokeBloc:^(NSData *data) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
              
              if (dic[@"result"] == [NSNull null]) {
                     return ;
              }
              for (NSDictionary *dict in dic[@"result"]) {
                     DAGNewsDetailList *model = [DAGNewsDetailList new];
                     [model setValuesForKeysWithDictionary:dict];
                     if ([model.img isEqualToString:@""]) {
                            continue;
                     }
                     [self.NewsDetailArray addObject:model];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                     finish();
              });
       }];
}











@end
