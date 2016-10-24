//
//  KDDataModel.h
//  tantanIM
//
//  Created by kaidan on 16/10/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    chatTypeMe = 0,
    chatTypeOther
}chatType;

@interface KDDataModel : NSObject

@property(nonatomic,assign)chatType chattype;

@property(nonatomic,copy)NSString* msg;

@end
