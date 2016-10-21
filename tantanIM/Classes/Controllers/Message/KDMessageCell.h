//
//  KDMessageCell.h
//  tantanIM
//
//  Created by kaidan on 16/10/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *message;

@property (weak, nonatomic) IBOutlet UILabel *time;

@end
