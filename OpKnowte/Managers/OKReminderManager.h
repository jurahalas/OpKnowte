//
//  OKReminderManager.h
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKReminderManager : OKBaseManager

+ (void)getReminderSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)updateReminderSettingsWithProcedure:(NSString *)procedureID withPatientID:(NSString *)patientID days:(NSString *)days withList:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

@end
