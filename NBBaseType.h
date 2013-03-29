//
//  NBBaseType.h
//  GouShenYang
//
//  Created by zhuangyanjun on 29/11/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NBBaseType <NSObject>
+ (NSDictionary *)mapping;
@end

@interface NBBaseType : NSObject<NBBaseType>

@end
