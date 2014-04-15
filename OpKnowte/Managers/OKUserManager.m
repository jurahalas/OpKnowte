//
//  OKUserManager.m
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKUserManager.h"

@implementation OKUserManager


+ (OKUserManager *)sharedManager
{
    static dispatch_once_t pred;
    static OKUserManager *manager = nil;
    
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    
    return manager;
}


-(void)signinWithUserName:(NSString*)userName password:(NSString*)password handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{};
    [self requestWithMethod:@"POST" path:@"/sd/login" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
    }];
}



@end
