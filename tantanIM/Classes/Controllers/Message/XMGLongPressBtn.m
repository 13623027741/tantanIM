//
//  XMGLongPressBtn.m
//  01-EaseMobSDK导入
//
//  Created by xiaomage on 16/5/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGLongPressBtn.h"

@implementation XMGLongPressBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPressGr.minimumPressDuration = 0.5;
        [self addGestureRecognizer: longPressGr];
    }
    return self;
}

- (void)longPress:(UILongPressGestureRecognizer *)longPressGr
{
    if (self.longPressBlock) {
        self.longPressBlock(self);
    }
}

@end
