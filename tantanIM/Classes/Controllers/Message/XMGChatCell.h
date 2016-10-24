

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
