//
//  IndexViewController.m
//  LegoodsDemo
//
//  Created by jyl on 15/7/24.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation IndexViewController

//@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://www.legoods.com/mindex"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}



@end
