//
//  KDMessageViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/18.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDMessageViewController.h"
#import "KDMessageCell.h"
#import "EMSDK.h"
#import "KDMessageModel.h"
#import "Masonry.h"
#import "XMGChatController.h"

@interface KDMessageViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
EMChatManagerDelegate,
EMContactManagerDelegate,
UIAlertViewDelegate
>

@property(nonatomic,strong)UITableView* tableView;
/**
 *  会话
 */
@property(nonatomic,strong)NSMutableArray* sessions;

@property(nonatomic,strong)NSString* aUsername;

@property(nonatomic,strong)NSString* aMessage;
/**
 *  接收到消息的conversationId ,用来监听是否有新消息到达
 */
@property(nonatomic,strong)NSMutableSet* conversationIds;

@end

static NSString* cellID = @"messageCell";
@implementation KDMessageViewController

-(NSMutableSet *)conversationIds{
    if (!_conversationIds) {
        _conversationIds = [NSMutableSet set];
    }
    return _conversationIds;
}

-(NSMutableArray *)sessions{
    if (!_sessions) {
        _sessions = [NSMutableArray arrayWithArray:[[EMClient sharedClient].chatManager getAllConversations]];
        
    }
    return _sessions;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[EMClient sharedClient].contactManager removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"KDMessageCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.tableView];
    
    self.aUsername = @"";
    self.aMessage = @"";
    
    
}

-(void)viewDidLayoutSubviews{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@64);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sessions.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"KDMessageCell" owner:nil options:nil]lastObject];
    }
    
    EMConversation* conversation = self.sessions[indexPath.row];
    
    cell.imgView.image = [UIImage imageNamed:@"image_3"];
    
    cell.title.text = conversation.conversationId;
    
    EMMessage* message = conversation.latestMessage;
    EMMessageBody* body = message.body;
    
    cell.message.textColor = [UIColor colorWithRed:202.0/255 green:202.0/255 blue:202.0/255 alpha:1];
    cell.title.textColor = [UIColor blackColor];
    
    for (NSString* conversationId in self.conversationIds) {
        for (EMConversation* conversation in self.sessions) {
            if (conversation.conversationId == conversationId) {
                cell.message.textColor = [UIColor redColor];
                cell.title.textColor = [UIColor redColor];
                [self.conversationIds removeObject:conversationId];
            }
        }
    }
    
    if (body.type == EMMessageBodyTypeText) {
        EMTextMessageBody* textBody = (EMTextMessageBody*)message.body;
        cell.message.text = textBody.text;
        
    }else if (body.type == EMMessageBodyTypeImage){
        cell.message.text = @"图片";
    }else if (body.type == EMMessageBodyTypeVideo){
        cell.message.text = @"影片";
    }else if (body.type == EMMessageBodyTypeLocation){
        cell.message.text = @"位置";
    }else if (body.type == EMMessageBodyTypeVoice){
        cell.message.text = @"语音";
    }else if(body.type == EMMessageBodyTypeFile){
        cell.message.text = @"文件";
    }
    
    cell.time.text = [self getTime:message.localTime];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    EMConversation* conversation = self.sessions[indexPath.row];
    XMGChatController* chatVC = [XMGChatController xmg_chatVcWithChatter:conversation.conversationId chatType:EMConversationTypeChat];
    
    EMError* err;
    [conversation markAllMessagesAsRead:&err];
    
    if (err) {
        NSLog(@"设置成全部已读错误，错误信息---%@",err.errorDescription);
    }
    
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark - 添加好友申请回调


- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"添加好友-%@",aUsername] message:[NSString stringWithFormat:@"添加好友理由: %@",aMessage] delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意", nil];
    self.aUsername = aUsername;
    self.aMessage = aMessage;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"不同意");
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.aUsername];
        if (!error) {
            NSLog(@"发送拒绝成功");
        }
    }else if (buttonIndex == 1){
        NSLog(@"同意");
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.aUsername];
        if (!error) {
            NSLog(@"发送同意成功");
            
            
            EMConversation* con = [[EMClient sharedClient].chatManager getConversation:self.aUsername type:EMConversationTypeChat createIfNotExist:YES];
            
            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:self.aMessage];
            NSString *from = [[EMClient sharedClient] currentUsername];
            
            //生成Message
            EMMessage *message = [[EMMessage alloc] initWithConversationID:from from:from to:con.conversationId body:body ext:nil];
            message.chatType = EMChatTypeChat;
            
            [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
                NSLog(@"error -> %@",error.errorDescription);
            }];
            
            
        }
    }
}

#pragma mark - 聊天回调

- (void)didReceiveMessages:(NSArray *)aMessages{
    
//
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:body.text message:message.conversationId delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    
//    [alertView show];
    
//    NSLog(@"时间戳为--%lld--",message.timestamp);
    
    NSLog(@"接收到消息");
    
    for (EMMessage* message in aMessages) {
        EMTextMessageBody* body = (EMTextMessageBody*)message.body;
        NSLog(@"--消息[%@]---id[%@]--",body.text,message.conversationId);
        
        [self.conversationIds addObject:message.conversationId];
    }
    
    [self.tableView reloadData];
}


/*!
 @method
 @brief 接收到一条及以上已送达回执
 */
- (void)didReceiveHasDeliveredAcks:(NSArray *)aMessages{
    NSLog(@"消息已送达");
}


/*!
 *  接收到一条及以上已读回执
 *
 *  @param aMessages  消息列表<EMMessage>
 */
- (void)didReceiveHasReadAcks:(NSArray *)aMessages{
    NSLog(@"接收到一条及以上已读回执");
    
}


#pragma mark - 转化时间

-(NSString*)getTime:(NSInteger)timeval{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeval];
    
    return [formatter stringFromDate:confromTimesp];
    
}

@end
