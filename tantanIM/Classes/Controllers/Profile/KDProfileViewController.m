//
//  KDProfileViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/18.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <AVFoundation/AVCaptureDevice.h>

#import "KDProfileViewController.h"
#import "ReactiveCocoa.h"
#import "UIImage+KDimage.h"
#import "KDProjectCell.h"
#import "KDUser.h"

@interface KDProfileViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (strong, nonatomic)UITableView *tableView;

@property(nonatomic,strong)UIImagePickerController* pickerVc;

@end

@implementation KDProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iconBtn.layer.cornerRadius = 50;
    
    self.pickerVc = [[UIImagePickerController alloc] init];
    
    // 设置照片可编辑
    [self.pickerVc setAllowsEditing:YES];
    self.pickerVc.delegate = self;
    
    // 设置sourceType
    [self.pickerVc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [[self.iconBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        
        [self presentViewController:self.pickerVc animated:YES completion:nil];
        
    }];
    
    CGRect rect = CGRectMake(0, 160 + 64, self.view.bounds.size.width, self.view.bounds.size.height - 160);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"KDProjectCell" bundle:nil] forCellReuseIdentifier:@"projectCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}


/**
 *  返回图片资源
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    [self.iconBtn setImage:[image circleImage] forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KDProjectCell* cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"KDProjectCell" owner:nil options:nil]lastObject];
    }
    
    
    
    return cell;
}

@end
