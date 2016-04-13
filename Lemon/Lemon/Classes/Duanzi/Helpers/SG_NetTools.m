

//
//  SG_NetTools.m
//  UILesson17_NetWorking2
//
//  Created by shang on 15/12/29.
//  Copyright © 2015年 上官伟. All rights reserved.
//

#import "SG_NetTools.h"

@implementation SG_NetTools
//封装的旧方法
+ (void)sloveDataWith:(NSString *)stringUrl
           httpmethod:(NSString *)Httpmethod
             httpbody:(NSString *)Httpbody
          revokeBlock:(DataBlock)block{
    

    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSMutableURLRequest *requset = [[NSMutableURLRequest alloc] initWithURL:url];
    //将所有的字母转换成大写
    NSString *SMethod = [Httpmethod uppercaseString];
    if ([SMethod isEqualToString:@"POST"]) {
            [requset setHTTPMethod:@"POST"];
            NSData *data = [Httpbody dataUsingEncoding:NSUTF8StringEncoding];
            [requset setHTTPBody:data];
    }
    else if([@"GET"isEqualToString:SMethod]||Httpmethod == nil || SMethod == nil){
       
    }else{
        
        NSLog(@"方法类型传参数错误");
        @throw [NSException exceptionWithName:@"SG Param Error " reason:@"方法参数错误" userInfo:nil];
        //创建异常
        return;
    }
    [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        block(data);
    }];

}


//解决图片的加载问题
+(void)SessionDownloadWithUrl:(NSString *)stringUrl
                  revokeBlock:(ImageSolveBlock)block{
    
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSMutableURLRequest *requset = [[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:requset completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:imageData];
       //从子线程回到主线程界面更新
       //iOS中界面更新只能在主线程中进行
  dispatch_async(dispatch_get_main_queue(), ^{ 
      block(image);
  });
    }];
    [task resume];
}


//新方法的加载问题
+(void)SessionDataWith:(NSString *)stringUrl
          httpmethod:(NSString *)Httpmethod
            httpbody:(NSString *)Httpbody
         revokeBlock:(DataBlock)block{
    
    
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSMutableURLRequest *requset = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *SMethod = [Httpmethod uppercaseString];
  
    if ([SMethod isEqualToString:@"POST"]) {
        [requset setHTTPMethod:@"POST"];
        NSData *data = [Httpbody dataUsingEncoding:NSUTF8StringEncoding];
        [requset setHTTPBody:data];
    }
    else if([@"GET"isEqualToString:SMethod]||Httpmethod == nil || SMethod == nil){
    }else{
        
        NSLog(@"方法类型传参数错误");
        @throw [NSException exceptionWithName:@"SG Param Error " reason:@"方法参数错误" userInfo:nil];
        //创建异常
        return;
    }

    NSURLSession *session =[NSURLSession  sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data);
    }];
    
    [task resume];
    
}



+(void)myNetWorkingDatawith:(NSString *)url
                     method:(NSString *)method
                       body:(NSString *)body
                  revoBlock:(DataBlock)block{
    
    NSURL *Url = [[NSURL alloc] initWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:Url];
    
    NSString *string = [method uppercaseString];
    if ([string isEqualToString:@"GET"]||method ==nil) {  
    }
    
  else  if ([@"POST" isEqualToString:string]) {
        [request setHTTPMethod:@"POST"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:body];
        [request setHTTPBody:data];
    }
  else{
      
      NSLog(@"参数输入有误");
  }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        block(data);
        
    }];
}





@end
