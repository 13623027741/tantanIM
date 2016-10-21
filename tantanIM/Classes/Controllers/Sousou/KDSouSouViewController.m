//
//  KDSouSouViewController.m
//  tantanIM
//
//  Created by kaidan on 16/10/18.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDSouSouViewController.h"
#import "CCDraggableContainer.h"
#import "CustomCardView.h"
#import "KDPhoto.h"
#import "KDInfoViewController.h"

@interface KDSouSouViewController ()<CCDraggableContainerDataSource,CCDraggableContainerDelegate>

@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;



@end

@implementation KDSouSouViewController

-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadUI];
    
    
    
}

- (void)loadUI {
    
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 64, CCWidth,1.5 * CCWidth) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    
    [self.container reloadData];
}

- (void)loadData {
    
    
    for (int i = 0; i < 9; i++) {
        
        KDPhoto* photo = [KDPhoto PhotoWithUrl:[NSString stringWithFormat:@"image_%d.jpg",i + 1] title:[NSString stringWithFormat:@"第%d张",i + 1] userID:nil];
        
        [self.dataSources addObject:photo];
    }
}


#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    CustomCardView *cardView = [[CustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    NSLog(@"宽度的偏移[%g] 高度的偏移[%g]",widthRatio,heightRatio);
    
    if (widthRatio < -0.5) {
        [draggableContainer removeFormDirection:CCDraggableDirectionLeft];
        NSLog(@"向左有没有移除");
    }else if (widthRatio > 0.5){
        [draggableContainer removeFormDirection:CCDraggableDirectionRight];
        NSLog(@"向右有没有移除");
    }
    
    
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
    
    KDInfoViewController* profileVC = [[UIStoryboard storyboardWithName:@"KDInfoViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"info"];
    [self.navigationController pushViewController:profileVC animated:YES];
    
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
//    [draggableContainer reloadData];
    
    NSLog(@"---%d",finishedDraggableLastCard);
    
}
@end
