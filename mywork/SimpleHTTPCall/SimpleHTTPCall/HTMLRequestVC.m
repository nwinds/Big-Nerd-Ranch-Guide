//
//  ViewController.m
//  SimpleHTTPCall
//
//  Created by jyl on 15/8/14.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "HTMLRequestVC.h"

@interface HTMLRequestVC ()
//#pragma mark -HTTP request

@end

@implementation HTMLRequestVC

#pragma mark -HTTP request
@synthesize connection;
@synthesize webData;


#pragma mark -Image download
@synthesize fileSize;
@synthesize bytesDownloaded;


#pragma mark -UIView lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -HTTP request handler


- (IBAction)loadHTML:(id)sender
{
    self.responseView.text = @"";
    
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    [theRequest setHTTPMethod:@"GET"];
    connection = [[NSURLConnection alloc]
                  initWithRequest:theRequest delegate:self];
    if ( connection ) {
        webData = [[NSMutableData alloc] init];
    }
}

#pragma mark -Image download
- (IBAction)downloadImage:(id)sender
{
//    BOOL success;
    NSURL* url = [NSURL URLWithString:@"http://developer.yourdeveloper.net/Images/YDLOGO.png"];
    BOOL success = (url != nil);
    
    // Set file descripter
    self.filePath = [self createFileName];
    self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
    
    // Open stream
    [self.fileStream open];
    
    // Create a request
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    // Create a connection
    self.imgConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    // Clear the image
    self.receivedImage.image = nil;
    self.progressView.progress = 0;
}

// Shut down the connection and displays the result
- (void)stopReceivingWithStatus:(NSString *)statusString
{
    if (self.imgConnection != nil) {    // image loaded, shutdown connection
        [self.connection cancel];
        self.connection = nil;
    }
    if (self.fileStream != nil) {       // close fp
        [self.fileStream close];
        self.fileStream = nil;
    }
    
    self.statusLabel.text = statusString;
    self.receivedImage.image = [UIImage imageWithContentsOfFile:self.filePath];
    self.filePath = nil;                // clear finished file's path
}




// Odd(synchrolization?)
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    // Create a static NSSet with mime types your download will support
//    static NSSet * sSupportedImageTypes;
//}

//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    
//}
//
//- (void)connection
//


#pragma mark -Delegates
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // HTTP requests
    [webData setLength:0];
    
    
    // Download image
    // Create a static NSSet with image types your download will support
    static NSSet* sSupportedImageTypes;
    NSHTTPURLResponse* httpResponse;
    if (sSupportedImageTypes == nil) {
        sSupportedImageTypes = [[NSSet alloc] initWithObjects:@"image/jpeg", @"image/png", @"image/git", nil];
    }
    
    httpResponse = (NSHTTPURLResponse *)response;
    // read the content length from the header field
    fileSize = [[[httpResponse allHeaderFields] valueForKey:@"Content-Length"] integerValue];
    bytesDownloaded = 0;
    // Check the status code
    if (httpResponse.statusCode != 200) {
        NSLog(@"error: %@", [NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode]);
    } else {
        NSString *fileMIMEType = [[httpResponse MIMEType] lowercaseString];
        if (fileMIMEType == nil) {
            [self stopReceivingWithStatus:@"No Content-Type!"];
        } else if ( ![sSupportedImageTypes containsObject:fileMIMEType] ){
            [self stopReceivingWithStatus:[NSString stringWithFormat:@"Unsupported Content-Type (%@)", fileMIMEType]];
        } else {
            self.statusLabel.text = @"Response OK";
        }
    }

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // HTTP requests
    [webData appendData:data];
    
    
    // Download image
    NSInteger bytesWritten = 0;
    NSInteger bytesWrittenSoFar = 0;
    NSInteger dataLength = [data length];
    const uint8_t* dataBytes = [data bytes];
    
    while (bytesWrittenSoFar != dataLength) {
        bytesWritten = [self.fileStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
        if (bytesWritten == -1) {
            [self stopReceivingWithStatus:@"File write error"];
            break;
        } else {
            bytesWrittenSoFar += bytesWritten;
        }
        bytesDownloaded += bytesWritten;
        self.progressView.progress = ((float)bytesDownloaded / (float)fileSize);
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // HTTP requests
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:@"Can't make a connection."
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil];
    [alert show];
    
    // Download image
    [self stopReceivingWithStatus:@"Connection failed"];
}


// important: error handle
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // HTTP requests
    NSString *responseString = [[NSString alloc]
                                initWithBytes:[webData mutableBytes]
                                length:[webData length]
                                encoding:NSUTF8StringEncoding];
    self.responseView.text = responseString;
    
    // Download image
    [self stopReceivingWithStatus:@"Download has finished"];
}
@end
