//
//  UIImage+KDimage.h
//  tantanIM
//
//  Created by kaidan on 16/10/19.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KDimage)

/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(UIImage*)image;

@end
