//
//  BNRHypnosisViewController.m
//  Hypnosister
//
//  Created by jyl on 15/7/13.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"


@interface BNRHypnosisViewController() <UITextFieldDelegate>

@end

@implementation BNRHypnosisViewController


- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        UILabel *messageLable = [[UILabel alloc] init];
        
        messageLable.backgroundColor = [UIColor clearColor];
        messageLable.textColor = [UIColor whiteColor];
        messageLable.text = message;
        
        // Adjust font size according to requirement
        [messageLable sizeToFit];
        
        // Get randomized x: UILable' width <= BNRHypnosisViewController view's width
        int width = (int)(self.view.bounds.size.width - messageLable.bounds.size.width);
        int x = arc4random() % width;
        
        // Get randomized y: UILable's height <= BNRHypnosisViewController view's height
        int height = (int)(self.view.bounds.size.height - messageLable.bounds.size.height);
        int y = arc4random() % height;
        
        // Set UILable's frame
        CGRect frame = messageLable.frame;
        frame.origin = CGPointMake(x, y);
        messageLable.frame = frame;
        
        // Add UILable object into BNRHypnosisViewController's view
        [self.view addSubview:messageLable];
        
        // Motion effects
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLable addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLable addMotionEffect:motionEffect];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    
    // Print out warning message in consol
    textField.delegate = self;
    
    
    [backgroundView addSubview:textField];
    
    self.view = backgroundView;
}



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = i;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRHypnosisViewController loaded its view.");
}


@end
