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
#define NBDPRINTMETHODNAME() TTDPRINT(@"%s", __PRETTY_FUNCTION__)

#ifdef DEBUG
#define NBDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
NBDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define NBDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif // #ifdef DEBUG


#endif
