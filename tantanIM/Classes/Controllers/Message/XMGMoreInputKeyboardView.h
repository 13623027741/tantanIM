//
//  XMGMoreInputKeyboardView.h
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kXMGMoreInputKeyboardViewH 200
#define XMGPhotoInputStr @"照片"
#define XMGVoiceVideoInputStr @"视频聊天"



typedef void(^XMGMoreInputBtnClick)(UIButton *btn);

@interface XMGMoreInputKeyboardView : UIView

/** 按钮点击执行的block */
@property (nonatomic, copy) XMGMoreInputBtnClick btnClickBlock;

@end
