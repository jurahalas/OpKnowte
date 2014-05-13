//
//  OKWebServerManager.m
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKWebServerManager.h"
#import "OKProceduresManager.h"

@implementation OKWebServerManager

+ (void)getNationalDates:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKWebServerManager instance] getNationalDates:handler];
}


+ (void)getNationalPerformancData:(NSString *)procedureID fromTime:(NSString *)fromDate toTime:(NSString *)toDate handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKWebServerManager instance] getNationalPerformancData:procedureID fromTime:fromDate toTime:toDate handler:handler];
}


+ (void)getSurgeonPerformanceData:(NSString *)procedureID fromTime:(NSString *)fromDate toTime:(NSString *)toDate fromRecordNum:(NSString *)fromCase toRecordNum:(NSString *)toCase handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKWebServerManager instance] getSurgeonPerformanceData:procedureID fromTime:fromDate toTime:toDate fromRecordNum:fromCase toRecordNum:toCase handler:handler];
}


+(void)sendFaxWithText:(NSString *)text faxNumber:(NSString *)faxNumb handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKWebServerManager instance]sendFaxWithText:text faxNumber:faxNumb handler:handler];
}


+ (void)getSurgeonDates:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKWebServerManager instance]getSurgeonDates:handler];
}


+ (void)getTemplateVariables:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKWebServerManager instance]getTemplateVariables:procedureID handler:handler];
}


+ (void)getDataSharingSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [[OKWebServerManager instance]getDataSharingSettings:procedureID handler:handler];
}


+ (void)updateDataSharingSettings:(NSString *)procedureID isSharing:(NSString *)sharing handler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [[OKWebServerManager instance]updateDataSharingSettings:procedureID isSharing:sharing handler:handler];
}


- (void)getNationalDates:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"procedureID":[OKProceduresManager instance].selectedProcedure.procedureID};
    [self requestWithMethod:@"GET" path:GET_NATIONAL_DATES params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)getNationalPerformancData:(NSString *)procedureID fromTime:(NSString *)fromDate toTime:(NSString *)toDate handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"procedureID":procedureID,
                             @"timeFrom":fromDate,
                             @"timeTo":toDate};
    [self requestWithMethod:@"GET" path:GET_NATIONAL_DATA params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)getSurgeonPerformanceData:(NSString *)procedureID fromTime:(NSString *)fromDate toTime:(NSString *)toDate fromRecordNum:(NSString *)fromCase toRecordNum:(NSString *)toCase handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"procedureID":procedureID,
                             @"timeFrom":fromDate,
                             @"timeTo":toDate,
                             @"caseNoFrom":fromCase,
                             @"caseNoTo":toCase};
    [self requestWithMethod:@"GET" path:GET_SURGEON_PERFORMANCE_DATA params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


-(void)sendFaxWithText:(NSString *)text faxNumber:(NSString *)faxNumb handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"message":text,
                             @"faxNumber":faxNumb};
    [self requestWithMethod:@"POST" path:SEND_FAX params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)getSurgeonDates:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"surgeonID":[OKUserManager instance].currentUser.userID,
                             @"procedureID":[OKProceduresManager instance].selectedProcedure.procedureID};
    [self requestWithMethod:@"GET" path:GET_SURGEON_DATES params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)getTemplateVariables:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"procedureID":procedureID};
    [self requestWithMethod:@"GET" path:GET_TEMPLATE_VARIABLES params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)getDataSharingSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"procedureID":procedureID};
    [self requestWithMethod:@"GET" path:GET_DATASHARING_SETTINGS params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)updateDataSharingSettings:(NSString *)procedureID isSharing:(NSString *)sharing handler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"isDataShared":sharing,
                             @"procedureID":procedureID};
    [self requestWithMethod:@"POST" path:UPDATE_DATASHARING_SETTINGS params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}

@end
