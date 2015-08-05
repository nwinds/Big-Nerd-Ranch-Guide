//
//  FirstViewController.m
//  dataTrans
//
//  Created by jyl on 15/8/5.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize firstPageData;

@synthesize editedData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    firstPageData.text = editedData;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *data = firstPageData.text;
    UIViewController *view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setParam:)]) {
        [view setValue:data forKey:@"param"];
    }
    if ([view respondsToSelector:@selector(setFirstViewController:)]) {
        [view setValue:self forKey:@"firstViewController"];
    }
}
 

@end
