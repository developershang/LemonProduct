//
//  XU_NetTools.m
//  UILesson17_NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "XU_NetTools.h"

@implementation XU_NetTools

+(void)solveDataWithUrl:(NSString *)StringUrl httpMethod:(NSString *)method httpBody:(NSString *)stringBody revokeBlock:(DataBlock)block{
    NSURL *url = [NSURL URLWithString:StringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //将所有的字母转换成大写
    NSString *smethod = [method uppercaseString];
    if ([@"POST" isEqualToString: smethod]) {
        [request setHTTPMethod:smethod];
        NSData *bodyData = [stringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
        
    }else if([@"GET" isEqualToString:smethod]){
        
    }else{
        @throw [NSException exceptionWithName:@"Param Error" reason:@"方法类型参数错误" userInfo:nil];
        return;
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        block(data);
    }];
}

+(void)newSolveDataWithUrl:(NSString *)StringUrl httpMethod:(NSString *)method httpBody:(NSString *)stringBody revokeBloc:(DataBlock)block{
    NSURL *url = [NSURL URLWithString:StringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString *smethod = [method uppercaseString];
    if ([@"POST" isEqualToString: smethod]) {
        [request setHTTPMethod:smethod];
        NSData *bodyData = [stringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }else if ([@"GET" isEqualToString:smethod]){
        
    }else{
        @throw [NSException exceptionWithName:@"Param Error" reason:@"方法类型参数错误" userInfo:nil];
        return;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data);
    }];
    [task resume];
}

+(void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block{
    //1创建url
    NSURL *url = [NSURL URLWithString:stringUrl];
    //2创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //3创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //4创建任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:imageData];
        //从子线程回到主线程进行界面更新
        dispatch_async(dispatch_get_main_queue(), ^{
            block(image);
        });
    } ];   //启动任务
    [task resume];
}


@end
