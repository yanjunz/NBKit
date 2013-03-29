//
//  NBFeatures.h
//  DDMJArt
//
//  Created by zhuangyanjun on 29/3/13.
//  Copyright (c) 2013年 jiyue.cc. All rights reserved.
//

#ifndef DDMJArt_NBFeatures_h
#define DDMJArt_NBFeatures_h

#ifndef NB_USE_JTObjectMapping
#define NB_USE_JTObjectMapping 1
#endif

#ifndef NB_USE_PullRefresh_PushLoad
#define NB_USE_PullRefresh_PushLoad 1
#endif

#if !NB_USE_JTObjectMapping
#undef NB_FEATURE_JTObjectMapping
#else
#define NB_FEATURE_JTObjectMapping
#endif

#if !NB_USE_PullRefresh_PushLoad
#undef NB_FEATURE_PullRefresh_PushLoad
#else 
#define NB_FEATURE_PullRefresh_PushLoad
#endif

#endif
