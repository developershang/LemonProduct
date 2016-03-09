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
#import "Dem_LeanCloudData.h"
#import "Dem_UserModel.h"

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
                block(succeeded);
            }];
        }
    } progressBlock:^(NSInteger percentDone) {
        NSLog(@"%ld",percentDone);
    }];
    [text setObject:file forKey:@"img"];
    NSError *error1 = nil;
    [text save:&error1];
}

+(NSArray<AVObject*>*)theFpuserWithPage:(NSInteger)page {
    AVQuery *query =[AVQuery queryWithClassName:@"Fpuser"];
    query.limit = 30;
    if (page < 1) {
        return nil;
    }
    query.skip = page-1;
    [query orderByDescending:@"createdAt"];
    NSArray *arr = [query findObjects];
    return arr;
}

+(void)theContentWithFpuser:(AVObject *)fpuser fpus:(void(^)(Dem_Fpuser*fpusers))fpus mo:(void(^)(Dem_UserModel *user))mo{
    Dem_Fpuser *fp = [[Dem_Fpuser alloc]init];
    AVFile *file = [fpuser objectForKey:@"img"];
    NSData *data = [file getData];
    fp.img = [UIImage imageWithData:data];
    fp.content = [fpuser objectForKey:@"content"];
    AVUser *user = [fpuser objectForKey:@"user"];
    [Dem_LeanCloudData intermationWithUser:user block:^(AVObject *users) {
        AVFile *file = [fpuser objectForKey:@"photo"];
        NSData *data = [file getData];
       
        Dem_UserModel *model = [[Dem_UserModel alloc]init];
        model.photo =[UIImage imageWithData:data];
        model.username = [users objectForKey:@"nid"];
        fpus(fp);
        mo(model);
    }];
}

@end
