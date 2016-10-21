//
//  KDUser.h
//  tantanIM
//
//  Created by kaidan on 16/10/19.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDUser : NSObject

/**
 *  用户名
 */
@property(nonatomic,copy)NSString* username;

/**
 *  星座
 */
@property(nonatomic,copy)NSString* constellation;
/**
 *  兴趣
 */
@property(nonatomic,copy)NSString* interest;
/**
 *  标签
 */
@property(nonatomic,copy)NSString* tag;
/**
 *  距离
 */
@property(nonatomic,copy)NSString* range;

@end
