//
//  NSObject+Block.m
//  DDMJArt
//
//  Created by zhuangyanjun on 29/3/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//

#import "NSObject+Block.h"

@implementation NSObject (Block)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	int64_t delta = (int64_t)(1.0e9 * delay);
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

- (void)performBlockInBackground:(void (^)(void))block
{
	dispatch_async(dispatch_get_global_queue(0, 0),  block);
}
@end
