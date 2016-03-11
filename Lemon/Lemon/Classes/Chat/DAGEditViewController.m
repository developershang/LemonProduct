//
//  DAGEditViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/11.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGEditViewController.h"

@interface DAGEditViewController ()<UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *HeaderImage;

@property (weak, nonatomic) IBOutlet UITextField *UserNameField;

@property (weak, nonatomic) IBOutlet UITextField *PwdField;

@property (weak, nonatomic) IBOutlet UITextField *Datefield;

@property (weak, nonatomic) IBOutlet UITextField *SexField;

@property (nonatomic, strong)UIPickerView *picker;

@property (nonatomic, strong)NSMutableArray *SexArray;

@end

@implementation DAGEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
       UIDatePicker *picker = [[UIDatePicker alloc] init];
       picker.datePickerMode = UIDatePickerModeDate;
       picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
       // 设置键盘的inputView
       self.Datefield.inputView = picker;

       UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
       button.frame = CGRectMake(kScreenWidth - 50, 0, 50, 30);
       [button setTitle:@"确定" forState:UIControlStateNormal];
       
       self.Datefield.inputAccessoryView = button;
       
       [self chooseDate:picker];
       [picker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
       
       UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(rightAction)];
       self.navigationItem.rightBarButtonItem = right;
       
       self.picker = [[UIPickerView alloc] init];
       self.picker.dataSource = self;
       self.picker.delegate = self;
       
       self.SexField.inputView = self.picker;
       
       [self loadData];
       
    // Do any additional setup after loading the view.
}


- (void)chooseDate:(UIDatePicker *)sender {
       NSDate *selectedDate = sender.date;
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       formatter.dateFormat = @"yyyy年MM月dd日";
       NSString *dateString = [formatter stringFromDate:selectedDate];
       self.Datefield.text = dateString;
}



- (void)rightAction {
       [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)loadData {
       
       self.SexArray = [NSMutableArray array];
       
       self.SexArray = @[@"男", @"女", @"保密"].mutableCopy;
       
}

#pragma mark - UIPickerView 的数据源方法

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
       return self.SexArray.count;
       
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
       return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
       return self.SexArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
       self.SexField.text = self.SexArray[row];
}

#pragma mark - 键盘的回收和 第一响应者的注销
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
       [textField resignFirstResponder];
       return YES;
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
