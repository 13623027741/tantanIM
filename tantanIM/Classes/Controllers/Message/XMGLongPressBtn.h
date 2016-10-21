//
//  XMGLongPressBtn.h
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGLongPressBtn;
typedef void(^XMGLongPressBlock)(XMGLongPressBtn *btn);
@interface XMGLongPressBtn : UIButton

/** 长按block */
@property (nonatomic, copy) XMGLongPressBlock longPressBlock;

@end
