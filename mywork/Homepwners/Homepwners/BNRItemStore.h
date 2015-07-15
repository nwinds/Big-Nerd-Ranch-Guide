//
//  BNRItemStore.h
//  Homepwners
//
//  Created by jyl on 15/7/15.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

// For this class, allItems is changeable, to other classes, allItems is unchangable
@property (nonatomic, readonly) NSArray *allItems;


+ (instancetype)sharedStore;
- (BNRItem *)createItem;

@end
