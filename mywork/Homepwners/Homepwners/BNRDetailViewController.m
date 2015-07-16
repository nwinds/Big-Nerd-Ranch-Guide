//
//  BNRDetailViewController.m
//  Homepwners
//
//  Created by jyl on 15/7/16.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNameField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@end




@implementation BNRDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNameField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // Create NSDateFormatter object to convert NSDate into simple date string
    static NSDateFormatter *dateFormater = nil;
    if (!dateFormater) {
        dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.dateStyle = NSDateIntervalFormatterMediumStyle;
        dateFormater.timeStyle = NSDateIntervalFormatterNoStyle;
    }
    
    self.dateLable.text = [dateFormater stringFromDate:item.dateCreated];
}

@end
