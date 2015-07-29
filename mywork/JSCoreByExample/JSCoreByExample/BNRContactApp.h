//
//  BNRContactApp.h
//  JSCoreByExample
//
//  Created by jyl on 15/7/29.
//  Copyright (c) 2015年 zmy. All rights reserved.
//
@import JavaScriptCore;

#import <Foundation/Foundation.h>
@class BNRContact;

@protocol BNRContectAppJS <JSExport>

- (void)addContact:(BNRContact *)contact;

@end

@interface BNRContactApp : NSObject <BNRContectAppJS>

- (NSUInteger)numberOfContacts;
- (BNRContact *)contactAtIndex:(NSUInteger)index;
- (void)insertContact:(BNRContact *)contact atIndex:(NSUInteger)index;
- (void)removeContactAtIndex:(NSUInteger)index;
@end
