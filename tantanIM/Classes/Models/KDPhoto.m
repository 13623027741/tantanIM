//
//  KDPhoto.m
//  tantanIM
//
//  Created by kaidan on 16/10/20.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDPhoto.h"

@implementation KDPhoto

+(instancetype)PhotoWithUrl:(NSString*)url title:(NSString*)title userID:(NSString*)userID{
    KDPhoto* photo = [[KDPhoto alloc] init];
    
    photo.url = url;
    photo.title = title;
    photo.userID = userID;
    
    return photo;
}

@end
