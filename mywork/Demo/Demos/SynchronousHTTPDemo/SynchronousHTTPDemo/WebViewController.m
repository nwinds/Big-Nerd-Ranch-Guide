//
//  ViewController.m
//  SynchronousHTTPDemo
//
//  Created by jyl on 15/8/24.
//  Copyright (c) 2015年 yourName. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

#pragma mark -View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Web request and connection handle
    
    NSString *urlString = @"http://shbank.legoods.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req  =[NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    // Codes for UI showing the contents on safari
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
