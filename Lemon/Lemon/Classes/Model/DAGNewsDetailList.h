//
//  DAGNewsDetailList.h
//  Lemon
//
//  Created by shang on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAGNewsDetailList : NSObject

@property (nonatomic, copy)NSString *full_title; // 标题

@property (nonatomic, copy)NSString *pdate; // 更新时间

@property (nonatomic, copy)NSString *url; // 详情地址

@property (nonatomic, copy)NSString *pdate_src; // 更新具体时间

@property (nonatomic, copy)NSString *img; // 图片

@property (nonatomic, assign)BOOL isLoading; // 是否被加载



@end
