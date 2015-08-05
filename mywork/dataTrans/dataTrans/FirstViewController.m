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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        //     Get the new view controller using [segue destinationViewController].
        //     Pass the selected object to the new view controller.
    NSString *data = firstPageData.text;
    UIViewController *view = segue.destinationViewController;
    if ([view respondsToSelector:@selector(setParam:)]) {
        [view setValue:data forKey:@"param"];
    }
}
 

@end
