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
@synthesize connection;

#pragma mark -Interaction with Amazon Login
@synthesize page1Data;


#pragma mark -UIView lifecycle
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    page1Data.text=editData;
    
    // Webview handler
    NSString *urlBase = @"https://www.legoods.com:2443/handle_login.php?access_token=";
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@%@", urlBase, editData];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    url_sec = [NSURL URLWithString:urlString];
    
    NSLog(@"url_sec: %@", url_sec);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url_sec];
    [self.webView loadRequest:request];

}


//helper
-(NSString *)returnFormatString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@" "];
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
    
    
    // Webview handler
//    NSURL *url = [NSURL URLWithString:@"http://www.legoods.com/mindex"];
    NSString *urlBase = @"https://www.legoods.com:2443/handle_login.php?access_token=";
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@%@", urlBase, editData];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    url_sec = [NSURL URLWithString:urlString];
    
    NSLog(@"url_sec: %@", url_sec);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_sec];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
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


#pragma mark -Connection handle
#pragma mark -Delegates
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // HTTP requests
//    [webData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // HTTP requests
//    [webData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // HTTP requests
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:@"Can't make a connection."
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil];
    [alert show];

}


// important: error handle
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // HTTP requests

}


- (void)setItem:(WXGMenuItem *)item {
    _item = item;
//
////    self.detailImage.image = [UIImage imageNamed:item.bigImage];
//    CGFloat r = [item.colors[0] doubleValue];
//    CGFloat g = [item.colors[1] doubleValue];
//    CGFloat b = [item.colors[2] doubleValue];
//    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
    
}


@end
