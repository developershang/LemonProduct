//
//  DataHandel.h
//  Lemon
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SG_Model;
@interface DataHandel : NSObject

//存储maxtime 拼接字 用于加密解析数据
@property (nonatomic, strong)NSMutableArray*infoDAtaArray;

//存储model 用于解析cell数据
@property (nonatomic, strong)NSMutableArray *DataArray;


@property (nonatomic, strong)NSIndexPath *indexPath;
#pragma mark单例的建立
+(instancetype)shareInstance;

#pragma mark根据文本设置cell高度
- (CGFloat)heightForCell:(NSString *)text;


#pragma mark根据网址请求数据
- (void)requestDuanziDataWithUrl:(NSString *)url
               finshed:(void(^)())finsh;

#pragma mark下拉刷新数据
- (void)requestUpDataWithUrl:(NSString *)url

                     finshed:(void(^)())finsh;
#pragma mark返回数组个数
- (NSInteger)countOfDataArray;


#pragma mark根据索引获取model
- (SG_Model *)modelAtIndexPath:(NSIndexPath*)indexPath;




@end
