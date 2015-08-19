//
//  HttpPostWrapper.h
//  HttpTest
//
//  Created by WANGJIE on 13-11-5.
//  Copyright (c) 2013年 WANGJIE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpPostDelegate : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData *resultData;
    id delegate;
    SEL finishCallBack;
}

+ (void)postExecuteWithUrlStr:(NSString *)urlStr Paramters:(NSString *)params Delegate:(id)delegate FinishCallBackSelector:(SEL)finishCallBack;


@property NSMutableData *resultData;
@property id delegate;
@property SEL finishCallBack;
@end
