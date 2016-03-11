//
//  PicTableViewCell.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "PicTableViewCell.h"

@implementation PicTableViewCell

- (void)awakeFromNib {
    self.like = 0;
    self.userPhotoView.layer.masksToBounds = YES;
    self.userPhotoView.layer.cornerRadius = self.userPhotoView.frame.size.width *0.5;
    
}




- (IBAction)likeActionButton:(UIButton *)sender {

    
}

- (IBAction)disLikeActionButton:(UIButton *)sender {
      NSLog(@"点击了踩");
}

- (IBAction)commentActionButton:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"comment" object:nil];
    
    NSLog(@"点击了评论");
}

- (IBAction)shareAction:(UIButton *)sender {
      NSLog(@"点击了分享");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
