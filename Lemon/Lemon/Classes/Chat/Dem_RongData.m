//
//  Dem_RongData.m
//  Lemon
//
//  Created by shang on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_RongData.h"
#import <CommonCrypto/CommonDigest.h>

@interface Dem_RongData ()

@end

@implementation Dem_RongData
#pragma mark获取Token
//注册请求
- (void)postRequestWithName:(NSString *)name  block:(void(^)(NSString * token))block{
    //POST请求 请求参数放在请求内部(httpBody)
    //设置请求
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = 10;
    request.HTTPMethod = @"POST";
    request.URL = [NSURL URLWithString:@"https://api.cn.rong.io/user/getToken.json"];
    
    NSString * appkey = RongAppKey;
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%ld",(NSInteger)[NSDate timeIntervalSinceReferenceDate]];
    //配置http header
    [request setValue:appkey forHTTPHeaderField:@"App-Key"];
    [request setValue:nonce forHTTPHeaderField:@"Nonce"];
    [request setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [request setValue:@"npmSTRJIEYhgKK" forHTTPHeaderField:@"appSecret"];
    //生成hashcode 用以验证签名
    [request setValue:[self sha1:[NSString stringWithFormat:@"%@%@%@",appkey,nonce,timestamp]] forHTTPHeaderField:@"Signature"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:name forKey:@"userId"];
    [paramDic setObject:name forKey:@"name"];
    //    [paramDic setObject:@"http://img.woyaogexing.com/2016/02/23/9678054811c8c694!200x200.jpg" forKey:@"portraitUri"];
    
    request.HTTPBody = [self httpBodyFromParamDictionary:paramDic];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
           
           
           if (data == nil) {
                  return ;
           }
           
        NSDictionary *dic = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:nil];
        NSString *Token = dic[@"token"];
        block(Token);
    }];
}

- (NSData *)httpBodyFromParamDictionary:(NSDictionary *)param{
    NSMutableString * data = [NSMutableString string];
    for (NSString * key in param.allKeys) {
        [data appendFormat:@"%@=%@&",key,param[key]];
    }
    return [[data substringToIndex:data.length-1] dataUsingEncoding:NSUTF8StringEncoding];
}

//hash算法
- (NSString*) sha1:(NSString *)hashString{
    const char *cstr = [hashString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:hashString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


@end
