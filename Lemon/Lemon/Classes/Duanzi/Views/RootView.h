//
//  RootView.h
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViwe.h"
@interface RootView : UIView

@property (nonatomic, strong)UIScrollView *sv;
@property (nonatomic, strong)TableViwe *table;
@property (nonatomic, strong)UISegmentedControl *segement;

@end
