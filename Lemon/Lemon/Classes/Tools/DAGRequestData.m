//
//  DAGRequestData.m
//  Lemon
//
//  Created by shang on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGRequestData.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>


@implementation DAGRequestData

+(NSDictionary *)requestDatawithUrl:(NSString *)aurl
{
       // 判断当前网络状态是否能够请求数据
       NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
//       NSLog(@"%@",[ud valueForKey:@"NetWorkStatus"]);
       //创建UIActivityIndicatorView背底半透明View
       
              if ([[ud valueForKey:@"NetWorkStatus"] isEqualToString:@"NotReachable"]) {
              UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"检测到您当前没有可用网络,请检查网络连接" preferredStyle:UIAlertControllerStyleAlert];
              UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     
              }];
              UIViewController *vc = [UIApplication sharedApplication].windows[1].rootViewController;
              [alert addAction:action];
              [vc presentViewController:alert animated:YES completion:nil];
              return nil;
       }
       
       Reachability * ability = [Reachability reachabilityForInternetConnection];
       if (ability.currentReachabilityStatus == ReachableViaWiFi) {
              
       }else if (ability.currentReachabilityStatus == ReachableViaWWAN){
              
       }else {
              
              UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
              UIAlertAction *action = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     
              }];
              [alert1 addAction:action];
              [alert1 showViewController:alert1 sender:nil];
              return nil;
       }
       
       
       // 1.转成 URL
       NSURL * url = [[NSURL alloc]initWithString:aurl];
       
       // 2.创建请求对象
       NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
       
       // 3.创建 响应 和 错误
       NSURLResponse * response = nil;
       NSError * error = nil;
       
       // 4.开始请求获取响应,建立连接.同步请求.
       NSData * data =
       [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
       
       if (data == nil) {
              return nil;
       }
       
       // 解析字典 json
       NSDictionary * dataDict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
       
       return dataDict;
}


@end
