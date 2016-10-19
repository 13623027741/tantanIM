//
//  AppDelegate.h
//  tantanIM
//
//  Created by kaidan on 16/10/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  重新设置根视图控制器
 */
-(void)resetRootViewController;
@end

