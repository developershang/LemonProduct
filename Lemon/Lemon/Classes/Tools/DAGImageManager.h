//
//  DAGImageManager.h
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAGImageManager : UIView<UIScrollViewDelegate>

{
       UIImageView * _imageView;
       UIScrollView *_contentView;
       UIButton *_collectionButton;
}

- (void)showImage;

- (void)hideImage;

- (void)setImage:(UIImage *)image;

+ (void)viewWithImage:(UIImage *)image;


@end
