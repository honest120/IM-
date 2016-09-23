//
//  AppDelegate.m
//  textIM
//
//  Created by tens04 on 16/9/22.
//  Copyright © 2016年 zjx. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import "ViewController.h"
#import "ChatListViewController.h"

#define APPKEY1 @"0vnjpoadn0ztz"
#define APPKEY2 @"x18ywvqf8xefc"

#define TOKEN1 @"H7EyDj+oNXq20yhi1FrvPu3RjvyrJxke5UWo2QL6xHD0yYOH2Z+XNCRENhemKCiVOEJoyPQ8sCoy6bP3SIpX4g=="
#define TOKEN2 @"xTHwauZa7Sm+fgCpZx/qIlWPcAwsqrExulvnW3QKVmMqQlhQ/QsMs056Y2NYoUcUIvdYP4OWwRMt7FtB5WUZlQ=="

@interface AppDelegate ()
<RCIMUserInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [[RCIM sharedRCIM] initWithAppKey:APPKEY2];
    
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
  
    NSString *token= TOKEN2;
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);

        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token无效");
    }];

    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    
    // 初始化 UINavigationController
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    // 初始化 rootViewController
    self.window.rootViewController = nav;

    // 全局设置导航栏
    // 背景色
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:88/255.0 green:154/255.0 blue:214/255.0 alpha:1];
    

    // 字体色
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    return YES;

}
 //协议方法
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    
    if ([userId isEqualToString:@"fuxinto"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc] init];
        userInfo.userId = userId;
        userInfo.name = @"黄福鑫";
        userInfo.portraitUri = @"http://chuantu.biz/t5/34/1474337388x3063167327.jpg";
        return completion(userInfo);
    } else if([userId isEqualToString:@"text1"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc] init];
        userInfo.userId = userId;
        userInfo.name = @"123";
        userInfo.portraitUri = @"http://chuantu.biz/t5/34/1474337388x3063167327.jpg";
        return completion(userInfo);
    }
    return completion(nil);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
