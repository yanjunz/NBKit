//
//  NBBaseType+JObjectMapping.h
//  GouShenYang
//
//  Created by zhuangyanjun on 29/11/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#ifdef NB_FEATURE_JTObjectMapping

#import "NBBaseType.h"
#import "NSObject+JTObjectMapping.h"

@interface NBBaseType (JTObjectMapping)
+ (id)objectFromJSONObject:(id<JTValidJSONResponse>)object;
+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key;
@end


#endif // NB_FEATURE_JTObjectMapping