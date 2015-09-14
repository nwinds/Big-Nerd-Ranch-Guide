//
//  MainController.m
//  HttpTest
//
//  Created by WANGJIE on 13-11-5.
//  Copyright (c) 2013年 WANGJIE. All rights reserved.
//

#import "MainController.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"

@interface MainController ()

@end

@implementation MainController
@synthesize resultData;
- (id)init
{
    return [self initWithNibName:@"main" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    // 同步
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    NSData *recevied = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *result = [[NSString alloc] initWithData:recevied encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"result: %@", result);
    
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
//    NSLog(conn ? @"连接创建成功" : @"连接创建失败");
    
//    [HttpPostWrapper postExecuteWithUrlStr:@"http://www.baidu.com"
//                    Paramters:nil
//                    Delegate:self
//                    FinishCallBackSelector:@selector(postCallback:)];
    
    [HttpPostExecutor postExecuteWithUrlStr:@"http://www.baidu.com"
                                  Paramters:@""
                        FinishCallbackBlock:^(NSString *result){
                            // 执行post请求完成后的逻辑
                            NSLog(@"finish callback block, result: %@", result);
                        }];

}


- (void)postCallback:(NSString *)result
{
    
    NSLog(@"postCallback result: %@", result);
    
}

- (void)postDefaultFinishCallBack:(NSString *)result
{
    NSLog(@"postDefaultFinishCallBack result: %@", result);
}









@end
