//
//  DAGJokeTableViewCell.h
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DAGFunPicModel;

@protocol DAGFunPicModelDelegate <NSObject>

//通过cell拿到这个cell的index
- (void)modelIsCellDeletageWith:(UITableViewCell *)cell;


@end

@interface DAGJokeTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *updateLab; // 更新时间标签

@property (weak, nonatomic) IBOutlet UILabel *contentLab; // 内容标签

@property (weak, nonatomic) IBOutlet UIImageView *photoView; // 图像标签

@property (nonatomic, strong)DAGFunPicModel *model;

@property (nonatomic, weak)id<DAGFunPicModelDelegate>delegate;

// 图片加载
- (void)setimageWithModel:(DAGFunPicModel *)model;

@end
