//
//  OKSurgicalLogsManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/12/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKSurgicalLogsManager : OKBaseManager
+ (OKSurgicalLogsManager *)instance;

- (void)getSurgeonDatesByUserID:(NSString*) userID AndProcedureID:(NSString*) procedureID  handler:(void(^)(NSString *errorMsg, id dates))handler;
- (void)getSurgeonPerformanceDataByUserID:(NSString*) userID ProcedureID:(NSString *)procedureID FromTime:(NSString *)fromDate ToTime:(NSString *)toDate FromRecordNum:(NSString *)fromCase ToRecordNum:(NSString *)toCase  handler:(void(^)(NSString *errorMsg, NSMutableArray *dataArray))handler;
@end
