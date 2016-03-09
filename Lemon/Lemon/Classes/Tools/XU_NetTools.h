//
//  XU_NetTools.h
//  UILesson17_NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DataBlock)(NSData *data);

typedef void(^ImageSolveBlock)(UIImage *image);

@interface XU_NetTools : NSObject
//封装的旧方法
+(void)solveDataWithUrl:(NSString *)StringUrl
                  httpMethod:(NSString*)method
               httpBody:(NSString *)stringBody
            revokeBlock:(DataBlock)block;
//新方法
//如果是解析
+(void)newSolveDataWithUrl:(NSString *)StringUrl httpMethod:(NSString*)method httpBody:(NSString*)stringBody revokeBloc:(DataBlock)block;


//如果是下载图片
+(void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block;

@end
