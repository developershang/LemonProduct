//
//  DAGJokeTableViewCell.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGJokeTableViewCell.h"
#import "DAGFunPicModel.h"
#import "UIImageView+WebCache.h"
@implementation DAGJokeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setimageWithModel:(DAGFunPicModel *)model {
       if (model) {
              [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     [self.delegate modelIsCellDeletageWith:self];
              }];
       } else {
              [self.photoView setImage:[UIImage imageNamed:@"placeholder"]];
       }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
