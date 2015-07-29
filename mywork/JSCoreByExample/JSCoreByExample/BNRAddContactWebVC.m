//
//  BNRAddContactWebVCViewController.m
//  JSCoreByExample
//
//  Created by jyl on 15/7/29.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

@import JavaScriptCore;

#import "BNRAddContactWebVC.h"
#import "BNRContact.h"
#import "BNRContactApp.h"

@interface BNRAddContactWebVC () <UIWebViewDelegate>

@property (nonatomic, weak) BNRContactApp *app;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation BNRAddContactWebVC

- (instancetype)initWithApp:(BNRContactApp *)app
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.app = app;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Adding a Contact";
    
    // Create the web view
    CGRect webViewFrame = self.view.bounds;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webViewFrame];
    webView.delegate = self;
    
    // Load the URL
    NSURL *url = [NSURL URLWithString:@"http://josephwdixon.com/BNR/JSCoreByExample/BNRContactApp.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    self.webView = webView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -Web view delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Get JSContext from UIWebView instance
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // Enable error logging
    [context setExceptionHandler:^(JSContext *context, JSValue *value){
        NSLog(@"WEB JS: %@", value);
    }];
    
    // Give JS a handler to our BNRContactApp instance
    context[@"myApp"] = self.app;
    
    // Register BNRContact class
    context[@"BNRContact"] = [BNRContact class];
    
    // Add function for processing from submission
    NSString *addContactText =
        @"var contactForm = document.forms[0];"
         "var addContact = function() {"
         "  var name = contactForm.name.value;"
         "  var phone = contactForm.phone.value;"
         "  var address = contactForm.address.value;"
         "  var contact = BNRContact.contactWithNamePhoneAddress(name, phone, address);"
         "  myApp.addContact(contact);"
         "};"
         "contactForm.addEventListener('submit', addContact);";
         
    [context evaluateScript:addContactText];
}

@end
