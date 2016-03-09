//
//  Dem_LeanMethod.m
//  Lemon
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_LeanMethod.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Dem_Fpuser.h"

@implementation Dem_LeanMethod

+(void)addFpuserWithUser:(AVUser *)user fpuser:(Dem_Fpuser*)fpuser block:(void(^)(BOOL save))block{
    AVObject *text = [AVObject objectWithClassName:@"Fpuser"];
    [text setObject:fpuser.content forKey:@"content"];
    [text setObject:user forKey:@"user"];
    NSData *data = UIImagePNGRepresentation(fpuser.img);
    AVFile *file = [AVFile fileWithName:[NSString stringWithFormat:@"%@.png",[NSDate date]] data:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%d",succeeded);
        if (succeeded == 1) {
            [file deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"%@ // %d",error,succeeded);
               // block(succeeded);
            }];
        }
    } progressBlock:^(NSInteger percentDone) {
        NSLog(@"%ld",percentDone);
    }];
    [text setObject:file forKey:@"img"];
    NSError *error1 = nil;
    [text save:&error1];
}




@end
