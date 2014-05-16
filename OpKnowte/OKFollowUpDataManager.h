//
//  OKFollowUpDataManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKFollowUpDataManager : OKBaseManager
+ (OKFollowUpDataManager *)instance;
- (void)getNationalDatesByProcedureID:(NSString*) procedureID  handler:(void(^)(NSString *errorMsg, id dates))handler;
@end
