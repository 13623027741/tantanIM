//
//  XMGChatController.h
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"

@interface XMGChatController : UIViewController

+ (instancetype)xmg_chatVcWithChatter:(NSString *)chatter chatType: (EMConversationType)chatType;

/** 聊天对象/聊天groupID */
@property (nonatomic, strong) NSString *chatter;
/** 聊天的类型 */
@property (nonatomic, assign) EMConversationType chatType;

@end
