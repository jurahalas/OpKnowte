//
//  OKInstitutionManager.m
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKInstitutionManager.h"
#import "OKUserManager.h"

@implementation OKInstitutionManager

+ (void)getInstitutionSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [self getInstitutionSettings:procedureID handler:handler];
}


+ (void)updateInstitutionList:(NSString *)procedureID withInstitionsList:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKInstitutionManager instance]updateInstitutionList:procedureID withInstitionsList:list handler:handler];
}


- (void)getInstitutionSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID};
    [self requestWithMethod:@"GET" path:GET_INSTITUTION_SETTINGS params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)updateInstitutionList:(NSString *)procedureID withInstitionsList:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"contactID":list,
                             @"procedureID":procedureID};
    [self requestWithMethod:@"POST" path:@"updateInstitutionsSetting" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}
@end
