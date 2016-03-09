//
//  DAGJokeTableViewCell2.h
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DAGJokeModel;

@interface DAGJokeTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *updateLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UIButton *ClickBtn;

@property (weak, nonatomic) IBOutlet UIButton *CommmentBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (nonatomic, strong)DAGJokeModel *model;


@end
