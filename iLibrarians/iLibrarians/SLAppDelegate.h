//
//  SLAppDelegate.h
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLIBEngine;

@interface SLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)iLIBEngine *iLibEngine;

+ (instancetype)sharedDelegate;

@end
