//
//  TextTableViewCell.h
//  Lemon
//
//  Created by shang on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ContentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *CheckDetailLabel;


@end
