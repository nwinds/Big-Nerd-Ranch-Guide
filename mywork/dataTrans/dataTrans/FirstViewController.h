//
//  FirstViewController.h
//  dataTrans
//
//  Created by jyl on 15/8/5.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
#pragma mark -Recieve data from child
@property (strong, nonatomic) NSString *editedData;

#pragma mark -Data display
@property (strong, nonatomic) IBOutlet UITextField *firstPageData;

@end
