//
//  OKApiClient.h
//  OpKnowte
//
//  Created by Apple on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>

#define BASE_URL @"http://knowte.esy.es/"

@interface OKApiClient : AFHTTPClient

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;


+ (OKApiClient *)sharedManager;

@end