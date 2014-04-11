//
//  OKApiClient.m
//  OpKnowte
//
//  Created by Apple on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKApiClient.h"
#import <AFJSONRequestOperation.h>
#import <AFNetworkActivityIndicatorManager.h>

@implementation OKApiClient

- (void)setUsername:(NSString *)username andPassword:(NSString *)password
{
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:username password:password];
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
        return nil;
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setParameterEncoding:AFJSONParameterEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

#pragma mark - Singleton Methods

+ (OKApiClient *)sharedManager
{
    static dispatch_once_t pred;
    static OKApiClient *_sharedManager = nil;
    
    dispatch_once(&pred, ^{ _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]]; });
    
    return _sharedManager;
}

@end

