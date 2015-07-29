//
//  ContextMenuCell.h
//  LegoodsDemo
//
//  Created by jyl on 15/7/29.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YALContextMenuCell.h"

@interface ContextMenuCell : UITableViewCell <YALContextMenuCell>

@property (strong, nonatomic) IBOutlet UIImageView *menuImageView;
@property (strong, nonatomic) IBOutlet UILabel *menuTitleLabel;

@end
