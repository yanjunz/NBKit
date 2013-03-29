//
//  NBDebug.h
//  GouShenYang
//
//  Created by zhuangyanjun on 30/11/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#ifndef NBKit_NBDebug_h
#define NBKit_NBDebug_h

// The general purpose logger. This ignores logging levels.
#ifdef DEBUG
#define NBDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NBDPRINT(xx, ...)  ((void)0)
#endif // #ifdef DEBUG

// Prints the current method's name.
#define NBDPRINTMETHODNAME() NBDPRINT(@"%s", __PRETTY_FUNCTION__)

#ifdef DEBUG
#define NBDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
NBDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define NBDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif // #ifdef DEBUG


#ifdef DEBUG
#define NBDebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NBDebugLog(...)
#endif

#define NBLogFuncName NBDebugLog(@"%s: %@", __FUNCTION__, self)

#define NBDumpStack()	NBDebugLog(@"Call Stack:\n%@", [NSThread callStackSymbols])
#define	NBDebugShowFrame(prefix,frm) NBDebugLog(@"%@ (%f x %f)@(%f,%f)", prefix, frm.size.width, frm.size.height, frm.origin.x, frm.origin.y)
#define	NBDebugShowSize(prefix,size) NBDebugLog(@"%@ (%f x %f)", prefix, size.width, size.height)

#define NBTRACE  	NBDebugLog(@"%s %p", __FUNCTION__, self)


#endif
