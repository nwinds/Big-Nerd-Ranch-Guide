//
//  firstSubViewController.m
//  SlideMenu
//
//  Created by jyl on 15/8/24.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "firstSubViewController.h"

@interface firstSubViewController ()

@end

@implementation firstSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 关闭子视图
- (IBAction)closeSubview:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
