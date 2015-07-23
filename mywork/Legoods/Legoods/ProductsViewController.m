//
//  ProductsViewController.m
//  Legoods
//
//  Created by jyl on 15/7/23.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "ProductsViewController.h"

@interface ProductsViewController ()

#pragma mark -NSURLSession
@property (nonatomic) NSURLSession *session;


#pragma mark -NSURLSession API

@end

@implementation ProductsViewController

#pragma mark -Initialization
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationController.title = @"Legoods";
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                 delegate:nil
                                            delegateQueue:nil];
        
        [self fetchFeed];
    }
    
    return self;
}

#pragma mark -Data source fetching
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)fetchFeed
{
    // First iteration: use demo's website while json is not sure
    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:
                            ^(NSData *data, NSURLResponse *response, NSError *error)
                            {
                                NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                NSLog(@"%@", json);
                            }
                                      ];
    [dataTask resume];
    
}


@end
