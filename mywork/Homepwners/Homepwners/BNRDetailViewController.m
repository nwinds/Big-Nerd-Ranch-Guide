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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Cancel the first reacted object
    [self.view endEditing:YES];
    
    // "Save" the edited to BNRItem objects
    BNRItem *item = self.item;
    item.itemName  = self.nameField.text;
    item.serialNumber = self.serialNameField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

@end
