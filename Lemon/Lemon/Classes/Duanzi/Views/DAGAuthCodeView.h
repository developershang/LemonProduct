//
//  DAGAuthCodeView.h
//  Lemon
//
//  Created by shang on 16/3/7.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 自定义验证码View
 */

@interface DAGAuthCodeView : UIView


// 记录生成的验证码
@property (nonatomic, strong) NSMutableString *code;


@end
