//
//  OKUserManager.m
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKUserManager.h"

@implementation OKUserManager


+ (OKUserManager *)instance
{
    static dispatch_once_t pred;
    static OKUserManager *manager = nil;
    
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    
    return manager;
}


-(void)signinWithEmail:(NSString*)email password:(NSString*)password handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"email": email, @"password": password};

    
    [self requestWithMethod:@"POST" path:@"login" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
        OKUserModel *loginedUser = [[OKUserModel alloc]init];
        [loginedUser setModelWithDictionary:json];
        NSLog(@"%@",loginedUser.firstName);
    }];
}
-(void)recoverPasswordWithEmail:(NSString*)email handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{};
    NSString *url = [NSString stringWithFormat:@"getPassword?email=%@", email];
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
    }];
}

@end
