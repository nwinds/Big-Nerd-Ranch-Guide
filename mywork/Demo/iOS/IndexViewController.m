//
//  IndexViewController.m
//  LegoodsDemo
//
//  Created by jyl on 15/7/24.
//  Copyright (c) 2015年 zmy. All rights reserved.
//
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "IndexViewController.h"
//#import "AMZNAuthorizationDelegate.h"

//#import "AMZNAuthorizeUserDelegate.h"

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

- (IBAction)onLoginButtonClicked:(id)sender
{
    // Make authorize call to SDK to get secure access token for the user.
    
    // While making the first call you can specify the minimum basic
    // scopes needed.
    
    // Requesting both scopes for the current user.
//    NSArray *requestScopes = [NSArray arrayWithObjects:@"profile", @"postal_code", nil];
//    AMZNAuthorizationDelegate* delegate = [[AMZNAuthorizationDelegate alloc] initWithParentController:self];
//    [AIMobileLib authorizeUserForScopes:requestScopes delegate:delegate];

}


@end
