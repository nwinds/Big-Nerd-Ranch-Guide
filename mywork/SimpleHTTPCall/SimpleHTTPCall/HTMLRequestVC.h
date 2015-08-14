//
//  ViewController.h
//  SimpleHTTPCall
//
//  Created by jyl on 15/8/14.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import <UIKit/UIKit.h>

// html request view controller
@interface HTMLRequestVC : UIViewController
#pragma mark -HTTP request

@property (strong) NSURLConnection* connection;
@property (strong) NSMutableData* webData;

@property (weak, nonatomic) IBOutlet UITextView *responseView;

- (IBAction)loadHTML:(id)sender;


#pragma mark -Image download
@property (nonatomic) NSInteger fileSize;
@property (nonatomic) NSInteger bytesDownloaded;

- (IBAction)downloadImage:(id)sender;


#pragma mark -Regular components
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *receivedImage;

#pragma -Downloading progress components
@property (nonatomic, retain, readwrite) NSOutputStream* fileStream;
@property (nonatomic, assign, readonly) BOOL isReceiving;
@property (nonatomic, retain, readwrite) NSURLConnection* imgConnection;
@property (nonatomic, copy, readwrite) NSString* filePath;


@end

