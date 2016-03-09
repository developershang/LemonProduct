//
//  XU_ImageTools.h
//  知聊
//
//  Created by lanou3g on 16/1/27.
//  Copyright © 2016年 XuMengyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XU_ImageTools : UIImage


/**
 *@param 图片模糊(边缘清晰)
 *@return UIImage
 **/
+(UIImage*)blur:(UIImage*)theImage;

/**
 *@param 图片模糊(边缘透明)
 *@return UIImage
 **/
+(UIImage*)blurLayerImage:(UIImage *)theImage;

/**
 *@param 图片放大显示
 *@return ImageView
 **/
+(void)showImage:(UIImageView*)avatarImageView;


+(CGSize)getImageSizeWithURL:(id)imageURL;

@end
