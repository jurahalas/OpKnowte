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


- (id) init
{
    if (self = [super init]) {
        self.currentUser = [[OKUserModel alloc]init];
    }
    return self;
}

- (void)updateCurrentUserFromJSON:(NSDictionary*)json
{
    if(!self.currentUser)
        self.currentUser = [[OKUserModel alloc]init];
    
    [self.currentUser setModelWithDictionary:[json objectForKey:@"User"]];
}

-(void)signinWithEmail:(NSString*)email password:(NSString*)password handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"email": email, @"password": password};
    [self requestWithMethod:@"POST" path:@"login" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
        self.currentUser = [OKUserModel new];
        [self.currentUser setModelWithDictionary:json];
        NSLog(@"%@",self.currentUser.firstName);
        NSLog(@"%@",self.currentUser.userID);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.currentUser.userID forKey:@"userID"];
        [defaults setObject:self.currentUser.firstName forKey:@"firstName"];
        
//        save user
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
        [defaults setObject:encodedObject forKey:@"user"];
        [defaults synchronize];
    }];
}


- (void)signupWithFirstName:(NSString*)firstName lastName:(NSString*)lastName userEmail:(NSString*)email password:(NSString*)password userTitle:(NSString*)title handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"firstName": firstName,
                             @"lastName": lastName,
                             @"email": email,
                             @"password": password,
                             @"title" :title};
    
    [self requestWithMethod:@"POST" path:@"signUpUser" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
    }];
}


-(void)recoverPasswordWithEmail:(NSString*)email handler:(void(^)(NSString *errorMsg))handler {
    
    NSDictionary *params = @{};
    NSString *url = [NSString stringWithFormat:@"getPassword?email=%@", email];
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
    }];
}


-(void)changePasswordWithUserID:(NSString*)userID password:(NSString*)password handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"userID": userID, @"password": password};
    [self requestWithMethod:@"POST" path:@"changePassword" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
        [self.currentUser setModelWithDictionary:json];
    }];
}


-(void)logout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"PASSWORD"];
    [defaults removeObjectForKey:@"EMAILADDRESS"];
    [defaults removeObjectForKey:@"userID"];
    [defaults removeObjectForKey:@"user"];
    [defaults synchronize];
    self.currentUser = nil;
}



@end
