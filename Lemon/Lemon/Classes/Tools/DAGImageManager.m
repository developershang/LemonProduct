//
//  DAGImageManager.m
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGImageManager.h"
#import "AppDelegate.h"
#import "DAGDataBase.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Dem_UserData.h"
@interface DAGImageManager ()

- (CGSize)preferredSize:(UIImage *)image;

@end

@implementation DAGImageManager



- (id)initWithFrame:(CGRect)frame {
       self = [super initWithFrame:frame];
       if (self) {
              self.backgroundColor = [UIColor clearColor];
              _contentView = [[UIScrollView alloc] initWithFrame:frame];
              _contentView.backgroundColor = [UIColor whiteColor];
              _contentView.delegate = self;
              _contentView.bouncesZoom = YES;
              _contentView.minimumZoomScale = 0.5;
              _contentView.maximumZoomScale = 5.0;
              _contentView.showsHorizontalScrollIndicator = NO;
              _contentView.showsVerticalScrollIndicator = NO;
              [self addSubview:_contentView];
              
              _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
              _imageView.userInteractionEnabled = YES;
              [_contentView addSubview:_imageView];
              
              //为图片添加手势
              
              UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage)];
              
              tapGesture.numberOfTapsRequired = 1;
              
              tapGesture.enabled =YES;
              
              [tapGesture delaysTouchesBegan];
              
              [tapGesture cancelsTouchesInView];
              
              [_imageView addGestureRecognizer:tapGesture];
              
              
              
              _collectionButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
              
              _collectionButton.frame =CGRectMake(frame.origin.x + frame.size.width  - 70, frame.origin.y + frame.size.height - 50, 60, 40);
              
              [_collectionButton setTitle:@"保存"forState:(UIControlStateNormal)];
              
              [self addSubview:_collectionButton];
              
              [_collectionButton addTarget:self action:@selector(didClickCollectionButtonAction:)forControlEvents:(UIControlEventTouchDown)];
              
              //为视图增加边框
              
              _collectionButton.layer.masksToBounds=YES;
              
              _collectionButton.layer.cornerRadius = 5.0;
              
              _collectionButton.layer.borderWidth=1.0;
              
              _collectionButton.layer.borderColor=[[UIColor lightGrayColor] CGColor];
              
              [_collectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
              
              
              
              
       }
       
       return self;
       
       
}

- (void)didClickCollectionButtonAction:(UIButton *)button{
       
       //直接存入本地相册可以用：
       
       UIImageWriteToSavedPhotosAlbum(_imageView.image,nil,nil, nil);
       
       //需要回调方法或者检验是否存入成功：
       
       UIImageWriteToSavedPhotosAlbum(_imageView.image,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
       
       NSData *data = UIImageJPEGRepresentation(_imageView.image, 1.0f);
       NSString *imageStr = [data base64Encoding];
       
       NSString *currentUserName = [Dem_UserData shareInstance].user.username;
       NSLog(@"%@",currentUserName);
       [[DAGDataBase shareInstance] addImage:imageStr user:currentUserName];
       
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
       
       
       
       if (error !=NULL) {
              
              UIAlertView *photoSave = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",error]delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
              
              [photoSave show];
              
              [photoSave dismissWithClickedButtonIndex:0 animated:YES];
              
              
              photoSave =nil;
              
       }else {
              
              UIAlertView *photoSave = [[UIAlertView alloc]initWithTitle:@"\n\n保存成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
              
              [photoSave show];
              
              [photoSave dismissWithClickedButtonIndex:0 animated:YES];
              
              
              photoSave =nil;
              
       }
       
}


- (void) setImage:(UIImage *) image {
       
       CGSize size = [self preferredSize:image];
       
       _imageView.frame =CGRectMake(0, 0, size.width, size.height);
       
       
       
       _contentView.contentSize= size;
       
       
       
       _imageView.center =self.center;
       
       _imageView.image = image;
       
}


- (CGSize) preferredSize:(UIImage *) image {
       
       
       
       CGFloat width = 0.0, height = 0.0;
       
       CGFloat rat0 = image.size.width / image.size.height;
       
       CGFloat rat1 =self.frame.size.width /self.frame.size.height;
       
       if (rat0 > rat1) {
              
              width =self.frame.size.width;
              
              height = width / rat0;
              
       }else {
              
              height =self.frame.size.height;
              
              width = height * rat0;
              
       }
       
       
       
       return CGSizeMake(width, height);
       
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
       
       return _imageView;
       
}


-(void) scrollViewDidZoom:(UIScrollView *)scrollView{
       
       CGFloat x = scrollView.center.x,y = scrollView.center.y;
       
       x = scrollView.contentSize.width > scrollView.frame.size.width?scrollView.contentSize.width/2 :x;
       
       y = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height/2 : y;
       
       _imageView.center =CGPointMake(x, y);
       
}


- (void) showImage {
       
       
       
       _contentView.transform =CGAffineTransformMakeScale(0.1, 0.1);
       
       _contentView.alpha = 0;
       
       _collectionButton.alpha = 0;
       
       
       
       [UIView animateWithDuration:0.5 animations:^{
              
              _contentView.alpha = 1.0;
              
              _collectionButton.alpha = 1.0;
              
              _contentView.transform =CGAffineTransformMakeScale(1, 1);
              
              _contentView.center=self.center;
              
       }];
       
       
       
}


-  (void) hideImage {
       
       [UIView animateWithDuration:0.25 animations:^{
              
              _contentView.transform =CGAffineTransformMakeScale(0.1, 0.1);
              
              _contentView.alpha = 0;
              
              _collectionButton.alpha = 0;
              
       }completion:^(BOOL finished) {
              
              if (finished) {
                     
                     _contentView.alpha=1;
                     
                     [_contentView removeFromSuperview];
                     
                     [_imageView removeFromSuperview];
                     
                     [self removeFromSuperview];
                     
              }
              
       }];
       
}


+ (void) viewWithImage:(UIImage *) image {
       
       
       AppDelegate * delegate = ((AppDelegate *)[UIApplication sharedApplication].delegate);
       
       UIWindow * window = delegate.window;
       
       DAGImageManager * imageViewer = [[DAGImageManager alloc]initWithFrame:window.frame];
       
       [imageViewer setImage:image];
       
       
       
       [window addSubview:imageViewer];
       
       [imageViewer showImage];
       
}


@end
