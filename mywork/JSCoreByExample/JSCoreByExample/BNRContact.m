//
//  BNRContact.m
//  JSCoreByExample
//
//  Created by jyl on 15/7/28.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

@import JavaScriptCore;

#import "BNRContact.h"

@interface BNRContact ()
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *address;

+ (BOOL)isValidNumber:(NSString *)phone;

@end

@implementation BNRContact


+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone address:(NSString *)address
{
    if ([self isValidNumber:phone]) {
        BNRContact *contact = [BNRContact new];
        contact.name = name;
        contact.phone = phone;
        contact.address = address;
        return contact;
    } else {
        NSLog(@"Phone number %@ doesn't match format", phone);
        return nil;
    }
}

+ (BOOL)isValidNumber:(NSString *)phone
{
    // Getting a JSContext
    JSContext *context = [JSContext new];
    
    // Defining a JavaScript function
    NSString *jsFunctionText =
    @"var isValidNumber = function(phone) {"
    "   var phonePattern = /^[0-9]{3}[ ][0-9]{3}[-][0-9]{4}$/;"
    "   return phone.match)phonePattern) ? true : false;"
    "}";
    [context evaluateScript:jsFunctionText];
    
    // Calling a JavaScript function
    JSValue *jsFunction = context[@"isValidNumber"];
    JSValue *value = [jsFunction callWithArguments:@[ phone ]];
    
    return [value toBool];
}

@end
