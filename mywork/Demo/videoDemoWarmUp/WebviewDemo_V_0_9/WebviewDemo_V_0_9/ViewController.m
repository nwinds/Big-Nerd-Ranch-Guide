//
//  ViewController.m
//  WebviewDemo_V_0_9
//
//  Created by jyl on 15/8/21.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // For web requests loading
    NSString *urlString = @"http://shbank.legoods.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    // User interface display
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
