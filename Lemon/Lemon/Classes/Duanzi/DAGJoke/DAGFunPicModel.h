//
//  DAGFunPicModel.h
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAGFunPicModel : NSObject

@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *updatetime;

@property (nonatomic, assign)NSInteger unixtime;

@property (nonatomic, copy)NSString *hashId;

@property (nonatomic, copy)NSString *url;

@property (nonatomic, assign)BOOL isLoading; // 判断是否正在加载

@end
