
/*
 1.tabbar的隐藏显示切换
 
 2.为inputView加分割线
 
 3.title
 
 4. 监听键盘弹出,对相应的布局做修改
 */

/**
 录音使用的第三方是 DeviceUtil,它是独立于环信SdK之外的
 
 */

#define BackGround243Color [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]


#import "XMGChatController.h"
#import "XMGInputView.h"

#import "XMGChat.h"
#import "XMGChatFrame.h"
#import "XMGChatCell.h"

#import "XMGMoreInputKeyboardView.h"


#define kInputViewH 44
#define kMoreInputViewOriFrame CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), kXMGMoreInputKeyboardViewH)

@interface XMGChatController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, EMChatManagerDelegate, XMGInputView, UINavigationControllerDelegate, UIImagePickerControllerDelegate, XMGChatCellDelegate>

/** 注释 */
@property (nonatomic, strong) UITableView *tableView;

/** 注释 */
@property (nonatomic, strong) XMGInputView *inputView;

/** 注释 */
@property (nonatomic, strong) XMGMoreInputKeyboardView *moreInputView;


/** 注释 */
@property (nonatomic, strong) NSMutableArray *chatMsgs;

/** 要展示的图片数组 */
@property (nonatomic, strong) NSMutableArray *chatImas;
@property (nonatomic, strong) NSMutableArray *chatThumbnailImas;

@end

@implementation XMGChatController


-(void)dealloc{
    
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

+ (instancetype)xmg_chatVcWithChatter:(NSString *)chatter chatType:(EMConversationType)chatType
{
    XMGChatController *chatVc = [[self alloc] init];
    chatVc.chatter = chatter;
    chatVc.chatType = chatType;
    return chatVc;
}
#pragma mark - 懒加载

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = BackGround243Color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - kInputViewH);
    }
    return _tableView;
}

- (UIView *)inputView
{
    if (!_inputView) {
        _inputView = [XMGInputView xmg_inputView];
        _inputView.textField.delegate = self;
        _inputView.delegate = self;
        _inputView.frame = CGRectMake(0, self.view.bounds.size.height - kInputViewH, self.view.bounds.size.width, kInputViewH);
    }
    return _inputView;
}

// 下方的key
- (XMGMoreInputKeyboardView *)moreInputView
{
    if (!_moreInputView) {
        _moreInputView = [[XMGMoreInputKeyboardView alloc] init];
        _moreInputView.frame = kMoreInputViewOriFrame;
        [[UIApplication sharedApplication].keyWindow addSubview: _moreInputView];
        [UIApplication sharedApplication].keyWindow.backgroundColor = BackGround243Color;
        __weak typeof(self) weakSelf = self;
        _moreInputView.btnClickBlock = ^(UIButton *btn){
          
            [weakSelf.view endEditing:YES];
            [weakSelf xmg_dissmissMoreInputViewWithAniation:YES];
            
            
            // 如果是比较字符串,拉应该将字符串写成const常量,然后直接取常量
            if ([btn.currentTitle isEqualToString:XMGPhotoInputStr]) {
                //
                // 先直接做图片选择
                UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
                ipc.delegate = weakSelf;
                [weakSelf presentViewController:ipc animated:YES completion:nil];
            }else if ([btn.currentTitle isEqualToString:XMGVoiceVideoInputStr])
            {
                //
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
                [ac addAction: [UIAlertAction actionWithTitle:@"视频聊天" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 弹出视频聊天的请求
                }]];
                [ac addAction: [UIAlertAction actionWithTitle:@"语音聊天" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 弹出语音聊天的请求
                    
                    // 1.建立连接通道
                   
                    
                    // 2.在对应的代理方法中执行相关操作
                }]];
                [ac addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    // 取消
                }]];
                [weakSelf presentViewController:ac animated:YES completion:nil];
            }
        };
    }
    return _moreInputView;
}

- (NSMutableArray *)chatMsgs
{
    if (!_chatMsgs) {
        _chatMsgs = [NSMutableArray array];
    }
    return _chatMsgs;
}
- (NSMutableArray *)chatImas
{
    if (!_chatImas) {
        _chatImas = [NSMutableArray array];
    }
    return _chatImas;
}

- (NSMutableArray *)chatThumbnailImas
{
    if (!_chatThumbnailImas) {
        _chatThumbnailImas = [NSMutableArray array];
    }
    return _chatThumbnailImas;
}

#pragma mark - VCLife
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加子控件
    [self.view addSubview: self.tableView];
    [self.view addSubview: self.inputView];
    
    
    // 获取会话中的聊天记录
    
    NSInteger time = (NSInteger)[[NSDate dateWithTimeIntervalSinceNow:0]timeIntervalSince1970];
    
//    NSLog(@"--conversation-[%@]--time[%ld]---",self.conversation.conversationId,time);
    
    
    [self.conversation loadMessagesWithType:EMMessageBodyTypeText timestamp:time count:10 fromUser:self.conversation.conversationId searchDirection:EMMessageSearchDirectionDown completion:^(NSArray *aMessages, EMError *aError) {
        if (aError) {
            NSLog(@"--错误---%@--",aError);
        }
        for (EMMessage* message in aMessages) {
            [self xmg_reloadChatMsgs:message];
        }
    }];
    
    NSArray* arr = [[EMClient sharedClient].chatManager getAllConversations];
    
    for (EMConversation* conversation in arr) {
        if ([conversation.conversationId isEqualToString:[EMClient sharedClient].currentUsername]) {
            if ([conversation.latestMessage.to isEqualToString:self.conversation.conversationId]) {
                
                [conversation loadMessagesWithType:EMMessageBodyTypeText timestamp:time count:10 fromUser:conversation.conversationId searchDirection:EMMessageSearchDirectionDown completion:^(NSArray *aMessages, EMError *aError) {
                    if (aError) {
                        NSLog(@"--错误---%@--",aError);
                    }
                    for (EMMessage* message in aMessages) {
                        [self xmg_reloadChatMsgs:message];
                    }
                }];
            }
        }
    }
    
    // 监听键盘弹出,对相应的布局做修改
    [self xmg_observerKeyboardFrameChange];
    
    // 注册cell
    [self.tableView registerClass:[XMGChatCell class] forCellReuseIdentifier: NSStringFromClass([self class])];
    
    // 添加代理,监听收到消息
    [[EMClient sharedClient].chatManager addDelegate: self delegateQueue:nil];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    self.title = self.chatter;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [self xmg_dissmissMoreInputViewWithAniation:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self moreInputView];
    
    
    // 解决第一次进入Vc的时候,未滚动到最底部
    [self xmg_scrollToBottom];
}

#pragma mark - 收到消息后刷新
// 收到消息时的回调
- (void)didReceiveMessage:(EMMessage *)message
{
    
}
// 接收到离线非透传消息的回调
- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatMsgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMGChatCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    
    cell.chatFrame = self.chatMsgs[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.chatMsgs[indexPath.row] cellH];
}

#pragma mark - UIScorllViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 在此处发送消息
    EMTextMessageBody *chatText = [[EMTextMessageBody alloc] initWithText: textField.text];
    
    
    // 1.构造消息,发现body对象
    EMMessage *emsg = [[EMMessage alloc] initWithConversationID:[EMClient sharedClient].currentUsername from:[EMClient sharedClient].currentUsername to:self.chatter body:chatText ext:nil];
    
    
    // 异步方法, 发送一条消息
    [[EMClient sharedClient].chatManager asyncSendMessage:emsg progress:nil completion:^(EMMessage *message, EMError *error) {
        // 发送结束时的回调
        if (!error) {
            
            // 刷新界面
            
            EMTextMessageBody* textBody = [[EMTextMessageBody alloc] initWithText:textField.text];
            EMMessage* message = [[EMMessage alloc]initWithConversationID:[EMClient sharedClient].currentUsername from:[EMClient sharedClient].currentUsername to:self.chatter body:textBody ext:nil];
            
            [self xmg_reloadChatMsgs:message];
            
            NSLog(@"发送成功");
            textField.text = nil;
            
            [textField resignFirstResponder];
            
            [self.tableView reloadData];
        }
    }];
    
    // 发送成功之后刷新列表

    
    return YES;
}

#pragma mark - InputViewDelegate
- (void)xmg_inputView:(XMGInputView *)inputView changeInputStyle:(XMGInputStyle)style
{
    switch (style) {
        case XMGInputStyleText:
        {
            
        }
            break;
        case XMGInputStyleVoice:
        {
            [self xmg_dissmissMoreInputViewWithAniation:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)xmg_inputView:(XMGInputView *)inputView moreBtnClickWith:(NSInteger)moreStyle
{
    
    
    if (self.view.frame.origin.y == 0) {
        
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect tempRect = CGRectMake(0, -kXMGMoreInputKeyboardViewH, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
            self.view.frame = tempRect;
            self.moreInputView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - kXMGMoreInputKeyboardViewH, CGRectGetWidth(self.view.bounds), kXMGMoreInputKeyboardViewH);
            //
        } completion:^(BOOL finished) {
            //
        }];
    }else
    {
        [self xmg_dissmissMoreInputViewWithAniation:YES];
        
        [self.inputView.textField becomeFirstResponder];
    }
}

- (void)xmg_inputView:(XMGInputView *)inputView changeVoiceStatus:(XMGVoiceStatus)status
{
    switch (status) {
        case XMGVoiceStatusSpeaking:
        {
            NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
            // 开始录音
            // 1.确定一个文件name(保证它不会重名)
            // 使用当前聊天对象的名字+时间+ 随机数
        }
            break;
        case XMGVoiceStatusSend:
        {
            NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
            // 拿到音频,构造语音信息并发送
        }
            break;
        case XMGVoiceStatusWillCancle:
        {
            NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
            // HUD提示
        }
            break;
        case XMGVoiceStatusCancled:
        {
            NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
            // 取消当前录音
//            [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
//    // 构造图片消息并发送
}



#pragma mark - XMGChatCellDelegate
- (void)xmg_chatCell:(XMGChatCell *)cell contentClickWithChatFrame:(XMGChatFrame *)chatFrame
{
    
}


#pragma mark - 私有方法
- (void)xmg_observerKeyboardFrameChange
{
    [[NSNotificationCenter defaultCenter] addObserverForName: UIKeyboardWillChangeFrameNotification
                                                      object:nil
                                                       queue: [NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      //
                                                      NSLog(@"%s, line = %d,note =%@", __FUNCTION__, __LINE__, note);
                                                      /**
                                                       note.userInfo
                                                       UIKeyboardAnimationCurveUserInfoKey = 7;
                                                       UIKeyboardAnimationDurationUserInfoKey = "0.25";
                                                       UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
                                                       UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
                                                       UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
                                                       UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
                                                       UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
                                                       UIKeyboardIsLocalUserInfoKey = 1;
                                                       self.view 可以根据 end.oriY来进行 布局改变
                                                       */
                                                      CGFloat endY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
                                                      CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
                                                      
                                                      CGFloat tempY = endY - self.view.bounds.size.height;
                                                      CGRect tempF = CGRectMake(0, tempY, self.view.bounds.size.width, self.view.bounds.size.height);
                                                      self.view.frame = tempF;
                                                      [UIView animateWithDuration:duration animations:^{
                                                          [self.view setNeedsLayout];
                                                      }];
                                                      
                                                      
                                                  }];
}

- (void)xmg_reloadChatMsgs:(EMMessage*)message
{
    
    XMGChat* chat = [XMGChat xmg_chatWith:message preTimestamp:message.timestamp];
        
    XMGChatFrame *chatFrame = [[XMGChatFrame alloc] init];
    chatFrame.chat = chat;
        
        [self.chatMsgs addObject:chatFrame];
        
        // 为图片和预览图数组赋值
        if (chat.chatType == XMGChatTypeImage) {
            if (chat.contentIma) {
                [self.chatImas addObject:chat.contentIma];
            }else
            {
                [self.chatImas addObject:chat.contentImaUrl];
            }
            
            [self.chatThumbnailImas addObject: (chat.contentThumbnailIma ? chat.contentThumbnailIma: chat.contentThumbnailImaUrl)];
        }
    
    
    NSLog(@"[self.chatMsgs.lastObject chat] chat = %lld", [self.chatMsgs.lastObject chat].preTimestamp);
    
    
    //[self.chatMsgs addObjectsFromArray: msgs];
    
    // 刷新表格
    [self.tableView reloadData];
    
    // 滚到最下面
    [self xmg_scrollToBottom];
}
- (void)xmg_scrollToBottom
{
    if (!self.chatMsgs.count) return;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow: self.chatMsgs.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath: lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)xmg_dissmissMoreInputViewWithAniation:(BOOL)hasAnima
{
    // 将moreInput恢复到原样
    if (hasAnima) {
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            //
            self.view.frame = self.view.bounds;
            self.moreInputView.frame = kMoreInputViewOriFrame;
        } completion:^(BOOL finished) {
            //
        }];
    }
    self.view.frame = self.view.bounds;
    self.moreInputView.frame = kMoreInputViewOriFrame;
}

#pragma mark - 聊天回调


- (void)didReceiveMessages:(NSArray *)aMessages{
    
    
    for (EMMessage* message in aMessages) {
        
        [self xmg_reloadChatMsgs:message];
        
        EMTextMessageBody* text =  (EMTextMessageBody*)message.body;
        
        NSLog(@"body.text -> %@",text.text);
    }
    
    
}


@end
