//
//  TextTableViewCell.m
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (void)awakeFromNib {
    self.userPhotoView.layer.masksToBounds = YES;
    self.userPhotoView.layer.cornerRadius = self.userPhotoView.frame.size.width *0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
