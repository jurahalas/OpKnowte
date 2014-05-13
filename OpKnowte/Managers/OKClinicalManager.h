//
//  OKClinicalManager.h
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKClinicalManager : OKBaseManager

+ (void)getOngoingClinicalDetail:(NSString *)caseID withTimePointID:(NSString *)timePointID withUserID:(NSString *)userID withProcedureID:(NSString *)procedureID  handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)getClinicalDetails:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)addOngoingClinicalDetail:(NSString *)caseID withProcedureID:(NSString *)procedureID withFragmentations:(NSString *)fragmentation withUserID:(NSString *)userID withUserComplications:(NSString *)complications handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

@end
