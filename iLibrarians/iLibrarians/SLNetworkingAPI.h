//
//  SLNetworkingAPI.h
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

// 网络调用的单例，所有网络方法都放到这里

#import <Foundation/Foundation.h>

@interface SLNetworkingAPI : NSObject

+ (SLNetworkingAPI *)sharedInstance;

@end
