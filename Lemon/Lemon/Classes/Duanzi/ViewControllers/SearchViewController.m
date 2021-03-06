//
//  SearchViewController.m
//  Lemon
//
//  Created by shang on 16/3/8.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "SearchViewController.h"
#import "DataHandel.h"
#import "SG_Model.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchDisplayDelegate>
@property (nonatomic, strong)NSMutableArray *titleArray;
@property (nonatomic, strong)NSMutableArray *indexArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.table.delegate = self;
    self.table.dataSource = self;
    self.searchBar.placeholder = @"请输入搜索标题";
    
    // Do any additional setup after loading the view from its nib.
}


-(NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


- (NSMutableArray *)indexArray{
    
    if (_indexArray  == nil) {
        _indexArray = [NSMutableArray array];
    }
    
    return _indexArray;

}


- (IBAction)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text isEqualToString:@""]) {
        return;
    }else{
        self.titleArray = [NSMutableArray array];
      NSMutableArray *arr = [DataHandel shareInstance].DataArray;

        for (SG_Model *model in arr) {
            
            if ([model.text containsString:searchBar.text]) {
                [self.titleArray addObject:model.text];
            }
        }
        [self.table reloadData];
    }}
    
}*/


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 
    self.titleArray = [NSMutableArray array];
    NSMutableArray *arr = [DataHandel shareInstance].DataArray;
    
    for (SG_Model *model in arr) {
        
        if ([model.text containsString:searchBar.text]) {
           
            [self.titleArray addObject:model.text];
            NSInteger  i =  [arr indexOfObject:model];
            NSLog(@"包含%ld-----",i);
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.indexArray addObject: indexpath];
            
        }
           
        
    }
    [self.table reloadData];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArray.count;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    return YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"main_cell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];

    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [DataHandel shareInstance].indexPath =  self.indexArray[indexPath.row];
    NSLog(@"点解了第%ld个",[DataHandel shareInstance].indexPath.row);
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
