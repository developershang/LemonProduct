//
//  HomeViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "HomeViewController.h"
#import "enjoyViewController.h"
#import "RoserViewController.h"
#import "DAGNewsListViewController.h"
#import "reserveViewController.h"
#import "RootViewController.h"
#import "DAGJokeViewController.h"
#import "Reachability.h"
#import "DAGMyViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark ==== 网络状态
// 程序一开始,登记当前网络状态.
-(void) checkNetWork
{
       NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
       // 程序第一次执行默认不允许 wwan 网络播放视频.
       if (![[ud valueForKey:@"WWANPlayAbility"] isEqualToString:@"YES"] &&  ![[ud valueForKey:@"WWANPlayAbility"] isEqualToString:@"NO"]) {
              [ud setValue:@"NO" forKey:@"WWANPlayAbility"];
              
              NSUserDefaults * nd = [NSUserDefaults standardUserDefaults];
              [nd setValue:@"NO" forKey:@"LoginStatus"];
       }
       
       // 检查网络状态并登记
       Reachability * ability = [Reachability reachabilityForInternetConnection];
       
       if (ability.currentReachabilityStatus == ReachableViaWiFi) {
              NSLog(@"ReachableViaWiFi");
              [ud setValue:@"ReachableViaWiFi" forKey:@"NetWorkStatus"];
              [ud synchronize];
       }else if (ability.currentReachabilityStatus == ReachableViaWWAN){
              NSLog(@"ReachableViaWWAN");
              [ud setValue:@"ReachableViaWWAN" forKey:@"NetWorkStatus"];
              [ud synchronize];
       }else {
              NSLog(@"NotReachable");
              [ud setValue:@"NotReachable" forKey:@"NetWorkStatus"];
              [ud synchronize];
       }
       
       // 网络状态改变之后的通知及事件.
       [ability startNotifier];
       
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetworkStatusChanged:) name:kReachabilityChangedNotification object:ability];
}
// 网络状态改变的处理事件
-(void) NetworkStatusChanged:(NSNotification *) sender {
       Reachability * ability = [sender object];
       NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
       if (ability.currentReachabilityStatus == ReachableViaWiFi) {
              [ud setValue:@"ReachableViaWiFi" forKey:@"NetWorkStatus"];
              [ud synchronize];
              NSLog(@"连接网络成功");
       }else if (ability.currentReachabilityStatus == ReachableViaWWAN){
              [ud setValue:@"ReachableViaWWAN" forKey:@"NetWorkStatus"];
              [ud synchronize];
              
              // 查看当前是否允许 3g网络 播放
              // 这里添加代码
       }else {
              [ud setValue:@"NotReachable" forKey:@"NetWorkStatus"];
              [ud synchronize];
              NSLog(@"现在没有网络");
       }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
       // 注册当前网络状态
       [self checkNetWork];
       
    RootViewController *srvc = [[RootViewController alloc] init];
    enjoyViewController *evc = [[enjoyViewController alloc] initWithRootViewController:srvc];
    evc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"enjoy" image:[UIImage imageNamed:@"duanzi.png"] tag:102];
    
    
    DAGNewsListViewController *dvc = [[DAGNewsListViewController alloc] init];
       UINavigationController *ndvc = [[UINavigationController alloc] initWithRootViewController:dvc];
    ndvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"news" image:[UIImage imageNamed:@"movie.png"] tag:103];

    
    RoserViewController *rvc = [[RoserViewController alloc] init];
    UINavigationController *nrvc = [[UINavigationController alloc]initWithRootViewController:rvc];
    nrvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"chatting" image:[UIImage imageNamed:@"iconfont-comments.png"] tag:104];
    
//    reserveViewController *revc = [[reserveViewController alloc] init];
       
       DAGMyViewController *dmvc = [[DAGMyViewController alloc] init];
       UINavigationController *ndmvc = [[UINavigationController alloc] initWithRootViewController:dmvc];
       ndmvc.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:105];
    
//       DAGJokeViewController *djvc = [[DAGJokeViewController alloc] init];
//       UINavigationController *ndjvc = [[UINavigationController alloc] initWithRootViewController:djvc];
       
       
    self.viewControllers = @[evc,ndvc,nrvc,ndmvc];
//    self.tabBar.frame = CGRectMake(0, self.view.frame.size.height - 30, self.view.frame.size.width, 30);
    
    // Do any additional setup after loading the view.
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
