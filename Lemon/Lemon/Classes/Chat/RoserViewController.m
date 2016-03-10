//
//  RoserViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "RoserViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "Dem_RongData.h"
#import "Dem_TestChatListViewController.h"
#import "DHSlideMenuController.h"
#import "Dem_UserData.h"
#import "LoginViewController.h"
#import "UserViewController.h"
#import "Dem_LeanCloudData.h"
#import "Dem_SearchViewController.h"
#import "Dem_ChatViewController.h"
#import <AVOSCloudIM/AVOSCloudIM.h>
@interface RoserViewController ()<UITableViewDataSource,UITableViewDelegate,AVIMClientDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)AVObject *inter;
@property (nonatomic, strong) AVIMClient *client;

@end

@implementation RoserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NSNotificationAction) name:@"reload" object:@"refresh"];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"list_cell"];
    self.table.delegate = self;
    self.table.dataSource = self;
    [RCIM sharedRCIM].globalConversationAvatarStyle =RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self loadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    });
    
    // Do any additional setup after loading the view.
}

-(void)NSNotificationAction{
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 40, 40);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(150, 60, 100, 30);
    [button setTitle:@"会话列表" forState:UIControlStateNormal];
    self.navigationItem.titleView = button;
    [button addTarget:self action:@selector(TextChatAction) forControlEvents:UIControlEventTouchUpInside];
    [self ReceiveMessageWithUser:[Dem_UserData shareInstance].user.username];
    if ([Dem_UserData shareInstance].user ==nil) {
        button.hidden = YES;
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(loginAction)];
        self.navigationItem.leftBarButtonItem = left;
        self.navigationItem.rightBarButtonItem = nil;
    }
    else{
        
        button.hidden = NO;
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightAction)];
        self.navigationItem.rightBarButtonItem = right;
        DHSlideMenuController *mainVC = [DHSlideMenuController sharedInstance];
        UserViewController *uvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"uvc"];
        mainVC.leftViewController = uvc;
        [btn setImage:[Dem_UserData shareInstance].model.photo forState:UIControlStateNormal];
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = left;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 20;
        [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    if ([Dem_UserData shareInstance].reLoad == YES) {
        [self.data removeAllObjects];
        [self.table reloadData];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self loadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
                [Dem_UserData shareInstance].reLoad = NO;
            });
        });
    }
    
}

#pragma mark好友接收通知
-(void)ReceiveMessageWithUser:(NSString *)user {
    self.client = [[AVIMClient alloc] init];
    
    // Jerry 创建了一个 client，用自己的名字作为 clientId
    self.client = [[AVIMClient alloc] initWithClientId:user];
    
    // 设置 client 的 delegate，并实现 delegate 方法
    self.client.delegate = self;
    
    // Jerry 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // ...
        NSLog(@"suce = %d ,error = %@",succeeded,error);
    }];
}

#pragma mark - AVIMClientDelegate

// 接收消息的回调函数
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    NSLog(@"%@", message.text); // 耗子，起床！
}






#pragma mark添加好友
-(void)rightAction{
    Dem_SearchViewController *svc = [[Dem_SearchViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
    [Dem_UserData shareInstance].reLoad = YES;
}
#pragma mark登陆
-(void)loginAction{
    LoginViewController *lvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"lvc"];
    [self presentViewController:lvc animated:YES completion:^{
        [Dem_UserData shareInstance].reLoad = YES;
    }];
}
#pragma mark加载数据
-(void)loadData{
    //创建demo数据
    [self.data removeAllObjects];
    if ([Dem_UserData shareInstance].user == nil) {
        return;
    }
    [Dem_LeanCloudData groupWithUser:[Dem_UserData shareInstance].user block:^(AVObject *group) {
        _data = [[NSMutableArray alloc]initWithCapacity : 2];
        
        NSArray *array = [group objectForKey:@"groupName"];
        for (int i = 0; i < array.count; i++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
            [dict setObject:array[i] forKey:@"groupname"];
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
            NSArray * group = [Dem_LeanCloudData groupByUser:[Dem_UserData shareInstance].user group:array[i]];
            
            if (group.count !=0) {
                for (int i = 0; i < group.count; i++) {
                    AVObject *buddy = group[i];
                    AVUser *friend = [buddy objectForKey:@"friend"];
                    [Dem_LeanCloudData intermationWithUser:friend block:^(AVObject *users) {
                        self.inter = [[AVObject alloc]init];
                        self.inter = users;
                    }];
                    
                    [arr addObject:self.inter];
                }
            }
            [dict setObject:arr forKey:@"users"];
            [_data addObject:dict];
        }
        
    }];
    
}

//返回指定节的“expanded”值
-(Boolean)isExpanded:(int)section{
    Boolean expanded = NO;
    NSMutableDictionary* d=[_data objectAtIndex:section];
    //若本节model中的“expanded”属性不为空，则取出来
    if([d objectForKey:@"expanded"]!=nil)
        expanded=[[d objectForKey:@"expanded"]intValue];
    return expanded;
}

//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
    UIButton* btn= (UIButton*)sender;
    long section= btn.tag; //取得tag知道点击对应哪个块
    [self collapseOrExpand:(int)section];
    [self.table reloadData];
    
}

//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(int)section{
    Boolean expanded = NO;
    //    Boolean searched = NO;
    NSMutableDictionary* d=[_data objectAtIndex:section];
    
    //若本节model中的“expanded”属性不为空，则取出来
    if([d objectForKey:@"expanded"]!=nil)
        expanded=[[d objectForKey:@"expanded"]intValue];
    
    //若原来是折叠的则展开，若原来是展开的则折叠
    [d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //对指定节进行“展开”判断
    if (![self isExpanded:(int)section]) {
        
        //若本节是“折叠”的，其行数返回为0
        return 0;
    }
    NSDictionary* d=[_data objectAtIndex:section];
    return [[d objectForKey:@"users"] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"list_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary* m= (NSDictionary*)[_data objectAtIndex: indexPath.section];
    NSArray *d = (NSArray*)[m objectForKey:@"users"];
    if (d == nil) {
        return cell;
    }
    //显示联系人名称
    AVObject *fri = d[indexPath.row];
    cell.textLabel.text =[fri objectForKey:@"nid"];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor colorWithRed:0.991 green:0.205 blue:0.000 alpha:0];
    AVFile *file = [fri objectForKey:@"photo"];
    NSData *data = [file getData];
    cell.imageView.image = [UIImage imageWithData:data];
    //    cell.imageView.image = [UIImage imageNamed:@"mod_user.png"];
    //选中行时灰色
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_data count];
}

// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hView;
    if (UIInterfaceOrientationLandscapeRight == [[UIDevice currentDevice] orientation] ||
        UIInterfaceOrientationLandscapeLeft == [[UIDevice currentDevice] orientation]){
        hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 40)];
    }
    else{
        hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        self.table.tableHeaderView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, 44.f);
    }
    UIButton* eButton = [[UIButton alloc] init];
    //按钮填充整个视图
    eButton.frame = hView.frame;
    [eButton addTarget:self action:@selector(expandButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    eButton.tag = section;//把节号保存到按钮tag，以便传递到expandButtonClicked方法
    //根据是否展开，切换按钮显示图片
    if ([self isExpanded:(int)section])
        [eButton setImage: [ UIImage imageNamed: @"btn_down.png" ] forState:UIControlStateNormal];
    else
        [eButton setImage: [ UIImage imageNamed: @"btn_right.png" ] forState:UIControlStateNormal];
    //由于按钮的标题，
    //4个参数是上边界，左边界，下边界，右边界。
    eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [eButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 0)];
    [eButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    //设置按钮显示颜色
    eButton.backgroundColor = [UIColor colorWithWhite:0.658 alpha:0];
    [eButton setTitle:[[_data objectAtIndex:section] objectForKey:@"groupname"] forState:UIControlStateNormal];
    [eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eButton setTitleShadowColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
    [eButton.titleLabel setShadowOffset:CGSizeMake(1, 1)];
    [hView addSubview: eButton];
    return hView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* m= (NSDictionary*)[_data objectAtIndex: indexPath.section];
    NSArray *d = (NSArray*)[m objectForKey:@"users"];
    if (d == nil) {
        return;
    }
    AVObject *fri = d[indexPath.row];
    //新建一个聊天会话View Controller对象
    Dem_ChatViewController *chat = [[Dem_ChatViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = [fri objectForKey:@"nid"];
    //设置聊天会话界面要显示的标题
    chat.title = [NSString stringWithFormat:@"与%@聊天",[fri objectForKey:@"nid"]];
    //显示聊天会话界面
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:chat];
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
}

-(void)leftAction{
    [[DHSlideMenuController sharedInstance]showLeftViewController:YES];
}

-(void)TextChatAction{
    Dem_TestChatListViewController *chatList = [[Dem_TestChatListViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:chatList];
    [self presentViewController:nvc animated:YES completion:^{
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
