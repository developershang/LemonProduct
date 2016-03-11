//
//  DAGEditViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/11.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGEditViewController.h"
#import "Dem_LeanCloudData.h"
#import "Dem_UserData.h"


@interface DAGEditViewController ()<UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

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
    
    self.HeaderImage.userInteractionEnabled = YES;
    //轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.HeaderImage addGestureRecognizer:tap];
       [self loadData];
       
    // Do any additional setup after loading the view.
}

#pragma mark image的点击事件
-(void)tapAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actPhotoLibrary];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actCamera];
    }];
    [alert addAction:cancel];
    [alert addAction:act1];
    [alert addAction:act2];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark调用相册
-(void)actPhotoLibrary{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

#pragma mark调用相机
-(void)actCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.allowsEditing = YES;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"找不到相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark imagePicker代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    self.HeaderImage.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
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
    NSString *oldpass = [Dem_UserData shareInstance].user.password;
    NSLog(@"%@",oldpass);
    [Dem_LeanCloudData editInformationWithUser:[Dem_UserData shareInstance].user nid:self.UserNameField.text oldPassword:oldpass password:self.PwdField.text photo:self.HeaderImage.image sex:self.SexField.text birthday:self.Datefield.text];
}


- (void)loadData {
       
       self.SexArray = [NSMutableArray array];
       
       self.SexArray = @[@"男", @"女", @"保密"].mutableCopy;
    
    [Dem_LeanCloudData intermationWithUser:[Dem_UserData shareInstance].user block:^(AVObject *users) {
        self.UserNameField.text = [users objectForKey:@"nid"];
        AVFile *file = [users objectForKey:@"photo"];
        NSData *data = [file getData];
        self.HeaderImage.image =[UIImage imageWithData:data];
        self.Datefield.text = [users objectForKey:@"birth"];
        self.SexField.text = [users objectForKey:@"sex"];
        if ([self.SexField.text isEqualToString:@""]) {
            self.SexField.text = @"保密";
        }
    }];
       
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
