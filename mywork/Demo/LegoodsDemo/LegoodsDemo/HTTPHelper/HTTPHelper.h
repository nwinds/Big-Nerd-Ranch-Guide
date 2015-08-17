//
//  HTTPHelper.h
//  LegoodsDemo
//
//  Created by jyl on 15/8/17.
//  Copyright (c) 2015年 zmy. All rights reserved.
//
//  HttpHelper.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface HttpHelper : NSObject

+ (BOOL)NetWorkIsOK;//检查网络是否可用
+ (void)post:(NSString *)URL RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;//post请求封装

@end