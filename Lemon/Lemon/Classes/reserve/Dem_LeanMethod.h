//
//  Dem_LeanMethod.h
//  Lemon
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dem_Fpuser;
@class AVUser;
@interface Dem_LeanMethod : NSObject

/**
 *@param
 *@return 添加帖子
 **/
+(void)addFpuserWithUser:(AVUser *)user fpuser:(Dem_Fpuser*)fpuser;

@end
