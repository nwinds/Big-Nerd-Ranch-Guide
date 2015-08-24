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
    
    // 转换格式
    NSURL *url = [NSURL URLWithString:urlString];
    
    // NSURLRequest对象表示独立于协议和URL模式的URL加载请求
    // 主构造函数接受包含要加载的URL和（可选）用于该请求的缓存策略的NSURL对象
    // ——Peter van de Put《iOS高级编程》, 2014
    NSURLRequest *req  =[NSURLRequest requestWithURL:url];
    
    // NSURLConnection对象用于执行NSURLRequest的加载， 此处采用最简单的同步调用方式
    // Apple的开发人员指南建议采用异步连接
    // ——Peter van de Put《iOS高级编程》, 2014
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    
    
    // Codes for UI showing the contents on safari
    [self.webView loadRequest:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
