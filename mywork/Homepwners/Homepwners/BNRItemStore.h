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

#pragma mark - Class method
+ (instancetype)sharedStore;


#pragma mark - Actions
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;

@end
