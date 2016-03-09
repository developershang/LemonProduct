//
//  DAGNewsDetail.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGNewsDetail.h"

@implementation DAGNewsDetail

- (instancetype)initWithFrame:(CGRect)frame
{
       self = [super initWithFrame:frame];
       if (self) {
              [self setupView];
       }
       return self;
}

- (void)setupView {
       self.backgroundColor = [UIColor cyanColor];
       self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       self.webView.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
       self.webView.scalesPageToFit = YES;
       [self addSubview:self.webView];
}


@end
