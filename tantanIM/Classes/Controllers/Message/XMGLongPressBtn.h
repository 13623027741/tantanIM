
#import <UIKit/UIKit.h>

@class XMGLongPressBtn;
typedef void(^XMGLongPressBlock)(XMGLongPressBtn *btn);
@interface XMGLongPressBtn : UIButton

/** 长按block */
@property (nonatomic, copy) XMGLongPressBlock longPressBlock;

@end
