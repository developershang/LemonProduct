//
//  SG_NetTools.h
//  UILesson17_NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 上官伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^DataBlock)(NSData *data);
typedef void(^ImageSolveBlock)(UIImage *image);

@interface SG_NetTools : NSObject


+ (void)sloveDataWith:(NSString *)stringUrl
           httpmethod:(NSString *)Httpmethod
             httpbody:(NSString *)Httpbody
          revokeBlock:(DataBlock)block;

//新方法的
//如果是解析
//自己写
+(void)SessionDataWith:(NSString *)stringUrl
          httpmethod:(NSString *)Httpmethod
            httpbody:(NSString *)Httpbody
         revokeBlock:(DataBlock)block;

//如果是下载图片
+(void)SessionDownloadWithUrl:(NSString *)stringUrl
                  revokeBlock:(ImageSolveBlock)block;


+(void)myNetWorkingDatawith:(NSString *)url
                     method:(NSString *)method
                       body:(NSString *)body
                  revoBlock:(DataBlock)block;





@end
