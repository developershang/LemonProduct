//
//  DAGRequestData.h
//  Lemon
//
//  Created by shang on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAGRequestData : NSObject

// 通过请求数据 判断网络是否可用
+ (NSDictionary *)requestDatawithUrl:(NSString *)aurl;

@end
