//
//  DAGJokeTableViewCell.h
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DAGFunPicModel;
@interface DAGJokeTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *updateLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (nonatomic, strong)DAGFunPicModel *model;

@end
