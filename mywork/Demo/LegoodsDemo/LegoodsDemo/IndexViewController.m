//
//  IndexViewController.m
//  LegoodsDemo
//
//  Created by jyl on 15/7/24.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
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

#pragma mark -Amazon login
- (IBAction)amznLogin:(id)sender
{

//    [super viewDidLoad];
//    
//    NSURL *url = [NSURL URLWithString:@"http://www.legoods.com/mindex"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
