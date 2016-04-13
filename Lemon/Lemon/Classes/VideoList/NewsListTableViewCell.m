//
//  NewsListTableViewCell.m
//  Lemon
//
//  Created by shang on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "NewsListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DAGNewsDetailList.h"

@implementation NewsListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setimageWithModel:(DAGNewsDetailList *)model {
       
       if (model) {
              [self.PhotoView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     [self.delegate modelIsCellDelegateWith:self];
              }];
       } else {
              [self.PhotoView setImage:[UIImage imageNamed:@"placeholder"]];
       }
       
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
