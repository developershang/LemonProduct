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

@property (nonatomic, strong)NSMutableArray *infoDAtaArray;
@property (nonatomic, strong)NSMutableArray *DataArray;

+(instancetype)shareInstance;


//根据文本设置cell高度
- (CGFloat)heightForCell:(NSString *)text;


//根据网址请求数据
- (void)requestDuanziDataWithUrl:(NSString *)url
               finshed:(void(^)())finsh;

//下拉刷新数据
- (void)requestUpDataWithUrl:(NSString *)url
                     finshed:(void(^)())finsh;
//返回数组个数
- (NSInteger)countOfDataArray;


//根据索引获取model
- (SG_Model *)modelAtIndexPath:(NSIndexPath*)indexPath;




@end
