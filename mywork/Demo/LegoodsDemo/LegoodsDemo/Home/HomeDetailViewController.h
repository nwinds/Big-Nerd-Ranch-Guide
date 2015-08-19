//
//  WXGDetailViewController.h
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//
// Edited by zmy
#import <UIKit/UIKit.h>
@class WXGMenuItem;

@interface HomeDetailViewController : UIViewController
#pragma mark -Demo
@property (strong, nonatomic) IBOutlet UITextField *page1Data;
@property (strong,nonatomic) NSString* editData;

#pragma mark -Web page loading
@property (assign, nonatomic) IBOutlet UIWebView *webView;
@property (strong) NSURL *url_sec; // atomic!
@property (strong) NSURLConnection *connection;

#pragma mark -Button gestures

@property (nonatomic, strong) WXGMenuItem *item;


#pragma mark -Interaction with Amazon Login


#pragma mark -Button handle
/**
 * 注册顶部按钮的点击事件
 */
@property (nonatomic, copy) void(^leftBarButtonDidClick)();

/**
 * 实现顶部按钮的滚动效果
 */
- (void)rotateLeftBarButtonWithScale:(CGFloat)scale;



#pragma mark -Menu Interact
// Subview loading dynamically
- (void)setItem:(WXGMenuItem *)item;

@end
