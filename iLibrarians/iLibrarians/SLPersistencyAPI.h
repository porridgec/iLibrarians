//
//  SLPersistencyAPI.h
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

// 调用持久性数据的单例，coredata,文本，数据等等的调用放在这里

#import <Foundation/Foundation.h>

@interface SLPersistencyAPI : NSObject

+ (SLPersistencyAPI *)sharedInstance;

@end
