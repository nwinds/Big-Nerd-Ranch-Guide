//
//  WXGDetailViewController.h
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXGMenuItem;

@interface HomeDetailViewController : UIViewController

@property (nonatomic, strong) WXGMenuItem *item;

@property (strong, nonatomic) IBOutlet UIButton *accessTokenBtn;
@property (strong, nonatomic) IBOutlet UIButton *reachableBtn;

#pragma mark -Interaction with Amazon Login
@property (strong, nonatomic) NSString* editAccessToken;


//- (IBAction)accessTokenClicked:(id)sender;

#pragma mark -Button handle
/**
 * 注册顶部按钮的点击事件
 */
@property (nonatomic, copy) void(^leftBarButtonDidClick)();

/**
 * 实现顶部按钮的滚动效果
 */
- (void)rotateLeftBarButtonWithScale:(CGFloat)scale;

@end
