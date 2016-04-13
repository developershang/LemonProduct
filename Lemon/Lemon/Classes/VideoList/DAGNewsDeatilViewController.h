//
//  DAGNewsDeatilViewController.h
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAGNewsDetail.h"
@interface DAGNewsDeatilViewController : UIViewController

@property (nonatomic, strong)DAGNewsDetail *dnd;


@property (nonatomic, copy)NSString *detailUrl; // 新闻详情的Url
@end
