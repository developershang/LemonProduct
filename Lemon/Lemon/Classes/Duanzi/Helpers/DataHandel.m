//
//  DataHandel.m
//  Lemon
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DataHandel.h"
#import "SG_NetTools.h"
#import "SG_Model.h"
@interface DataHandel ()


@end

static DataHandel *datahandel;


@implementation DataHandel

#pragma mark 懒加载model数组
- (NSMutableArray *)DataArray{
    
    if (_DataArray == nil) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

#pragma mark 懒加载maxtime数组
- (NSMutableArray *)infoDAtaArray{
    if (_infoDAtaArray == nil) {
        _infoDAtaArray = [NSMutableArray array];
    }
    return _infoDAtaArray;
}

#pragma mark 初始化单例
+(instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        datahandel = [[DataHandel alloc] init];
    });
    return datahandel;

}


#pragma mark 根据text 返回一个高度
- (CGFloat)heightForCell:(NSString *)text{
    //    计算1： 给准备工作
    CGSize size = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) -10, 20000);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    //    计算2 通过字符串获得rect
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height ;
    
}


#pragma mark根据网址请求数据
- (void)requestDuanziDataWithUrl:(NSString *)url
                         finshed:(void(^)())finsh{
   

    
    [SG_NetTools SessionDataWith:url httpmethod:@"GET" httpbody:nil revokeBlock:^(NSData *data) {
        
        [self.DataArray removeAllObjects];
        [self.infoDAtaArray removeAllObjects];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableDictionary *infodic = dic[@"info"];
        [self.infoDAtaArray addObject:[infodic objectForKey:@"maxtime"]];

        NSMutableArray *array = dic[@"list"];
        for (NSDictionary *dict in array) {
          
            SG_Model *model = [[SG_Model alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.DataArray addObject:model];

        };
        
         dispatch_async(dispatch_get_main_queue(), ^{
             
               finsh();
         });
        
    }];
}



#pragma mark刷新请求数据
- (void)requestUpDataWithUrl:(NSString *)url
                         finshed:(void(^)())finsh{
    
    
    
    [SG_NetTools SessionDataWith:url httpmethod:@"GET" httpbody:nil revokeBlock:^(NSData *data) {
        

        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableDictionary *infodic = dic[@"info"];
        [self.infoDAtaArray addObject:[infodic objectForKey:@"maxtime"]];
        NSLog(@"maxtime ===  %@",self.infoDAtaArray);
        
        NSMutableArray *array = dic[@"list"];
        
        for (NSDictionary *dict in array) {
            
            SG_Model *model = [[SG_Model alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            
            [self.DataArray addObject:model];
            
        };
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            finsh();
        });
        
    }];
}


#pragma mark返回数组个数
- (NSInteger)countOfDataArray{
    
    return self.DataArray.count;
    
}


#pragma mark根据索引获取model
- (SG_Model *)modelAtIndexPath:(NSIndexPath*)indexPath{
    
    
    SG_Model *model = self.DataArray[indexPath.row];
    return model;
    
}









@end
