//
//  webViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/12.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Animation3D" ofType:@"html"];
    
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        
    
    NSLog(@"---%@ -- ",string);
    
   // [self.webView loadHTMLString:string baseURL:nil];
        [self.webView loadHTMLString:string baseURL:url];
        
    });
    // Do any additional setup after loading the view from its nib.
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
