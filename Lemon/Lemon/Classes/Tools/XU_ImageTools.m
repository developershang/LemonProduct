//
//  XU_ImageTools.m
//  知聊
//
//  Created by shang on 16/1/27.
//  Copyright © 2016年 XuMengyu. All rights reserved.
//

#import "XU_ImageTools.h"


static CGRect oldframe;
@implementation XU_ImageTools
#pragma mark边缘清晰
+(UIImage*) blur:(UIImage*)theImage{
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];
    
    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];
    
    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:extendedImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    //create a UIImage for this function to "return" so that ARC can manage the memory of the blur...
    //ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}


#pragma mark边缘模糊
+(UIImage*)blurLayerImage:(UIImage *)theImage{
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:inputImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    //create a UIImage for this function to "return" so that ARC can manage the memory of the blur...
    //ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}

#pragma mark图片放大
+(void)showImage:(UIImageView*)avatarImageView{
    
    UIImage *image=avatarImageView.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake( 0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}
+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}


// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
       NSURL* URL = nil;
       if([imageURL isKindOfClass:[NSURL class]]){
              URL = imageURL;
       }
       if([imageURL isKindOfClass:[NSString class]]){
              URL = [NSURL URLWithString:imageURL];
       }
       if(URL == nil)
              return CGSizeZero;                  // url不正确返回CGSizeZero
       
       NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
       NSString* pathExtendsion = [URL.pathExtension lowercaseString];
       
       CGSize size = CGSizeZero;
       if([pathExtendsion isEqualToString:@"png"]){
              size =  [self getPNGImageSizeWithRequest:request];
       }
       else if([pathExtendsion isEqual:@"gif"])
       {
              size =  [self getGIFImageSizeWithRequest:request];
       }
       else{
              size = [self getJPGImageSizeWithRequest:request];
       }
       if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
       {
              NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
              UIImage* image = [UIImage imageWithData:data];
              if(image)
              {
                     size = image.size;
              }
       }
       return size;
}
//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
       [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
       NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
       if(data.length == 8)
       {
              int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
              [data getBytes:&w1 range:NSMakeRange(0, 1)];
              [data getBytes:&w2 range:NSMakeRange(1, 1)];
              [data getBytes:&w3 range:NSMakeRange(2, 1)];
              [data getBytes:&w4 range:NSMakeRange(3, 1)];
              int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
              int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
              [data getBytes:&h1 range:NSMakeRange(4, 1)];
              [data getBytes:&h2 range:NSMakeRange(5, 1)];
              [data getBytes:&h3 range:NSMakeRange(6, 1)];
              [data getBytes:&h4 range:NSMakeRange(7, 1)];
              int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
              return CGSizeMake(w, h);
       }
       return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
       [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
       NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
       if(data.length == 4)
       {
              short w1 = 0, w2 = 0;
              [data getBytes:&w1 range:NSMakeRange(0, 1)];
              [data getBytes:&w2 range:NSMakeRange(1, 1)];
              short w = w1 + (w2 << 8);
              short h1 = 0, h2 = 0;
              [data getBytes:&h1 range:NSMakeRange(2, 1)];
              [data getBytes:&h2 range:NSMakeRange(3, 1)];
              short h = h1 + (h2 << 8);
              return CGSizeMake(w, h);
       }
       return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
       [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
       NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
       
       if ([data length] <= 0x58) {
              return CGSizeZero;
       }
       
       if ([data length] < 210) {// 肯定只有一个DQT字段
              short w1 = 0, w2 = 0;
              [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
              [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
              short w = (w1 << 8) + w2;
              short h1 = 0, h2 = 0;
              [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
              [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
              short h = (h1 << 8) + h2;
              return CGSizeMake(w, h);
       } else {
              short word = 0x0;
              [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
              if (word == 0xdb) {
                     [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
                     if (word == 0xdb) {// 两个DQT字段
                            short w1 = 0, w2 = 0;
                            [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                            [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                            short w = (w1 << 8) + w2;
                            short h1 = 0, h2 = 0;
                            [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                            [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                            short h = (h1 << 8) + h2;
                            return CGSizeMake(w, h);
                     } else {// 一个DQT字段
                            short w1 = 0, w2 = 0;
                            [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                            [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                            short w = (w1 << 8) + w2;
                            short h1 = 0, h2 = 0;
                            [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                            [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                            short h = (h1 << 8) + h2;
                            return CGSizeMake(w, h);
                     }
              } else {
                     return CGSizeZero;
              }
       }
}


@end
