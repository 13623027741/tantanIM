//
//  KDMainViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDMainViewController.h"

@interface KDMainViewController ()

@end

@implementation KDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor orangeColor];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
