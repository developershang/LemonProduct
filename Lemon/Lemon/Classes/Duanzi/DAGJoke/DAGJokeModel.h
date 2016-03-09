//
//  DAGJokeModel.h
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAGJokeModel : NSObject

@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *updatetime;

@property (nonatomic, assign)NSInteger unixtime;

@property (nonatomic, copy)NSString *hashId;


@end
