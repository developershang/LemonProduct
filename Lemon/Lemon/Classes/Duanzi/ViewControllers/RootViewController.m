//
//  RootViewController.m
//  Lemon
//
//  Created by shang on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "RootViewController.h"
#import "TextTableViewCell.h"
#import "PicTableViewCell.h"
#import "DataHandel.h"
#import "MJRefresh.h"
#import "DataHandel.h"
#import "SG_Model.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "XU_ImageTools.h"
#import "DAGImageManager.h"
#import "DAGJokeViewController.h"

@interface RootViewController ()<UITableViewDataSource ,UITableViewDelegate>


@property (nonatomic, strong)UIImageView *photo;

@end
NSInteger selectedIndex = 1;
@implementation RootViewController

- (void)loadView{
    [super loadView];
    self.rv = [[RootView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rv;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"笑料百态";
    self.rv.table.delegate = self;
    self.rv.table.dataSource = self;
    
    //设置自动调整scrollView边距为NO 使其不调整
   // self.automaticallyAdjustsScrollViewInsets = YES;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpAtion:) name:@"jump" object:nil];
    
    
  
    [self.rv.segement addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.rv.table addHeaderWithTarget:self action:@selector(headerRefreshing)];
 
    [self.rv.table registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextCell"];
    [self.rv.table registerNib:[UINib nibWithNibName:@"PicTableViewCell" bundle:nil] forCellReuseIdentifier:@"PicCell"];
    
    [[DataHandel shareInstance] requestDuanziDataWithUrl:PicURL finshed:^{
       [self.rv.table reloadData];
    }];

}

#pragma mark 搜索控制器跳转
- (void) searchAction:(UIBarButtonItem *)sender{
    SearchViewController *search = [[SearchViewController alloc] init];
    [self presentViewController:search animated:YES completion:nil];
}



#pragma mark 首页刷新事件
- (void)headerRefreshing{
    
    [self performSelector:@selector(refreshheader) withObject:nil afterDelay:1.5];
    
}
- (void)refreshheader{
    switch (self.rv.segement.selectedSegmentIndex) {
        case 0:{[[DataHandel shareInstance]requestDuanziDataWithUrl:DuziUrl finshed:^{
            [self.rv.table reloadData];
        }]; }break;
        
        case 1:{[[DataHandel shareInstance]requestDuanziDataWithUrl:PicURL finshed:^{
            [self.rv.table reloadData];
        }]; }break;
            
        default:
            break;
    }
    
       [self.rv.table headerEndRefreshing];
}


#pragma mark - Tableview代理方法实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [DataHandel shareInstance].countOfDataArray;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    SG_Model *model = [[DataHandel shareInstance]modelAtIndexPath:indexPath];
   if (model.image0 == nil) {
      
     TextTableViewCell *textCell  = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];

       [textCell.userPhotoView sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
        textCell.userNameLabel.text = model.name;
        textCell.ContentsLabel.text = model.text ;
        textCell.CheckDetailLabel.text = [NSString stringWithFormat:@"赞:%@ 踩:%@ 分享:%@", model.love,model.hate,model.comment];
        cell = textCell;

    }else{
        
        PicTableViewCell *picCell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
        
        [picCell.userPhotoView sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
        
       
        
        picCell.userNameLabel.text =model.name;

        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [act setCenter:CGPointMake(picCell.contentImageView.frame.size.width *0.5, picCell.contentImageView.frame.size.height *0.5)];
        [picCell.contentImageView addSubview:act];
        [act startAnimating];
        [picCell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.image0] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [act stopAnimating];
        }];
            
        picCell.contentDetailLabel.text = model.text;
        picCell.checkDetailLabel.text = [NSString stringWithFormat:@"赞:%@    踩:%@    分享:%@", model.love,model.hate,model.comment];
        self.photo = picCell.contentImageView;
        cell = picCell;
    }

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

      SG_Model *model = [[DataHandel shareInstance]modelAtIndexPath:indexPath];

    if (model.image0 == nil) {
        return [[DataHandel shareInstance] heightForCell:model.text] +105 ;
        
    }else{
         return [[DataHandel shareInstance]heightForCell:model.text]+155+self.rv.table.frame.size.width*[model.height floatValue]/[model.width floatValue] ;
    }

    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [[DataHandel shareInstance] countOfDataArray] - 1) {
        
        NSString *newUrl = nil;
        
        switch (self.rv.segement.selectedSegmentIndex) {
                
                
                
            case 0:{
                
                NSString *string = [[DataHandel shareInstance].infoDAtaArray lastObject];
                NSString *str0 = [NSString stringWithFormat:@"mac=&maxtime=%@",string];
                newUrl = [SG_DStringUrl stringByReplacingOccurrencesOfString:@"mac" withString:str0];
                [[DataHandel shareInstance] requestUpDataWithUrl:newUrl finshed:^{
                    [self.rv.table reloadData];
                }];
                
            }break;
                
            case 1:{
                
                NSString *string = [[DataHandel shareInstance].infoDAtaArray lastObject];
                NSString *str1 = [NSString stringWithFormat:@"mac=&maxtime=%@",string];
                newUrl = [SG_StringUrl stringByReplacingOccurrencesOfString:@"mac" withString:str1];
                
                [[DataHandel shareInstance] requestUpDataWithUrl:newUrl finshed:^{
                    [self.rv.table reloadData];
                }];
                
            }break;
                
            default:
                break;
        }
    }
}



#pragma mark segement 切换事件
- (void)segementAction:(UISegmentedControl *)sender{
    
    
    switch (sender.selectedSegmentIndex) {
       
        case 0: {
            
            selectedIndex = sender.selectedSegmentIndex;
            [[DataHandel shareInstance] requestDuanziDataWithUrl:DuziUrl finshed:^{
           
            [self.rv.table reloadData];
            
        }];}break;
            
            
        case 1: {
            selectedIndex = sender.selectedSegmentIndex;
        [[DataHandel shareInstance] requestDuanziDataWithUrl:PicURL finshed:^{
            
            [self.rv.table reloadData];
        }];}break;

            
        case 2: {
            
            
         DAGJokeViewController *dvc = [[DAGJokeViewController alloc] init];
         [self.navigationController pushViewController:dvc animated:YES];
            
        }break;
            
           
            
        default:
            break;
    }
    
}


#pragma mark 通知 搜索返回查找事件
- (void)jumpAtion:(NSNotificationCenter *)notice{
    [self.rv.table scrollToRowAtIndexPath:[DataHandel shareInstance].indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.rv.segement.selectedSegmentIndex =selectedIndex;
    NSLog(@"你好啊");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"触摸完毕");
    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"触摸");
}





@end
