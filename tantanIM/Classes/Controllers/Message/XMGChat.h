//
//  XMGChat.h
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "EMSDK.h"

typedef enum : NSUInteger {
    XMGChatTypeText = EMMessageBodyTypeText,
    XMGChatTypeImage = EMMessageBodyTypeImage,
    XMGChatTypeLocation = EMMessageBodyTypeLocation,
    XMGChatTypeVoice = EMMessageBodyTypeVoice,
    XMGChatTypeVideo = EMMessageBodyTypeVideo,
    XMGChatTypeFile = EMMessageBodyTypeFile,
} XMGChatType;

@interface XMGChat : NSObject

+ (instancetype)xmg_chatWith:(EMMessage *)emsg preTimestamp:(long long)preTimestamp;

/** 友盟聊天消息对象 */
@property (nonatomic, strong) EMMessage *emsg;
/** 上一条聊天记录的时间 */
@property (nonatomic, assign) long long preTimestamp;


/** 文字聊天内容 */
@property (nonatomic, copy, readonly) NSString *contentText;

/**>>>>>图片聊天内容>>>>>>*/
/** 详细大图 */
@property (nonatomic, strong, readonly) UIImage *contentIma;
/** 预览图 */
@property (nonatomic, strong, readonly) UIImage *contentThumbnailIma;
/** 详细大图url */
@property (nonatomic, strong, readonly) NSURL *contentImaUrl;
/** 预览图url */
@property (nonatomic, strong, readonly) NSURL *contentThumbnailImaUrl;
/** 是否横预览,如果是YES就是横显示 */
@property (nonatomic, assign, getter=isVertical, readonly) BOOL vertical;

/*>>>>>>>音频聊天的内容>>>>>>>>>>*/
/** 音频持续的时间 */
@property (nonatomic, assign, readonly) NSInteger voiceDuration;
/** 音频文件的路径 */
@property (nonatomic, copy, readonly) NSString *voicePath;



/** 文字聊天的背景图 */
@property (nonatomic, strong, readonly) UIImage *contectTextBackgroundIma;
@property (nonatomic, strong, readonly) UIImage *contectTextBackgroundHLIma;

/** 头像urlStr */
@property (nonatomic, copy, readonly) NSString *userIcon;

/** timeStr */
@property (nonatomic, copy, readonly) NSString *timeStr;
/** 是否显示时间 */
@property (nonatomic, assign, getter=isShowTime, readonly) BOOL showTime;

/** 是我还是他 */
@property (nonatomic, assign, getter=isMe, readonly) BOOL me;
/** 聊天类型 */
@property (nonatomic, assign, readonly) XMGChatType chatType;

@end
