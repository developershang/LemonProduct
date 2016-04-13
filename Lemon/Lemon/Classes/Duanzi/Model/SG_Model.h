//
//  SG_Model.h
//  Lemon
//
//  Created by shang on 16/3/3.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SG_Model : NSObject


#pragma mark 建立Json数据model
@property (nonatomic, strong)NSString *profile_image;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)NSString *love;
@property (nonatomic, strong)NSString *hate;
@property (nonatomic, strong)NSString *comment;
@property (nonatomic, strong)NSString *image0;
@property (nonatomic, strong)NSString *width;
@property (nonatomic, strong)NSString *height;
@property (nonatomic, strong)NSString *maxtime;

@property (nonatomic, strong)NSString *weixin_url;

@property (nonatomic, strong)NSString* user_id;


@end
