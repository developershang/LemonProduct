//
//  DAGJokeDetailViewController.h
//  Lemon
//
//  Created by shang on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAGJokeDetailViewController : UIViewController


@property (nonatomic, copy)NSString *updateText;

@property (nonatomic, copy)NSString *contentText;

@property (nonatomic, copy)NSString *clickText;

@property (nonatomic, strong)UITableView *DetailTableView;

@property (nonatomic, strong)NSIndexPath *indexPath;


@end
