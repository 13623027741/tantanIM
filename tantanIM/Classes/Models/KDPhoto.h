//
//  KDPhoto.h
//  tantanIM
//
//  Created by kaidan on 16/10/20.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDPhoto : NSObject

/**
 *  图片地址
 */
@property(nonatomic,copy)NSString* url;
/**
 *  用户名
 */
@property(nonatomic,copy)NSString* title;
/**
 *  用户ID
 */
@property(nonatomic,copy)NSString* userID;


+(instancetype)PhotoWithUrl:(NSString*)url title:(NSString*)title userID:(NSString*)userID;

@end
