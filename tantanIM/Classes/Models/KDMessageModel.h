//
//  KDMessageModel.h
//  tantanIM
//
//  Created by kaidan on 16/10/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDMessageModel : NSObject

/**
 *  图片名
 */
@property(nonatomic,copy)NSString* imageName;
/**
 *  发送者
 */
@property(nonatomic,copy)NSString* name;
/**
 *  最新消息时间
 */
@property(nonatomic,copy)NSString* time;
/**
 *  最新消息
 */
@property(nonatomic,copy)NSString* message;

@end
