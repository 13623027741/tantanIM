//
//  KDRegisterViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/18.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDRegisterViewController.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "EMSDK.h"
#import "AppDelegate.h"

@interface KDRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameText;

@property (weak, nonatomic) IBOutlet UITextField *passWordText;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation KDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
    
    self.registerBtn.layer.cornerRadius = 5;
    
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"正在注册");
        
        [SVProgressHUD showWithStatus:@"正在注册中,请稍后..."];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            EMError* error = [[EMClient sharedClient] registerWithUsername:self.userNameText.text password:self.passWordText.text];
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        AppDelegate* app = [UIApplication sharedApplication].delegate;
                        [app resetRootViewController];
                    }]];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }else{
                
                NSLog(@"注册失败---%@",error.errorDescription);
                [SVProgressHUD showErrorWithStatus:@"注册失败..."];
                
            }
        });
        
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
