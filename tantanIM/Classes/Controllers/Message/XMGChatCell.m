//
//  XMGChatCell.m
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGChatCell.h"

#import "XMGLongPressBtn.h"
#import "XMGChat.h"
#import "XMGChatFrame.h"
#import "UIImage+YFResizing.h"
#import "UIButton+WebCache.h"


#import "EMSDKFull.h"

#define BackGround243Color [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]


@interface XMGChatCell ()

/** timeLab */
@property (nonatomic, weak) UILabel *timeLab;

/** durationLab */
@property (nonatomic, weak) UILabel *durationLab;

/** 头像 */
@property (nonatomic, weak) XMGLongPressBtn *userIconBtn;

/** 聊天内容 */
@property (nonatomic, weak) XMGLongPressBtn *contentBtn;

@end

@implementation XMGChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = BackGround243Color;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 此处添加子控件
        UILabel *timeLab = [[UILabel alloc] init];
        timeLab.backgroundColor = [UIColor grayColor];
        timeLab.textColor = [UIColor whiteColor];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.font = kTimeFont;
        timeLab.layer.cornerRadius = 5;
        timeLab.clipsToBounds = YES;
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;
        
        XMGLongPressBtn *userIconBtn = [[XMGLongPressBtn alloc] init];
        userIconBtn.longPressBlock = ^(XMGLongPressBtn *btn){
          // 长按时的业务逻辑处理
        };
        [userIconBtn addTarget:self action:@selector(xmg_showDetailUserInfo) forControlEvents: UIControlEventTouchUpInside];
        [self.contentView addSubview: userIconBtn];
        self.userIconBtn = userIconBtn;
        
        XMGLongPressBtn *contentTextBtn = [[XMGLongPressBtn alloc] init];
        contentTextBtn.longPressBlock = ^(XMGLongPressBtn *btn){
            // 长按时的业务逻辑处理
        };
        
        
        
        contentTextBtn.titleLabel.font = kContentTextFont;
        contentTextBtn.titleLabel.numberOfLines = 0;
        
        [contentTextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [contentTextBtn addTarget:self action:@selector(xmg_contentChatTouchUpInside) forControlEvents: UIControlEventTouchUpInside];
        [self.contentView addSubview: contentTextBtn];
        self.contentBtn = contentTextBtn;
        
        // 此处添加子控件
        UILabel *durationLab = [[UILabel alloc] init];
        //timeLab.backgroundColor = [UIColor grayColor];
        durationLab.textColor = [UIColor lightGrayColor];
        durationLab.textAlignment = NSTextAlignmentCenter;
        durationLab.font = [UIFont systemFontOfSize:14.0];
        durationLab.hidden = YES;
        [self.contentView addSubview: durationLab];
        self.durationLab = durationLab;
    }
    
    return self;
}

// 这里面给子控件赋值
- (void)setChatFrame:(XMGChatFrame *)chatFrame
{
    _chatFrame = chatFrame;
    
    XMGChat *chat = chatFrame.chat;
    self.timeLab.text = chat.timeStr;
    
    // 如果是真实开发,此处应该用SDWebImage根据URL取图片
    [self.userIconBtn setImage:[UIImage imageNamed: chat.userIcon] forState: UIControlStateNormal];
    [self.contentBtn setBackgroundImage: [UIImage yf_resizingWithIma:chat.contectTextBackgroundIma] forState: UIControlStateNormal];
    [self.contentBtn setBackgroundImage: [UIImage yf_resizingWithIma:chat.contectTextBackgroundHLIma] forState: UIControlStateHighlighted];
    
    self.durationLab.hidden = (chat.chatType != XMGChatTypeVoice);
    switch (chat.chatType) {
        case XMGChatTypeText:
        {
            self.contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentEdgeTop, kContentEdgeLeft, kContentEdgeBottom, kContentEdgeRight);
            [self.contentBtn setTitle: chat.contentText forState: UIControlStateNormal];
            [self.contentBtn setImage: nil forState:UIControlStateNormal];
        }
            break;
        case XMGChatTypeImage:
        {
            self.contentBtn.contentEdgeInsets = UIEdgeInsetsZero;
            [self.contentBtn setTitle: @"" forState: UIControlStateNormal];
            if (chat.contentThumbnailIma) {
                [self.contentBtn setImage:chat.contentThumbnailIma forState:UIControlStateNormal];
            }else
            {
                // 用SDWebImage进行btn的赋值
                [self.contentBtn sd_setImageWithURL:chat.contentThumbnailImaUrl forState:UIControlStateNormal];
            }
        }
            break;
            
            
        case XMGChatTypeVoice:
        {
            [self.contentBtn setImage: [UIImage imageNamed: @"SenderVoiceNodePlaying"] forState:UIControlStateNormal];
            
            self.durationLab.text = (chat.isMe) ? [NSString stringWithFormat:@"\" %zd", chat.voiceDuration]: [NSString stringWithFormat:@"%zd \"", chat.voiceDuration];
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}

// 这里面对子控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.timeLab.frame = self.chatFrame.timeFrame;
    
    self.userIconBtn.frame = self.chatFrame.iconFrame;
    self.contentBtn.frame = self.chatFrame.contentFrame;
    self.durationLab.frame = self.chatFrame.durationFrame;
    if (self.chatFrame.chat.chatType == XMGChatTypeVoice) {
        
    }
}

#pragma mark - 私有方法
- (void)xmg_showDetailUserInfo
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
}

- (void)xmg_contentChatTouchUpInside
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    switch (self.chatFrame.chat.chatType) {
        case XMGChatTypeText:
        {
            
        }
            break;
        case XMGChatTypeImage:
        {
            if ([self.delegate respondsToSelector:@selector(xmg_chatCell:contentClickWithChatFrame:)]) {
                [self.delegate xmg_chatCell:self contentClickWithChatFrame:self.chatFrame];
            }
        }
            break;
        case XMGChatTypeVoice:
        {
//            if ([[EMCDDeviceManager sharedInstance] isPlaying]) {
//                [[EMCDDeviceManager sharedInstance] stopPlaying];
//            }else
//            {
//                
//                [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath: self.chatFrame.chat.voicePath completion:^(NSError *error) {
//                    if (!error) {
//                        NSLog(@"播放.........");
//                    }
//                }];
//            }
        }
            break;
            
        default:
            break;
    }
}

@end
