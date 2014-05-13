//
//  OKCaseManager.h
//  OpKnowte
//
//  Created by Eugene on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKCase.h"

@interface OKCaseManager : OKBaseManager

@property (nonatomic, strong) OKCase *selectedCase;

+ (OKCaseManager *)instance;

-(void)getCaseListForProcedureWithID:(NSString*)procID surgeonID:(NSString*)surgeonID handler:(void(^)(NSString *errorMsg, NSArray *cases))handler;

@end
