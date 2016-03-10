//
//  DAGAuthCodeView.m
//  Lemon
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGAuthCodeView.h"

#define DAGRandomColor [UIColor colorWithRed:arc4random()%180/255.0 green:arc4random()%180/255.0 blue:arc4random()%180/255.0 alpha:1];
#define DAGCount 6;

@interface DAGAuthCodeView ()

@property (nonatomic, strong) NSArray *array;

@end


@implementation DAGAuthCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
       self = [super initWithFrame:frame];
       if (self) {
              self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:0];
              _array = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
       }
       return self;
}

- (void)drawRect:(CGRect)rect {
       self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:0.2];
       CGFloat width = (rect.size.width - 20) / DAGCount;
       NSArray *fontArray = [UIFont familyNames];  // 所有的字体
       self.code = [NSMutableString string];
       // 绘制验证码
       for (int i = 0; i < 4; i++) {
              int flag = arc4random() % (self.array.count - 10);
              NSString *str = self.array[flag];   // 产生随机字符
              [_code appendString:str];   // 拼接到验证码中
              UIColor *color = DAGRandomColor;    // 字符对应的随机色
              
              // 在字符对应的点上画出字符(随机字体，随机颜色)
              NSDictionary *dict = @{NSFontAttributeName : [UIFont fontWithName:fontArray[arc4random() % (fontArray.count - 13)] size:20], NSForegroundColorAttributeName : color};
              [str drawAtPoint:CGPointMake(25 + i * width, 0) withAttributes:dict];
       }
       
       // 绘制干扰线
       CGContextRef context = UIGraphicsGetCurrentContext();
       for (int i = 0; i < 4; i++) {
              CGContextSetLineWidth(context, 1);  // 线条宽度
             CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.000 green:1.000 blue:1.000 alpha:0.5].CGColor);  // 线条颜色
              
              // 设置起点
              CGFloat x = arc4random() % (int)rect.size.width;
              CGFloat y = arc4random() % (int)rect.size.height;
              CGContextMoveToPoint(context, x, y);
              // 设置终点
              x = arc4random() % (int)rect.size.width;
              y = arc4random() % (int)rect.size.height;
              CGContextAddLineToPoint(context, x, y);
              
              // 画线
              CGContextStrokePath(context);
       }
       
       
       
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
       [self drawRect:self.frame];
}




@end
