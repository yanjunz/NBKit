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
#define NB_USE_JTObjectMapping 0
#endif

#if !NB_USE_JTObjectMapping
#undef NB_FEATURE_JTObjectMapping
#else
#define NB_FEATURE_JTObjectMapping
#endif

#endif
