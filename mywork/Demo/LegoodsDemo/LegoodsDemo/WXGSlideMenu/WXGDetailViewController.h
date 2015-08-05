//
//  WXGDetailViewController.h
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXGMenuItem;

@interface WXGDetailViewController : UIViewController

#pragma mark -Data trans
@property (strong, nonatomic) IBOutlet UITextField *page1Data;
@property (strong, nonatomic) NSString *editData;
#pragma mark -Button clicked

@property (nonatomic, strong) WXGMenuItem *item;

/**
 * 注册顶部按钮的点击事件
 */
@property (nonatomic, copy) void(^leftBarButtonDidClick)();

/**
 * 实现顶部按钮的滚动效果
 */
- (void)rotateLeftBarButtonWithScale:(CGFloat)scale;

@end
