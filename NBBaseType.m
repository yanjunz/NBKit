//
//  NBBaseType.m
//  GouShenYang
//
//  Created by zhuangyanjun on 29/11/12.
//  Copyright (c) 2012年 Xu Hui. All rights reserved.
//

#import "NBBaseType.h"

@implementation NBBaseType

+ (NSDictionary *)mapping
{
    NSURL *dictURL      = [[NSBundle mainBundle] URLForResource:NSStringFromClass([self class])
                                                  withExtension:@"plist"];
    return dictURL ? [NSDictionary dictionaryWithContentsOfURL:dictURL] :nil;
}

@end
