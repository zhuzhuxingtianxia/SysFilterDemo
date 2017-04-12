//
//  NdUncaughtExceptionHandler.h
//  NoK
//
//  Created by hzllb on 13-12-13.
//  Copyright (c) 2013年 hzllb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NdUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler*)getHandler;

@end
