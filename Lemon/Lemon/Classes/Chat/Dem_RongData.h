//
//  Dem_RongData.h
//  Lemon
//
//  Created by shang on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dem_RongData : NSObject

/**
 *@param 获取Token
 *@return token
 **/

#pragma mark获取Token

- (void)postRequestWithName:(NSString *)name block:(void(^)(NSString * token))block;


@end
