//
//  AppDelegate.m
//  Lemon
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "UserViewController.h"
#import "DHSlideMenuController.h"
#import "HTTPServer.h"
#import "Dem_LeanCloudData.h"


@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource,RCIMConnectionStatusDelegate>

@end

@implementation AppDelegate

- (void)startServer
{
       // Start the server (and check for problems)
       
       NSError *error;
       if([httpServer start:&error])
       {
              NSLog(@"http 启动成功");
       }
       else
       {
              NSLog(@"http 启动失败");
       }
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
       httpServer = [[HTTPServer alloc] init];
       [httpServer setType:@"_http._tcp."];
       [httpServer setPort:12345];
       
       NSString *webPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
       
       
       [httpServer setDocumentRoot:webPath];
       
       [self startServer];

       
       
//    UserViewController *uvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"uvc"];
    HomeViewController *hvc = [[HomeViewController alloc] init];
    
    DHSlideMenuController * mainVC = [DHSlideMenuController sharedInstance];
    mainVC.mainViewController = hvc;
    mainVC.leftViewController = nil;
    mainVC.animationType = SlideAnimationTypeMove;
    mainVC.needPanFromViewBounds = YES;
    mainVC.leftViewShowWidth = self.window.frame.size.width-100;
    
    //设置主页 shang 03 - 01 - 10:48
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = mainVC;
    
    
    
    
    //链接融云
    [[RCIM sharedRCIM] initWithAppKey:RongAppKey];
    //链接LeanCloud
    [AVOSCloud setApplicationId:@"AyOyjP7aSu9vDKuRuycaTtEr-gzGzoHsz"
                      clientKey:@"wAHc0qfP45Qk7KdLoufEbaem"];
    //融云指定代理
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    // 跟踪 app 打开情况.
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
       
    // Override point for customization after application launch.
    return YES;
}

#pragma mark 用户单聊代理
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    RCUserInfo *user = [[RCUserInfo alloc]init];
    user.userId = userId;
    AVUser *users = [[Dem_LeanCloudData searchUserWithUserName:userId]firstObject];
    
    [Dem_LeanCloudData intermationWithUser:users block:^(AVObject *users) {
        user.name = [users objectForKey:@"nid"];
        AVFile *file =[users objectForKey:@"photo"];
        NSString *fileid = [file objectId];
        AVQuery *query = [AVQuery queryWithClassName:@"_File"];
        AVObject *img = [query getObjectWithId:fileid];
        user.portraitUri =[img objectForKey:@"url"];
    }];
    return completion(user);
}  

#pragma mark 网络状况代理
-(void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status{
    NSLog(@"%ld",(long)status);
}

#pragma mark 群组代理
-(void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
