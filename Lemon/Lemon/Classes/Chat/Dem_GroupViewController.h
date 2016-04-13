//
//  Dem_GroupViewController.h
//  Lemon
//
//  Created by shang on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockGroup)(int);

@interface Dem_GroupViewController : UIViewController
@property(nonatomic ,strong)NSArray *group;
@property(nonatomic,copy)BlockGroup block;
@end
