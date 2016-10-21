//
//  XMGChatCell.h
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGChatFrame, XMGChatCell;

@protocol XMGChatCellDelegate <NSObject>

@optional
- (void)xmg_chatCell:(XMGChatCell *)cell contentClickWithChatFrame:(XMGChatFrame *)chatFrame;

@end


@interface XMGChatCell : UITableViewCell

/** 注释 */
@property (nonatomic, strong) XMGChatFrame *chatFrame;

/** daili */
@property (nonatomic, weak) id<XMGChatCellDelegate> delegate;

@end
