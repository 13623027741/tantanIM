

#import <UIKit/UIKit.h>

#define kXMGMoreInputKeyboardViewH 200
#define XMGPhotoInputStr @"照片"
#define XMGVoiceVideoInputStr @"视频聊天"



typedef void(^XMGMoreInputBtnClick)(UIButton *btn);

@interface XMGMoreInputKeyboardView : UIView

/** 按钮点击执行的block */
@property (nonatomic, copy) XMGMoreInputBtnClick btnClickBlock;

@end
