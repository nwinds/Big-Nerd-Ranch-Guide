//
//  LoginViewController.m
//  LegoodsDemo
//
//  Created by jyl on 15/7/24.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "HighchartViewController.h"
#import "HighchartsWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface HighchartViewController ()

@end

@implementation HighchartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)highchart:(id)sender
{
    HighchartsWebViewController *highchartsWeb =[[HighchartsWebViewController alloc]init];
    [self.navigationController pushViewController:highchartsWeb animated:YES];
}
@end
