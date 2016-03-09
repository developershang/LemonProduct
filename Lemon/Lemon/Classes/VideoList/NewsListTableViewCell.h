//
//  NewsListTableViewCell.h
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *PhotoView;


@property (weak, nonatomic) IBOutlet UILabel *TitleLab;

@property (weak, nonatomic) IBOutlet UILabel *UpdateTimeLab;

@end
