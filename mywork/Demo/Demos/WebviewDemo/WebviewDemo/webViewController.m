//
//  ViewController.m
//  WebviewDemo
//
//  Created by jyl on 15/8/24.
//  Copyright (c) 2015年 yourName. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()

@end

@implementation webViewController

#pragma mark -View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // make connection and make the HTTP request
    // init the url ( NSString )
    NSString *urlString = @"http://shbank.legoods.com";
    // convert the NSString into NSURL
    NSURL *url = [NSURL URLWithString:urlString];
    // init request
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    // make connection
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    // User interface display
    [self.webView loadRequest:req];





}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
