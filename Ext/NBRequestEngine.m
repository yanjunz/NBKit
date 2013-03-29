//
//  NBRequestEngine.m
//  LanyeMarket
//
//  Created by zhuangyanjun on 8/12/12.
//  Copyright (c) 2012年 lanye.com. All rights reserved.
//

#import "NBRequestEngine.h"
#import "ASIFormDataRequest.h"
#import "NSDictionary+URLQuery.h"

const NSInteger NBRequestEngineDefualtTimeOut = 60;

NSString *const NBRequestHTTPMethodKey = @"NBRequestHTTPMethodKey";
NSString *const NBRequestServiceKey    = @"NBRequestServiceKey";

@interface NBRequestEngine()
@property (nonatomic, retain) NBRequest *authRequest;
@property (nonatomic, assign) BOOL authenticating;

@end

@implementation NBRequestEngine
@synthesize accessToken         = _accessToken;
@synthesize deferredRequests    = _deferredRequests;
@synthesize authRequest         = _authRequest;
@synthesize authenticating      = _authenticating;
@synthesize requestQueue        = _requestQueue;

+ (NBRequestEngine *) engine {
    static NBRequestEngine *gEngine;
    if (gEngine == nil) {
        gEngine = [[self alloc] init];
    }
    
    return gEngine;
}

#pragma mark - Object lifecycle

- (id) init {
    self = [super init];
    
    if (self != nil) {
        self.authenticating     = NO;
        self.authRequest        = nil;
        self.accessToken        = nil;
        self.deferredRequests   = [NSMutableArray array];
        
        _requestQueue           = [[NSOperationQueue alloc] init];
        [_requestQueue setMaxConcurrentOperationCount:10];
    }
    
    return self;
}

- (void) dealloc {
    [self.requestQueue cancelAllOperations];
    [self.deferredRequests makeObjectsPerformSelector:@selector(cancel)];
    [self.authRequest cancel];
//    [_requestQueue release];
    
    _requestQueue           = nil;
    self.deferredRequests   = nil;
    self.authRequest        = nil;
    self.accessToken        = nil;
//    [super dealloc];
}

#pragma mark - Authenticating states

- (void) issueAuthenticateRequest {
    
}

- (BOOL) isLoggedIn {
    return YES;
}


- (BOOL) isAuthenticating {
    return NO;
}

- (BOOL) tokenExpired {
    return NO;
}

#pragma mark - ASIHTTPRequestDelegate methods

- (void)requestFinished:(NBRequest *)request {
    if (self.authRequest == request) {
        // TODO: Update and issue deferred requests.
        
        //
        [self.deferredRequests enumerateObjectsUsingBlock:^(NBRequest *request, NSUInteger idx, BOOL *stop) {
            [self.requestQueue addOperation:request];
        }];
        
        [self.deferredRequests removeAllObjects];
        self.authRequest = nil;
    }
    else {  // other requsts, forward the call to their delegates
        
    }
}


- (void)requestFailed:(NBRequest *)request {
    if (self.authRequest == request) {
        // Auth failed.
        self.authRequest = nil;
    }
    else {
        
    }
}

#pragma mark - Issue requests

- (NBRequest *) issueRequestForURL:(NSString *)url
                     objectsAndKeys:(id)object, ... {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // Extract parameters
    va_list args;
    va_start(args, object);
    
    while (object != nil) {
        NSString *key = va_arg(args, id);
        if (key != nil) {
            [parameters setObject:object forKey:key];
        }
        else {
            NSLog(@"Missing key for parameter: %@", object);
        }
        
        object = va_arg(args, id);
    }
    
    va_end(args);
    
    return [self issueRequestForURL:url
                           delegate:nil
                       asynchronous:NO
                     objectsAndKeys:parameters];
}

- (NBRequest *) issueRequestForURL: (NSString *)url
                    objectsAndKeys: (NSDictionary *)parameters
                        completion:(ASIBasicBlock)aCompletionBlock
                           failure:(ASIBasicBlock)aFaiedBlock
{
    NBRequest *request = [self issueRequestForURL:url delegate:nil asynchronous:YES objectsAndKeys:parameters];
    [request setCompletionBlock:aCompletionBlock];
    [request setFailedBlock:aFaiedBlock];
    return request;
}

- (NBRequest *) issueRequestForURL: (NSString *)url
                           delegate: (id<ASIHTTPRequestDelegate>) delegate
                     objectsAndKeys: (id) object, ... {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // Extract parameters
    va_list args;
    va_start(args, object);
    
    while (object != nil) {
        NSString *key = va_arg(args, id);
        if (key != nil) {
            [parameters setObject:object forKey:key];
        }
        else {
            NSLog(@"Missing key for parameter: %@", object);
        }
        
        object = va_arg(args, id);
    }
    
    va_end(args);
    
    return [self issueRequestForURL:url
                           delegate:delegate
                       asynchronous:YES
                     objectsAndKeys:parameters];
}

- (NBRequest *) issueRequestForURL: (NSString *)url
                           delegate: (id<ASIHTTPRequestDelegate>) delegate
                       asynchronous: (BOOL) asynchronous
                     objectsAndKeys: (NSDictionary *)parameters {
    NBRequest *request     = nil;
    NSURL *requestURL       = nil;
    NSString *urlString     = nil;
    //    NSString *serviceName   = NBRequestServiceURL[service];
    NSString *httpMethod    = [parameters objectForKey:NBRequestHTTPMethodKey];
    BOOL useHTTPGetMethod   = httpMethod == nil || ![httpMethod isEqualToString:@"POST"];
    
    if (useHTTPGetMethod) {
        urlString       = url;
        if ([[parameters allKeys] count] > 0) {
            if ([urlString rangeOfString:@"?"].location == NSNotFound) {
                urlString   = [urlString stringByAppendingFormat:@"?%@", [parameters URLQuery]];
            }
            else {
                urlString   = [urlString stringByAppendingFormat:@"&%@", [parameters URLQuery]];
            }
        }
        NSLog(@"url : %@", urlString);
        requestURL      = [NSURL URLWithString:urlString];
        request         = [ASIHTTPRequest requestWithURL:requestURL];
    }
    else {
        urlString                       = url;
        requestURL                      = [NSURL URLWithString:urlString];
        ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:requestURL];
        [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
            [formRequest setPostValue:object forKey:key];
        }];
        request                         = (NBRequest *)formRequest;
    }
    
    request.delegate        = delegate;
    request.timeOutSeconds  = NBRequestEngineDefualtTimeOut;
    request.userInfo        = [NSDictionary dictionaryWithObjectsAndKeys: nil];
    
    
    if (![self isLoggedIn] || [self tokenExpired]) {
        if (![self isAuthenticating]) {
            [self issueAuthenticateRequest];
        }
        
        [self.deferredRequests addObject:request];
    }
    else {
        if (asynchronous) {
            [self.requestQueue addOperation:request];
        }
        else {
            [request startSynchronous];
        }
        
    }
    
    return request;
}

@end
