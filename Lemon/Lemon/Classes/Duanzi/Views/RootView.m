//
//  RootView.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "RootView.h"

@implementation RootView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark MVC设计思想设计视图
- (void)setup{
    
    self.backgroundColor = [UIColor blackColor];
    self.segement = [[UISegmentedControl alloc] initWithItems:@[@"段子",@"图片",@"笑话",@"动图"]];
    self.segement.frame = CGRectMake(0, 64, self.frame.size.width, 30);
    self.segement.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.segement];
    
    
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, self.frame.size.width, self.frame.size.height - 94 - 49 ) style:UITableViewStylePlain];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       imageView.image = [UIImage imageNamed:@"cat.jpg"];
    self.table.backgroundView = imageView;
    [self addSubview:self.table];


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
