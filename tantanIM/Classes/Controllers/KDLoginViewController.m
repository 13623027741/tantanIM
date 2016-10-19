//
//  KDLoginViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/18.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDLoginViewController.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "KDLogViewController.h"
#import "KDRegisterViewController.h"
#import "KDMainViewController.h"

@interface KDLoginViewController ()

@property(nonatomic,strong)UIImageView* bgImageView;
@property(nonatomic,strong)UIButton* registerBtn;
@property(nonatomic,strong)UIButton* loginBtn;
@end

@implementation KDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginbg"]];
    self.bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
    self.registerBtn = [[UIButton alloc] init];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = [UIColor orangeColor];
    self.registerBtn.layer.cornerRadius = 5;
    self.loginBtn = [[UIButton alloc] init];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [UIColor orangeColor];
    self.loginBtn.layer.cornerRadius = 5;
    [self.bgImageView addSubview:self.registerBtn];
    [self.bgImageView addSubview:self.loginBtn];
    
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"注册");
        KDRegisterViewController* registerVc = [[UIStoryboard storyboardWithName:@"KDRegisterViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"register"];
        
        
        KDMainViewController* mainVC = [[KDMainViewController alloc] initWithRootViewController:registerVc];
        [self presentViewController:mainVC animated:YES completion:nil];
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"登录");
        
        KDRegisterViewController* logVc = [[UIStoryboard storyboardWithName:@"KDLogViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"Login"];
        
        KDMainViewController* mainVC = [[KDMainViewController alloc] initWithRootViewController:logVc];
        [self presentViewController:mainVC animated:YES completion:nil];
    }];
    
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImageView.mas_top).offset(400);
        make.right.mas_equalTo(self.bgImageView.mas_right).offset(-50);
        make.left.mas_equalTo(self.bgImageView.mas_left).offset(50);
        make.height.mas_equalTo(@40);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerBtn.mas_bottom).offset(20);
        make.left.height.right.equalTo(self.registerBtn);
        
    }];
}


-(void)viewWillLayoutSubviews{
    
}



@end
