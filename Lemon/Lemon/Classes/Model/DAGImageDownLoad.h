//
//  DAGImageDownLoad.h
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface DAGImageDownLoad : NSObject

@property (nonatomic, assign)NSInteger pid;

@property (nonatomic, copy)NSString *imageUrl;

@property (nonatomic, strong)UIImage *image;

@property (nonatomic, copy)NSString *name;

@end
