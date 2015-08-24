//
//  ViewController.h
//  WebviewDemo
//
//  Created by jyl on 15/8/24.
//  Copyright (c) 2015年 yourName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController

// property for UIWebView
// press the ctrl key and drag the line linking the webview component to the head file.
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

