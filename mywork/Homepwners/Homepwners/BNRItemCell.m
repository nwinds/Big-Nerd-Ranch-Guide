//
//  BNRItemCell.m
//  Homepwners
//
//  Created by jyl on 15/7/22.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    // Check it block exists before calling
    if (self.actionBlock) {
        self.actionBlock();
    }
    
}
@end