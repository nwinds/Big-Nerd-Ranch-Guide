//
//  BNRContact.h
//  JSCoreByExample
//
//  Created by jyl on 15/7/28.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

@import JavaScriptCore;

#import <Foundation/Foundation.h>


@protocol BNRContactJS <JSExport>
+ (instancetype)contactWithName:(NSString *)name
                          phone:(NSString *)phone
                        address:(NSString *)address;

@end

@interface BNRContact : NSObject <BNRContactJS>

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *phone;
@property (nonatomic, readonly) NSString *address;



@end
