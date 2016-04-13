//
//  DAGImageManager.h
//  Lemon
//
//  Created by shang on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAGImageManager : UIView<UIScrollViewDelegate>

{
       UIImageView * _imageView;
       UIScrollView *_contentView;
       UIButton *_collectionButton;
}

// 显示图片
- (void)showImage;

// 隐藏图片
- (void)hideImage;

- (void)setImage:(UIImage *)image;


// 点击后图片的响应事件
+ (void)viewWithImage:(UIImage *)image;


@end
