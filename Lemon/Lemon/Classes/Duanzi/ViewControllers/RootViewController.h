//
//  RootViewController.h
//  Lemon
//
//  Created by shang on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "RootView.h"
#import "Dem_UserData.h"
@interface RootViewController : UIViewController

@property (nonatomic, strong)RootView *rv;
@property (nonatomic, strong)UIRefreshControl *refresh;

@end
