//
//  KDLogViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/18.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDLogViewController.h"
#import "SVProgressHUD.h"
#import "ReactiveCocoa.h"
#import "EMSDK.h"
#import "AppDelegate.h"

@interface KDLogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameText;

@property (weak, nonatomic) IBOutlet UITextField *passWrodText;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation KDLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
    
    self.loginBtn.layer.cornerRadius = 5;
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        
    }];
    
    //登录
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [SVProgressHUD showWithStatus:@"正在登录"];
         
         
         [[EMClient sharedClient] loginWithUsername:self.userNameText.text password:self.passWrodText.text completion:^(NSString *aUsername, EMError *aError) {
             
             if (!aError) {
                 [SVProgressHUD dismiss];
                 NSLog(@"登录成功");
                 AppDelegate* app = [UIApplication sharedApplication].delegate;
                 [app resetRootViewController];
                 
                 [[EMClient sharedClient].options setIsAutoLogin:YES];
                 
             }else{
                 
                 NSLog(@"登录失败 -> %@",aError.errorDescription);
                 [SVProgressHUD showErrorWithStatus:@"登录失败,请重新登录..."];
             }
         }];
     }];
    
}



//返回上一个控制器
-(void)setNavigationItem{
    
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_close"] style:UIBarButtonItemStyleDone target:self action:@selector(backViewController)];
    
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)backViewController{
    NSLog(@"点击返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
