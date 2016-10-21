

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XMGInputStyleText = 0,
    XMGInputStyleVoice,
} XMGInputStyle;

typedef enum : NSUInteger {
    XMGVoiceStatusSpeaking = 0,
    XMGVoiceStatusSend,
    XMGVoiceStatusWillCancle,
    XMGVoiceStatusCancled,
} XMGVoiceStatus;

@class XMGInputView;
@protocol XMGInputView <NSObject>

@optional
/** 更多按钮的点击 */
- (void)xmg_inputView:(XMGInputView *)inputView moreBtnClickWith:(NSInteger)moreStyle;
/** 输入方式切换 文本/语音 */
- (void)xmg_inputView:(XMGInputView *)inputView changeInputStyle:(XMGInputStyle)style;
/** 语音输入方式的切换 */
- (void)xmg_inputView:(XMGInputView *)inputView changeVoiceStatus:(XMGVoiceStatus)status;


@end

@interface XMGInputView : UIView

+ (instancetype)xmg_inputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

/** 代理 */
@property (nonatomic, weak) id<XMGInputView> delegate;

@end
