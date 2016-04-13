//
//  AppDelegate.h
//  Lemon
//
//  Created by shang on 16/2/29.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTTPServer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
       HTTPServer *httpServer;
}
@property (strong, nonatomic) UIWindow *window;


@end

