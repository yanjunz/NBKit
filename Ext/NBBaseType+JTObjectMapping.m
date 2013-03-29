//
//  NBBaseType+JObjectMapping.m
//  GouShenYang
//
//  Created by zhuangyanjun on 29/11/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#ifdef NB_FEATURE_JTObjectMapping

#import "NBBaseType+JTObjectMapping.h"

@implementation NBBaseType (JTObjectMapping)

+ (id)objectFromJSONObject:(id<JTValidJSONResponse>)object
{
    return [self objectFromJSONObject:object mapping:[[self mapping] mutableCopy]];
}

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key
{
    //    NSLog(@"mappingWithKey : %@, map %@", key, [self mapping]);
    return [self mappingWithKey:key mapping:[[self mapping] mutableCopy]];
}

@end

#endif // NB_FEATURE_JTObjectMapping
