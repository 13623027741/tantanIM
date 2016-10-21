//
//  KDScrollViews.m
//  tantanIM
//
//  Created by kaidan on 16/10/20.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDScrollViews.h"
#import "Masonry.h"

@interface KDScrollViews ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UICollectionView* collectionView;

@property(nonatomic,strong)UIPageControl* pageControl;

@property(nonatomic,strong)NSTimer* timer;

@end

static NSString* collectionID = @"collection";

@implementation KDScrollViews

-(instancetype)init{
    
    if (self == [super init]) {
        
        
    }
    
    
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.pagingEnabled = YES;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionID];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.collectionView];
        
        
        CGRect rect = CGRectMake(0, 0, 100, 0);
        CGPoint point = CGPointMake(self.center.x, self.bounds.size.height * 0.9);
        self.pageControl = [[UIPageControl alloc] initWithFrame:rect];
        self.pageControl.center = point;
        self.pageControl.numberOfPages = 5;
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [self addSubview:self.pageControl];
        
        
        [self startScroll];
        
        NSLog(@"有没有到这里 --- %@",NSStringFromCGRect(self.bounds));
        
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)layoutSubviews{
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    UIImage* image = [UIImage imageNamed:self.datas[indexPath.row]];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [cell.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(cell.contentView);
    }];
    
    return cell;
}

-(void)startScroll{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeScroll) userInfo:nil repeats:YES];
    
}

-(void)endScroll{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)changeScroll{
    
    if (self.pageControl.currentPage == self.pageControl.numberOfPages - 1) {
        
        NSLog(@"--当前页-[%ld]---所有页-[%ld]---",self.pageControl.currentPage,self.pageControl.numberOfPages);
        
        self.pageControl.currentPage = 0;
        [UIView animateWithDuration:0.3 animations:^{

            self.collectionView.contentOffset = CGPointMake(0, 0);
        }];
        
    }else{
        self.pageControl.currentPage++;
        
        CGFloat x = self.pageControl.currentPage * self.bounds.size.width;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.collectionView.contentOffset = CGPointMake(x, 0);
        }];
        
    }
    
    
    
//    NSLog(@"--当前页-[%ld]---所有页-[%ld]---",self.pageControl.currentPage,self.pageControl.numberOfPages);
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"开始用手拖动");
    
//    NSLog(@"--%@---",NSStringFromCGPoint(scrollView.contentOffset));
    
    [self endScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"结束拖拽");
    [self startScroll];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scroll --- %@",NSStringFromCGPoint(scrollView.contentOffset));
    
    CGFloat x = self.pageControl.currentPage * self.bounds.size.width + self.bounds.size.width / 2;
    
    if (scrollView.contentOffset.x > x) {
        self.pageControl.currentPage ++;
    }
    
    CGFloat temp = self.pageControl.currentPage * self.bounds.size.width - self.bounds.size.width / 2;
    
    if (scrollView.contentOffset.x < temp) {
        self.pageControl.currentPage--;
    }
}

@end
