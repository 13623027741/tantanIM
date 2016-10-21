//
//  KDInfoViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/20.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDInfoViewController.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "KDProjectCell.h"
#import "KDScrollViews.h"


@interface KDInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)KDScrollViews* scrollViews;
@end

static NSString* cellID = @"cell";
@implementation KDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"KDProjectCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    NSArray* imgs = @[@"image_1",@"image_2",@"image_3",@"image_4",@"image_5"];
    
    self.scrollViews = [[KDScrollViews alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.scrollViews.backgroundColor = [UIColor orangeColor];
    self.scrollViews.datas = [NSMutableArray arrayWithArray:imgs];
    self.tableView.tableHeaderView = self.scrollViews;
}

-(void)setNavigationBar{
    
    self.navigationController.navigationBar.layer.opacity = 0.8;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)back{
    [self.scrollViews endScroll];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KDProjectCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KDProjectCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

@end
