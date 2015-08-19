//
//  WXGDetailViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "WXGMenuItem.h"
#import "HTTPHelper.h"
#import "APLViewController.h"
#import "AMZNLoginController.h"
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

#pragma mark -Button gestures

@synthesize title;

#pragma mark -UIView lifecycle
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    page1Data.text=editData;
    
    // Webview handler
    [self loadWebView];
    

}


- (void)login{
    NSString *url = @"https://www.legoods.com:2443/handle_login.php";
//    urlString = [NSString stringWithFormat:@"%@%@", urlBase, editData];
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *access_token = [NSString stringWithFormat:@"%@", editData];
    [access_token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:access_token forKey:@"access_token"];

    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){
        //发送请求，并且得到返回的数据
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                //传回来的数据存在，则执行改回调甘薯
                if(data){
                    //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                    //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                    [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];
//                    NSLog(@"%@", response);
//                    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                    NSLog(@"data as string = %@", aStr);
                }
                else{
                    NSLog(@"无效的数据");
                }
        }];
    }
}

//登录的回调函数，首先判断接收的值是不是能登录。若不能，则提示用户。若能登录，则处理segue来跳转界面
- (void)login_callBack:(id)value{
    NSLog(@"成功返回结果");
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
    [self loadWebView];
}


- (void)loadWebView
{
    NSString *urlBase = @"https://www.legoods.com:2443/handle_login.php?access_token=";
    NSString *urlString;
    urlString = [NSString stringWithFormat:@"%@%@", urlBase, editData];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    url_sec = [NSURL URLWithString:urlString];
    
    NSLog(@"url_sec: %@", url_sec);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_sec];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // Debug
    [self login];
    
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

#pragma mark -Helper
-(NSString *)returnFormatString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@" "];
}

#pragma mark -Menu Interact
- (void)setItem:(WXGMenuItem *)item {
    _item = item;
    self.title = item.title;
//    self.detailImage.image = [UIImage imageNamed:item.bigImage];
//    CGFloat r = [item.colors[0] doubleValue];
//    CGFloat g = [item.colors[1] doubleValue];
//    CGFloat b = [item.colors[2] doubleValue];
//    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
    
}


- (IBAction)loginWithAmazon:(id)sender
{
    NSLog(@"login with amazon clicked");
    
    NSString * viewControllerID = @"loginVC";
    UIStoryboard * storyboardCurr = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AMZNLoginController * subviewVC = (AMZNLoginController *)[storyboardCurr instantiateViewControllerWithIdentifier:viewControllerID];
    [self presentViewController:subviewVC animated:YES completion:nil];
}

- (IBAction)reachabilityCheck:(id)sender
{
    NSLog(@"reachabiliy clicked");
    // Using current storyboard to load subview dynamically
    // See http://stackoverflow.com/questions/10522957/call-storyboard-scene-programmatically-without-needing-segue for further info.
    
    NSString * viewControllerID = @"ReachabilityVC";
    UIStoryboard * storyboardCurr = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    APLViewController * subviewVC = (APLViewController *)[storyboardCurr instantiateViewControllerWithIdentifier:viewControllerID];
    [self presentViewController:subviewVC animated:YES completion:nil];
}
@end
