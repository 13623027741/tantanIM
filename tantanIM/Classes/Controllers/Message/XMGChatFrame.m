//
//  XMGChatFrame.m
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

/**
 完善分析
 1.修改背景颜色
 
 2.将cell的选中状态和分割线取消
 
 3.整改内容button的边距
 
 */

#import "XMGChatFrame.h"
#import "XMGChat.h"

@interface XMGChatFrame ()

/** timeLab */
@property (nonatomic, assign) CGRect timeFrame;

/** 头像frame */
@property (nonatomic, assign) CGRect iconFrame;

/** 内容的frame */
@property (nonatomic, assign) CGRect contentFrame;
/** durationTime的frame */
@property (nonatomic, assign) CGRect durationFrame;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellH;

@end

@implementation XMGChatFrame

- (void)setChat:(XMGChat *)chat
{
    _chat = chat;
    
    CGFloat screenW = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat margin = 10;
    CGFloat timeX;
    CGFloat timeY = 0;
    CGFloat timeW;
    CGFloat timeH = chat.isShowTime ? 20: 0;
    
    CGSize timeStrSize = [chat.timeStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName: kTimeFont}
                                                    context: nil].size;
    timeW = timeStrSize.width + 5;
    timeX = (screenW - timeW) * 0.5;
    self.timeFrame = CGRectMake(timeX, timeH, timeW, timeH);
    
    CGFloat iconX;
    CGFloat iconY = margin + CGRectGetMaxY(self.timeFrame);
    CGFloat iconW = 44;
    CGFloat iconH = iconW;
    
    
    CGFloat contentX;
    CGFloat contentY = iconY;
    CGFloat contentW;
    CGFloat contentH;

    CGFloat durationX;
    CGFloat durationY = contentY;
    CGFloat durationH = iconH;
    CGFloat durationW = durationH;
    switch (chat.chatType) {
        case XMGChatTypeText:
        {
            CGFloat contentMaxW = screenW - 2 * (margin + iconW + margin);
#warning contentMaxW写成contentW导致的错误
            CGSize contentStrSize = [chat.contentText boundingRectWithSize:CGSizeMake(contentMaxW, CGFLOAT_MAX)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                attributes:@{NSFontAttributeName: kContentTextFont}
                                                                   context:nil].size;
            
            contentW = contentStrSize.width + kContentEdgeLeft + kContentEdgeRight;
            contentH = contentStrSize.height + kContentEdgeTop + kContentEdgeBottom;

        }
            break;
        case XMGChatTypeImage:
        {
            if (chat.isVertical) {
                contentW = 200;
                contentH = 100;
            }else
            {
                contentH = 200;
                contentW = 100;
            }
        }
            break;
        case XMGChatTypeVoice:
        {
            contentH = 44;
            contentW = [self xmg_VoiceLengthWithTime: chat.voiceDuration];
        }
            break;
        case XMGChatTypeLocation:
        {
            
        }
            break;
        case XMGChatTypeVideo:
        {
            
        }
            break;
        case XMGChatTypeFile:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    if (chat.isMe) {
        iconX = screenW - margin - iconW;
        contentX = iconX - margin - contentW;
        durationX = contentX - durationW;
    }else
    {
        iconX = margin;
        contentX = iconX + iconW + margin;
        durationX = contentX + contentW;
    }
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    self.durationFrame = CGRectMake(durationX, durationY, durationW, durationH);
    self.cellH = (contentH > iconH) ? CGRectGetMaxY(self.contentFrame) + margin: CGRectGetMaxY(self.iconFrame) + margin;
    
}

// 瞎糊弄了个长度算法
- (CGFloat)xmg_VoiceLengthWithTime:(NSInteger)time
{
    if (time <= 5) {
        return 64.0;
    }else if (time >= 60)
    {
        return 200.0;
    }else
    {
        return 64.0 +  (time - 5)/55.0 * 136.0;
    }
        
}

@end
