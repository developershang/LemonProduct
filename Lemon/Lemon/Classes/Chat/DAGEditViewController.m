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

@property (nonatomic, strong)UITextField *textField;

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
       
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - 计算键盘的高度
- (CGFloat)keyboardEndFrameHeight:(NSDictionary *)userInfo {
       
       CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
       CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
       return keyboardEndingFrame.size.height;
       
}

#pragma mark - 键盘即将出现的响应事件
-(void)keyboardWillAppear:(NSNotification *)notification

{
       
       CGRect currentFrame = self.view.frame;
       CGFloat change = [self keyboardEndFrameHeight:[notification userInfo]];
       currentFrame.origin.y = currentFrame.origin.y - change ;
       self.view.frame = currentFrame;
       
       
}

#pragma mark - 键盘消失的时候的响应事件

-(void)keyboardWillDisappear:(NSNotification *)notification

{
       CGRect currentFrame = self.view.frame;
       CGFloat change = [self keyboardEndFrameHeight:[notification userInfo]];
       currentFrame.origin.y = currentFrame.origin.y + change ;
       self.view.frame = currentFrame;
}

#pragma mark -将date类型转换成NSString类型
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
       self.textField = textField;
       [textField resignFirstResponder];
       return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
       [self.UserNameField resignFirstResponder];
       [self.PwdField resignFirstResponder];
       [self.Datefield resignFirstResponder];
       [self.SexField resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
       CGRect rect = textField.frame;
       textField.frame = CGRectMake(0, self.view.frame.size.height - 49 + 10, rect.size.width, rect.size.height);
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
