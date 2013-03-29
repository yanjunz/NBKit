//
//  NSObject+Block.h
//  DDMJArt
//
//  Created by zhuangyanjun on 29/3/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Block)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (void)performBlockInBackground:(void (^)(void))block;
@end
