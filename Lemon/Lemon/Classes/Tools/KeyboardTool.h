//
//  KeyboardTool.h
//  Lemon
//
//  Created by lanou3g on 16/3/11.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardToolDelegate;

typedef enum {
       kKeyboardToolButtonTypeNext, // 下一个按钮
       kKeyboardToolButtonTypePrevious, // 上一个按钮
       kKeyboardToolButtonTypeDone // 完成按钮
} KeyboardToolButtonType;


@interface KeyboardTool : UIToolbar

// 按钮
@property (nonatomic, readonly) IBOutlet UIBarButtonItem *nextBtn;
@property (nonatomic, readonly) IBOutlet UIBarButtonItem *previousBtn;
@property (nonatomic, readonly) IBOutlet UIBarButtonItem *doneBtn;

// 代理一般用assign策略
@property (nonatomic, weak) id<KeyboardToolDelegate> toolDelegate;

+ (id)keyboardTool;

// 这里写成 - 是为了能在xib中连线
- (IBAction)next;
- (IBAction)previous;
- (IBAction)done;
@end

@protocol KeyboardToolDelegate <NSObject>
- (void)keyboardTool:(KeyboardTool *)tool buttonClick:(KeyboardToolButtonType)type;
@end
