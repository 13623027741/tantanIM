//
//  KDDataTool.h
//  tantanIM
//
//  Created by kaidan on 16/10/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

 // chat_登录的用户名_聊天对象名 表名

#import <Foundation/Foundation.h>

@interface KDDataTool : NSObject

/**
 *  创建数据表
 */
+(BOOL)createTable;
/**
 *  插入数据
 */
+(BOOL)insertData:(id)data;
/**
 *  读取数据
 */
+(NSArray*)selectData;
/**
 *  判断是否创建数据库
 */
+(BOOL)isDB;




@end
