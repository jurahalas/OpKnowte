
//
//  OKClinicalManager.m
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKClinicalManager.h"

@implementation OKClinicalManager


+ (void)getOngoingClinicalDetail:(NSString *)caseID withTimePointID:(NSString *)timePointID withUserID:(NSString *)userID withProcedureID:(NSString *)procedureID  handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKClinicalManager instance] getOngoingClinicalDetail:caseID withTimePointID:timePointID withUserID:userID withProcedureID:procedureID handler:handler];
}


+ (void)getClinicalDetails:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKClinicalManager instance]getClinicalDetails:list handler:handler];
}


+ (void)addOngoingClinicalDetail:(NSString *)caseID withProcedureID:(NSString *)procedureID withFragmentations:(NSString *)fragmentation withUserID:(NSString *)userID withUserComplications:(NSString *)complications handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKClinicalManager instance]addOngoingClinicalDetail:caseID withProcedureID:procedureID withFragmentations:fragmentation withUserID:userID withUserComplications:complications handler:handler];
}


- (void)getOngoingClinicalDetail:(NSString *)caseID withTimePointID:(NSString *)timePointID withUserID:(NSString *)userID withProcedureID:(NSString *)procedureID  handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"procedureID":procedureID,
                             @"userID":userID,
                             @"caseID":caseID,
                             @"timePointID":timePointID};
    [self requestWithMethod:@"GET" path:@"getOngoingClinicalDetail" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
}


- (void)getClinicalDetails:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"caseIDs":list};
    [self requestWithMethod:@"GET" path:GET_CLINICAL_DETAIL params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
}


- (void)addOngoingClinicalDetail:(NSString *)caseID withProcedureID:(NSString *)procedureID withFragmentations:(NSString *)fragmentation withUserID:(NSString *)userID withUserComplications:(NSString *)complications handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":userID,
                             @"caseID":caseID,
                             @"procedureID":procedureID,
                             @"fragmentation":fragmentation,
                             @"postComplications":complications};
    [self requestWithMethod:@"POST" path:ADD_ONGOING_CLINICAL_DETAIL params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
    
}
@end
