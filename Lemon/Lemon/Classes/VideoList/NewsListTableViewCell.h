//
//  NewsListTableViewCell.h
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DAGNewsDetailList;

@protocol DAGNewsDetailDelegate <NSObject>

- (void)modelIsCellDelegateWith:(UITableViewCell *)cell;

@end

@interface NewsListTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *PhotoView;


@property (weak, nonatomic) IBOutlet UILabel *TitleLab;

@property (weak, nonatomic) IBOutlet UILabel *UpdateTimeLab;

@property (nonatomic, assign)id<DAGNewsDetailDelegate>delegate;


// 图片加载
- (void)setimageWithModel:(DAGNewsDetailList *)model;

@end
