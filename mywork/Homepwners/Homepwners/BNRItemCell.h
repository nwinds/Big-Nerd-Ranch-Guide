//
//  BNRItemCell.h
//  Homepwners
//
//  Created by jyl on 15/7/22.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end
