//
//  KeyboardTool.m
//  Lemon
//
//  Created by shang on 16/3/11.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "KeyboardTool.h"

@implementation KeyboardTool

#pragma mark 从xib文件中初始化一个KeyboardTool
+ (id)keyboardTool {
       // owner可以传KeyboardTool这个类
       // 点击"下一个"按钮的时候，要调用owner的next方法
       
       NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"keyboardTool" owner:nil options:nil];
       
       // 返回初始化完毕的KeyboardTool
       return [array lastObject];
}

#pragma mark - 按钮点击
- (void)next {
       if ([_toolDelegate respondsToSelector:@selector(keyboardTool:buttonClick:)]) {
              [_toolDelegate keyboardTool:self buttonClick:kKeyboardToolButtonTypeNext];
       }
}

- (void)previous {
       if ([_toolDelegate respondsToSelector:@selector(keyboardTool:buttonClick:)]) {
              [_toolDelegate keyboardTool:self buttonClick:kKeyboardToolButtonTypePrevious];
       }
}

- (void)done {
       if ([_toolDelegate respondsToSelector:@selector(keyboardTool:buttonClick:)]) {
              [_toolDelegate keyboardTool:self buttonClick:kKeyboardToolButtonTypeDone];
       }
}


@end
