//
//  DAGJokeTableViewCell.h
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DAGFunPicModel;

@protocol DAGFunPicModelDelegate <NSObject>

//通过cell拿到这个cell的index
- (void)modelIsCellDeletageWith:(UITableViewCell *)cell;


@end

@interface DAGJokeTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *updateLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (nonatomic, strong)DAGFunPicModel *model;

@property (nonatomic, weak)id<DAGFunPicModelDelegate>delegate;

- (void)setimageWithModel:(DAGFunPicModel *)model;

@end
