//
//  SecondViewController.m
//  dataTrans
//
//  Created by jyl on 15/8/5.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize firstViewController;
@synthesize param;
@synthesize secondPageData;

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([firstViewController respondsToSelector:@selector(setEditedData:)]) {
        [secondPageData endEditing:YES];
        [firstViewController setValue:secondPageData.text forKey:@"editedData"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    secondPageData.text = param;
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

- (IBAction)closeWin:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
