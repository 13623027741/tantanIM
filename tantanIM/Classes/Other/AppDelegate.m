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

#import "EMSDK.h"

#import "KDLoginViewController.h"

#define appKey @"walter-go#mywalter"

@interface AppDelegate ()<KDGuillotineMenuDelegate,EMClientDelegate>

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=8.0) {
        
        UIUserNotificationType type =UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound;
        
        UIUserNotificationSettings * setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
        
    }
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [self resetRootViewController];
    
    return YES;
}

-(void)resetRootViewController{
    
    EMOptions* options = [EMOptions optionsWithAppkey:appKey];
    [[EMClient sharedClient]initializeSDKWithOptions:options];
    
    KDProfileViewController* profileVC = [[UIStoryboard storyboardWithName:@"KDProfileViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"profile"];
    
    KDSouSouViewController* sousouVC = [[UIStoryboard storyboardWithName:@"KDSouSouViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"sousou"];
    
    KDMessageViewController* messageVC = [[UIStoryboard storyboardWithName:@"KDMessageViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"message"];
    
    KDSettingViewController* settingVC = [[UIStoryboard storyboardWithName:@"KDSettingViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"setting"];
    
    
    NSArray* controllers = @[sousouVC,
                             profileVC,
                             messageVC,
                             settingVC
                             ];
    NSArray* titles = @[@"搜搜",@"我的",@"消息",@"设置"];
    
    NSArray* images = @[@"ic_profile",@"ic_profile",@"ic_settings",@"ic_settings"];
    
    KDGuillotineMenu* menuController = [[KDGuillotineMenu alloc]initWithViewControllers:controllers MenuTitles:titles andImagesTitles:images andStyle:KDGuillotineMenuStyleCollection];
    menuController.delegate = self;
    
    KDMainViewController* navigationController = [[KDMainViewController alloc] initWithRootViewController:menuController];
    
    
    KDLoginViewController* loginVC = [KDLoginViewController new];
    
    
    if ([[EMClient sharedClient].options isAutoLogin]) {
        self.window.rootViewController = navigationController;
    }else{
        self.window.rootViewController = loginVC;
    }
    
}


#pragma mark - 自动登录

-(void)didAutoLoginWithError:(EMError *)aError{
    
    [self resetRootViewController];
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
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
