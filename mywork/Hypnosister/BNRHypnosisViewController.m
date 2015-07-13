//
//  BNRHypnosisViewController.m
//  Hypnosister
//
//  Created by jyl on 15/7/13.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@implementation BNRHypnosisViewController

- (void)loadView
{
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    self.view = backgroundView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = i;
    }
    
    return self;
}
//
//
//- (void)setRootViewController:(UIViewController *)viewController
//{
//    UIView *rootView = viewController.view;
//
//    CGRect viewFrame = self.bounds;
//    rootView.frame = viewFrame;
//
//    [self addSubview:rootView];
//
//    _rootViewController = viewController;
//
//
//}


@end
