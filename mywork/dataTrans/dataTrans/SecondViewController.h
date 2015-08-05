//
//  SecondViewController.h
//  dataTrans
//
//  Created by jyl on 15/8/5.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (strong, nonatomic) id firstViewController;
@property (strong, nonatomic) IBOutlet UITextField *secondPageData;
@property (strong, nonatomic) NSString *param;


- (IBAction)closeWin:(id)sender;
@end
