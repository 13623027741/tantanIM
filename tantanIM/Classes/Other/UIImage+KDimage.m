//
//  UIImage+KDimage.m
//  tantanIM
//
//  Created by kaidan on 16/10/19.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "UIImage+KDimage.h"

@implementation UIImage (KDimage)

- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [self drawInRect:rect];
    
    // 获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)circleImageNamed:(UIImage*)image
{
    return [image circleImage];
}

@end
