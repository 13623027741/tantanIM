//
//  XMGChatFrame.h
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTimeFont [UIFont systemFontOfSize:13.0]
#define kContentTextFont [UIFont systemFontOfSize:15.0]

#define kContentEdgeTop 15
#define kContentEdgeLeft 20
#define kContentEdgeBottom 25
#define kContentEdgeRight 20

@class XMGChat;
@interface XMGChatFrame : NSObject

/** 注释 */
@property (nonatomic, strong) XMGChat *chat;

/**>>>>>下面都是布局属性>>>>>>*/
/** timeLab */
@property (nonatomic, assign, readonly) CGRect timeFrame;

/** 头像frame */
@property (nonatomic, assign, readonly) CGRect iconFrame;

/** 内容的frame */
@property (nonatomic, assign, readonly) CGRect contentFrame;\
/** durationTime的frame */
@property (nonatomic, assign, readonly) CGRect durationFrame;

/** cell高度 */
@property (nonatomic, assign, readonly) CGFloat cellH;

@end
