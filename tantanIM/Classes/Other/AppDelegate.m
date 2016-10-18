//
//  AppDelegate.m
//  tantanIM
//
//  Created by kaidan on 16/10/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "AppDelegate.h"
#import "KDGuillotineMenu.h"
#import "KDMainViewController.h"
#import "KDMessageViewController.h"
#import "KDProfileViewController.h"
#import "KDSouSouViewController.h"
#import "KDSettingViewController.h"

@interface AppDelegate ()<KDGuillotineMenuDelegate>

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSArray* controllers = @[[KDProfileViewController new],
                             [KDSouSouViewController new],
                             [KDMessageViewController new],
                             [KDSettingViewController new]
                             ];
    NSArray* titles = @[@"我的",@"搜搜",@"消息",@"设置"];
    
    NSArray* images = @[@"ic_profile",@"ic_profile",@"ic_settings",@"ic_settings"];
    
    KDGuillotineMenu* menuController = [[KDGuillotineMenu alloc]initWithViewControllers:controllers MenuTitles:titles andImagesTitles:images andStyle:KDGuillotineMenuStyleCollection];
    menuController.delegate = self;
    
    KDMainViewController* navigationController = [[KDMainViewController alloc] initWithRootViewController:menuController];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)menuDidOpen{
    NSLog(@"打开");
}
- (void)menuDidClose{
    NSLog(@"关闭");
}
- (void)selectedMenuItemAtIndex:(NSInteger)index{
    NSLog(@"选中那个item -- %ld",index);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
