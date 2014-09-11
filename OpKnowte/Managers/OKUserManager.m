//
//  OKUserManager.m
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKUserManager.h"
#import "OKLoadingViewController.h"


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
        self.currentUser.password = password;
        NSLog(@"%@",self.currentUser.firstName);
        NSLog(@"%@",self.currentUser.identifier);
        NSLog(@"%@",self.currentUser.email);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
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
        self.currentUser = [OKUserModel new];
        [self.currentUser setModelWithDictionary:json];
        self.currentUser.firstName = firstName;
        self.currentUser.password = password;
        self.currentUser.email = email;

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        //        save user
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
        [defaults setObject:encodedObject forKey:@"user"];
        [defaults synchronize];
        
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
    NSDictionary *params = @{@"userID": userID,
                             @"password": password};
    [self requestWithMethod:@"POST" path:@"changePassword" params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg){
            self.currentUser.password = password;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

            //        save user
            NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
            [defaults setObject:encodedObject forKey:@"user"];
            [defaults synchronize];
        }
        
        handler(errorMsg);
    }];
}

#pragma mark - Data Share

-(void)updateDataSharingSettingsWithProcID:(NSString *)procedureID userID:(NSString *)userID isSharing:(NSString*)sharing handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"procedureID": procedureID,
                             @"userID": userID,
                             @"isDataShared": sharing};
    [self requestWithMethod:@"POST" path:@"updateDataShareSetting" params:params handler:^(NSError *error, id json){
    
        NSLog(@"%@",json);
        
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg){
            
        }
        handler(errorMsg);
    }];
}

-(void)getDataSharingSettingsWithUserID:(NSString*)userID andProcID:(NSString*)procID handler:(void(^)(NSString *errorMsg, id json))handler
{
    NSDictionary *params = @{};
    NSString *url = [NSString stringWithFormat:@"getDataShareSetting?userID=%@&procedureID=%@", userID, procID];

    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json){
        NSLog(@"%@",json);
        
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg){
        
        }
        handler(errorMsg, json);
    }];
 
}


-(void)logout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user"];
    [defaults synchronize];
    self.currentUser = nil;
}


-(void)getUserAccess:(NSString *)procedureID handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"emailId":[OKUserManager instance].currentUser.email,
                             @"procedureID":procedureID};
    [self requestWithMethod:@"GET" path:@"getUsersAccess" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
    }];
}


-(void)searchUserByKeyword:(NSString*)keyword AndPage:(NSString*)page Count:(NSString*)count handler:(void (^)(NSString *errorMsg, NSMutableArray *users))handler
{
    NSString *url = [NSString stringWithFormat:@"getPaginatedUserByKeyword?keyword=%@&page=%@&count=%@",keyword,page,count];
    [self requestWithMethod:@"GET" path:url params:nil handler:^(NSError *error, id json){
        NSLog(@"%@",json);
        handler ([self getErrorMessageFromJSON:json error:error],json);
    }];
}


-(void)shareProcedureWithCaseID:(NSString*)caseID andProcedureID:(NSString*)procID andUsersIDs:(NSString*)usersIDs handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"caseID":caseID,
                             @"procedureID":procID,
                             @"userIDs":usersIDs};
    [self requestWithMethod:@"POST" path:@"shareProcedure" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
    }];
}


-(void)unshareProcedureWithCaseID:(NSString*)caseID andProcedureID:(NSString*)procID andUsersIDs:(NSString*)usersIDs handler:(void(^)(NSString *errorMsg))handler
{
    NSDictionary *params = @{@"caseID":caseID,
                             @"procedureID":procID,
                             @"userIDs":usersIDs};
    [self requestWithMethod:@"POST" path:@"unshareProcedure" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
    }];
}

@end
