//
//  SLNetworkingAPI.m
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLNetworkingAPI.h"

@implementation SLNetworkingAPI

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (SLNetworkingAPI *)sharedInstance
{
    static SLNetworkingAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SLNetworkingAPI alloc] init];
    });
    return _sharedInstance;
}

@end
