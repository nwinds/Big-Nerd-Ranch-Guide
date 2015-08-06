//
//  WXGDetailViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"

@interface WXGDetailViewController ()

#pragma mark -Web HTML5
@property (assign, nonatomic) IBOutlet UIWebView *webView;

#pragma mark -UIImageView
//@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@property (nonatomic, weak) UIImageView *leftBarIcon;

@end

@implementation WXGDetailViewController
//#pragma mark -Data trans
//@synthesize page1Data;
//@synthesize editData;

#pragma mark -Login access token
// transision between parent and sub views
@synthesize parentPageData;
@synthesize editAccessToken;

#pragma mark -Storyboard handler
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSString *data = page1Data.text;
    UIViewController *view = segue.destinationViewController;
//    if ([view respondsToSelector:@selector(setParam:)]) {
//        [view setValue:data forKey:@"param"];
//    }
//    // Note: namiming with lower or upper letter MATTERS here!
//    if ([view respondsToSelector:@selector(setDetailViewController:)]) {
//        [view setValue:self forKey:@"detailViewController"];
//    }
    
    // Amazon login access token transision
    NSString *dataAccessToken = parentPageData.text;
    if ([view respondsToSelector:@selector(setParamAccessToken:)]) {
        [view setValue:dataAccessToken forKey:@"paramAccessToken"];
    }
    if ([view respondsToSelector:@selector(setUserLoginController:)]) {
        [view setValue:self forKey:@"userLoginController"];
    }
}

#pragma mark -View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    page1Data.text = editData;
    
    // Init test 1
//    parentPageData.text = @"access token";// Test 1 through!
    parentPageData.text = editAccessToken;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Navigation Item handler
    // 去掉导航条下面的阴影效果的那条线
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    // UIBarButtonItem的initWithCustomView:方法会对内部控件有特殊约束
    // 直接将leftBarIcon添加上去会无法实现滚动效果
    // 解决办法：将leftBarIcon包装在一个view里面
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarButtonClick)];
    [wrapView addGestureRecognizer:tap];
    
    // leftBar and rightBar
    UIImageView *leftBarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    self.leftBarIcon = leftBarIcon;
    [wrapView addSubview:leftBarIcon];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
    // rightBar code here
    // ...
    
    
    // Webview handler
//    NSURL *url = [NSURL URLWithString:@"http://www.legoods.com/mindex"];
    NSURL *url = [NSURL URLWithString:@"https://www.legoods.com:2443/handle_login.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark -Navigation Item helper
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

- (void)setItem:(WXGMenuItem *)item {
    _item = item;

    // Sub view icon
    // Should thumbnail sized image added later on?
//    self.detailImage.image = [UIImage imageNamed:item.bigImage];
    
    // Background color
    CGFloat r = [item.colors[0] doubleValue];
    CGFloat g = [item.colors[1] doubleValue];
    CGFloat b = [item.colors[2] doubleValue];
    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}



@end
