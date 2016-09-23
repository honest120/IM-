//
//  ChatListViewController.m
//  textIM
//
//  Created by tens04 on 16/9/22.
//  Copyright © 2016年 zjx. All rights reserved.
//

#import "ChatListViewController.h"
#import "ViewController.h"
#import "CViewController.h"


@interface ChatListViewController ()

@end

@implementation ChatListViewController

- (id)init {
    
    self = [super init];
    if(self) {
        /* 私聊ConversationType_PRIVATE
         群组ConversationType_GROUP
         讨论组ConversationType_DISCUSSION
         */
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
            @(ConversationType_GROUP),
            @(ConversationType_DISCUSSION)]];
        [self setCollectionConversationType:@[@(ConversationType_PRIVATE)]];
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
//    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    
    
    //自定义导航左右按钮
    //自定义导航左右按钮
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemPressed:)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"聊天" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    self.conversationListTableView.tableFooterView = [UIView new];
    
    // cell的背景颜色
    self.cellBackgroundColor = [UIColor yellowColor];

}

/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 
    点击进入聊天页面
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    // 聚合显示
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        
        CViewController *temp = [[CViewController alloc] init];
        NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
        [temp setDisplayConversationTypes:array];
        [temp setCollectionConversationType:nil];
        
        temp.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:temp animated:YES];
        
    } else if (model.conversationType == ConversationType_PRIVATE ){
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
    }
}

//退出登录
- (void)leftBarButtonItemPressed:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];

    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
    
//   // UIAlertView已经弃用
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
//    [alertView show];
    
    
}

// 重写右边导航按钮的事件
-(void)rightBarButtonItemPressed:(id)sender {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"1"; //这里模拟发消息，可以替换成其他登录的用户的UserId
    conversationVC.title = @"对话测试";
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [[RCIM sharedRCIM]disconnect];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma  mark - 即将显示CELL的回调
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // 拿到数据源
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    
    if (model.conversationType == ConversationType_PRIVATE) {
        // 转换类型
        RCConversationCell *ConversationCell = (RCConversationCell *)cell;
        // 昵称颜色
        ConversationCell.conversationTitle.textColor = [UIColor blueColor];
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"会话";
}

@end
