//
//  NBRequestEngine.h
//  LanyeMarket
//
//  Created by zhuangyanjun on 8/12/12.
//  Copyright (c) 2012年 lanye.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

NSString *const NBRequestHTTPMethodKey;

typedef ASIHTTPRequest NBRequest;

@interface NBRequestEngine : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic, retain) NSString          *accessToken;
@property (nonatomic, retain) NSMutableArray    *deferredRequests;
@property (nonatomic, retain, readonly) NSOperationQueue  *requestQueue;

+ (NBRequestEngine *) engine;

- (BOOL) isLoggedIn;
- (BOOL) isAuthenticating;
- (BOOL) tokenExpired;

- (NBRequest *) issueRequestForURL:(NSString *)url
                    objectsAndKeys:(id)object, ...;

- (NBRequest *) issueRequestForURL: (NSString *)url
                    objectsAndKeys: (NSDictionary *)parameters
                        completion:(ASIBasicBlock)aCompletionBlock
                           failure:(ASIBasicBlock)aFaiedBlock;

- (NBRequest *) issueRequestForURL: (NSString *)url
                          delegate: (id<ASIHTTPRequestDelegate>) delegate
                    objectsAndKeys: (id) object, ...;

- (NBRequest *) issueRequestForURL: (NSString *)url
                          delegate: (id<ASIHTTPRequestDelegate>) delegate
                      asynchronous: (BOOL) asynchronous
                    objectsAndKeys: (NSDictionary *)parameters;

@end