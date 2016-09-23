//
//  ViewController.m
//  textIM
//
//  Created by tens04 on 16/9/22.
//  Copyright © 2016年 zjx. All rights reserved.
//

#import "ViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMKit/RCConversationViewController.h>
#import "ChatListViewController.h"
#import "registerUserViewController.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *logIn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerUesr:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3"] forBarMetrics:UIBarMetricsDefault];
    
    
//     [_logIn addTarget:self action:@selector(loginRongCloud) forControlEvents:UIControlEventTouchUpInside];
    //    [rightButton setTintColor:[UIColor whiteColor]];

   /* 注册登录

    [[RCIM sharedRCIM] connectWithToken:@"YourTestUserToken" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%d", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];  */
}

-(void)registerUesr:(id)sender {
    
    registerUserViewController *rUVC = [self.storyboard instantiateViewControllerWithIdentifier:@"registerUser"];
                                        
    [self presentViewController:rUVC animated:YES completion:nil];
    
}

-(void)loginRongCloud{
    
    
}

- (IBAction)logIn:(UIButton *)sender {
    
    ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
    
    [self.navigationController pushViewController:chatListViewController animated:YES];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
