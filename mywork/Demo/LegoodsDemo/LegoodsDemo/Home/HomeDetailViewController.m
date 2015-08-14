//
//  WXGDetailViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "WXGMenuItem.h"

@interface HomeDetailViewController ()

#pragma mark -Button gestures
@property (nonatomic, weak) UIImageView *leftBarIcon;

@end


@implementation HomeDetailViewController
#pragma mark -Demo
@synthesize editData;


#pragma mark -Web page loading
@synthesize url_sec;


#pragma mark -Interaction with Amazon Login
@synthesize page1Data;


#pragma mark -UIView lifecycle
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    page1Data.text=editData;
    // handle phasing
    // resolving url
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"https";
    components.host = @"www.legoods.com";
    components.port = @2443;
    components.path = @"/handle_login.php";
    components.query = [@"access_token=" stringByAppendingString:page1Data.text];
    
    url_sec = components.URL;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉导航条下面的阴影效果的那条线
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    // UIBarButtonItem的initWithCustomView:方法会对内部控件有特殊约束
    // 直接将leftBarIcon添加上去会无法实现滚动效果
    // 解决办法：将leftBarIcon包装在一个view里面
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarButtonClick)];
    [wrapView addGestureRecognizer:tap];
    
    UIImageView *leftBarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    self.leftBarIcon = leftBarIcon;
    
    [wrapView addSubview:leftBarIcon];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
    // rightBar code here
    // ...
    
    
    // handle phasing
    // resolving url
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"https";
    components.host = @"www.legoods.com";
    components.port = @2443;
    components.path = @"/handle_login.php";
    components.query = [@"access_token=" stringByAppendingString:page1Data.text];
    
    url_sec = components.URL;
    
    
    // Webview handler
//    //    NSURL *url = [NSURL URLWithString:@"http://www.legoods.com/mindex"];
//    NSString *url_base = @"https://www.legoods.com:2443/handle_login.php?access_token=";
//    NSString *url_str = [page1Data.text stringByAppendingString:<#(NSString *)#>];
//    
//    // Debug log
    
    NSLog(@"url_sec: %@", url_sec);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_sec];
    [self.webView loadRequest:request];
}

// 顶部按钮点击事件
- (void)leftBarButtonClick {
    if (self.leftBarButtonDidClick) {
        self.leftBarButtonDidClick();
    }
}

// 顶部按钮滚动效果
- (void)rotateLeftBarButtonWithScale:(CGFloat)scale {
    CGFloat angle = M_PI_2 * (1 - scale);
    self.leftBarIcon.transform = CGAffineTransformMakeRotation(angle);
}


#pragma mark -Storyboard
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString* data = page1Data.text;
    UIViewController* view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setParam:)]) {
        [view setValue:data forKey:@"param"];
    }
    
    if ([view respondsToSelector:@selector(setModalSegueParentVC:)]) {
        [view setValue:self forKey:@"modalSegueParentVC"];
    }
}

//- (void)setItem:(WXGMenuItem *)item {
//    _item = item;
//    
////    self.detailImage.image = [UIImage imageNamed:item.bigImage];
//    CGFloat r = [item.colors[0] doubleValue];
//    CGFloat g = [item.colors[1] doubleValue];
//    CGFloat b = [item.colors[2] doubleValue];
//    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
//    
//}


@end
