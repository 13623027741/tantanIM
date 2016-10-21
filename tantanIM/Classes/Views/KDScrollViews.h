//
//  KDScrollViews.h
//  tantanIM
//
//  Created by kaidan on 16/10/20.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDScrollViews : UIView

@property(nonatomic,strong)NSMutableArray* datas;

-(void)startScroll;

-(void)endScroll;

@end
