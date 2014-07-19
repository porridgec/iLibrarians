//
//  SLPersistencyAPI.m
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLPersistencyAPI.h"

@implementation SLPersistencyAPI

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (SLPersistencyAPI *)sharedInstance
{
    static SLPersistencyAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SLPersistencyAPI alloc] init];
    });
    return _sharedInstance;
}

@end
