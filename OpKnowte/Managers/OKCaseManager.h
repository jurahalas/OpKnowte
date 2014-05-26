//
//  OKCaseManager.h
//  OpKnowte
//
//  Created by Eugene on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKCase.h"
#import "OKOngoingData.h"

@interface OKCaseManager : OKBaseManager

@property (nonatomic, strong) OKCase *selectedCase;

+ (OKCaseManager *)instance;

-(void)getCaseListForProcedureWithID:(NSString*)procID surgeonID:(NSString*)surgeonID handler:(void(^)(NSString *errorMsg, NSArray *cases))handler;

- (void)getOngoingClinicalDetailsForCaseID:(NSString*)caseID timePointID:(NSString *)timePointID procedureID:(NSString *)procedureID  handler:(void(^)(NSString *errorMsg, OKOngoingData *ongoingData ))handler;

- (void)addOngoingClinicalDetailsForCaseID:(NSString*)caseID timePointID:(NSString *)timePointID procedureID:(NSString *)procedureID ongoingData:(OKOngoingData*)ongoingData forTwoWeeks:(BOOL)twoWeeks handler:(void(^)(NSString *errorMsg))handler;

@end
