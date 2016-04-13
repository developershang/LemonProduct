//
//  DAGJokeDetailTableViewCell.h
//  Lemon
//
//  Created by shang on 16/3/4.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAGJokeDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UILabel *updateLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentLab;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end
