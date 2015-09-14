//
//  MainController.h
//  HttpTest
//
//  Created by WANGJIE on 13-11-5.
//  Copyright (c) 2013年 WANGJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UIViewController
{
    NSMutableData *resultData;
}

- (IBAction)buttonClicked:(id)sender;

- (void)postCallback:(NSString *)result;

@property NSMutableData *resultData;

@end
