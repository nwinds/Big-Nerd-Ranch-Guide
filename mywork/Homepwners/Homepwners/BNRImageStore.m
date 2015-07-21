//
//  BNRImageStore.m
//  Homepwners
//
//  Created by jyl on 15/7/17.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end



@implementation BNRImageStore

// Thread safe singletion
+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;
//    if (!sharedStore) {
//        sharedStore = [[self alloc] initPrivate];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

// Forbidding calling init directly

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRImageStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// private init function
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
//    [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
//    return [self.dictionary objectForKey:key];
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}



@end
