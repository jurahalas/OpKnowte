//
//  OKFollowUpDataManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKOngoingData.h"

@interface OKFollowUpDataManager : OKBaseManager

+ (OKFollowUpDataManager *)instance;

- (void)getNationalDatesByProcedureID:(NSString*) procedureID  handler:(void(^)(NSString *errorMsg, id dates))handler;

- (void)getNationalPerformancDataByUserID:(NSString*) userID ProcedureID:(NSString *)procedureID FromTime:(NSString *)fromDate ToTime:(NSString *)toDate handler:(void(^)(NSString *errorMsg, NSMutableArray *dataArray))handler;

- (void)getClinicalDetailsByCaseArray:(NSMutableArray *)caseArray andProcedureId:(NSString*)procID  handler:(void(^)(NSString *errorMsg, NSMutableArray *dataArray))handler;

- (void)getFollowUpDataForCaseID:(NSString*)caseID timePointID:(NSString *)timePointID procedureID:(NSString *)procedureID  handler:(void(^)(NSString *errorMsg, OKOngoingData *ongoingData ))handler;

@end
