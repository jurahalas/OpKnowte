
//
//  OKReminderManager.m
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKReminderManager.h"
#import "OKUserManager.h"

@implementation OKReminderManager

+ (void)getReminderSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKReminderManager instance]getReminderSettings:procedureID handler:handler];
}


+ (void)updateReminderSettingsWithProcedure:(NSString *)procedureID withPatientID:(NSString *)patientID days:(NSString *)days withList:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    [[OKReminderManager instance]updateReminderSettingsWithProcedure:procedureID withPatientID:patientID days:days withList:list handler:handler];
}


- (void)getReminderSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"procedureID":procedureID};
    [self requestWithMethod:@"GET" path:GET_REMINDER_SETTINGS params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


- (void)updateReminderSettingsWithProcedure:(NSString *)procedureID withPatientID:(NSString *)patientID days:(NSString *)days withList:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"procedureID":procedureID,
                             @"noOfDays":days,
                             @"contactIds":list,
                             @"patientID":patientID};

    [self requestWithMethod:@"POST" path:UPDATE_REMINDER_SETTINGS params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


@end
