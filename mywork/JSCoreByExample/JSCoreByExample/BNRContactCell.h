//
//  BNRContactCell.h
//  JSCoreByExample
//
//  Created by jyl on 15/7/29.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end
