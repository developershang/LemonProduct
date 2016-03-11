//
//  PicTableViewCell.h
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SG_Model.h"
@interface PicTableViewCell : UITableViewCell

@property (nonatomic, strong)SG_Model *model;
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentDetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *checkDetailLabel;
@property (nonatomic, assign)NSInteger like;

@property (weak, nonatomic) IBOutlet UIButton *picLikeButton;

@end
