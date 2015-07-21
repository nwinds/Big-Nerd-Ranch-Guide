//
//  BNRItemStore.m
//  Homepwners
//
//  Created by jyl on 15/7/15.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;
@end



@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;

    // Thread-safe singleton
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}



- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Signleton"
                                   reason:@"Use + [BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
//        _privateItems = [[NSMutableArray alloc] init];
        
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If no previouse saved file exists
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}


- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    
    // If success return YES
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}


- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}


// Override allItems' getter
- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *)createItem
{
    // Create randomized BNRItem
//    BNRItem *item = [BNRItem randomItem];

    // Create empty BNRItem
    // Issue: cannot support Chiness input
    BNRItem *item = [[BNRItem alloc] init];
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

// Change location of an item at array
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get to be moved object's pointer
    BNRItem *item = self.privateItems[fromIndex];
    
    // Not quite efficiant
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
