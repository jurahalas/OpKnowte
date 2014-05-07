//
//  OKCaseManager.m
//  OpKnowte
//
//  Created by Eugene on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCaseManager.h"
#import "OKCase.h"
#import "OKUserManager.h"

@implementation OKCaseManager

+ (OKCaseManager *)instance
{
    static dispatch_once_t pred;
    static OKCaseManager *manager = nil;
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


-(void)getCaseListForProcedureWithID:(NSString*)procID surgeonID:(NSString*)surgeonID handler:(void(^)(NSString *errorMsg, NSArray *cases))handler
{
    NSDictionary *params = @{@"procedureID":procID,
                             @"surgeonID":surgeonID};
    [self requestWithMethod:@"GET" path:@"getCaseByProcIDSurgeonID" params:params handler:^(NSError *error, id json) {
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg)
            handler(nil, [self casesFromJSON:json]);
        else
            handler(errorMsg,nil);
    }];
}


- (void)getOngoingClinicalDetailsForCaseID:(NSString*)caseID timePointID:(NSString *)timePointID procedureID:(NSString *)procedureID  handler:(void(^)(NSString *errorMsg, id responseJSON ))handler
{
    NSDictionary *params = @{@"procedureID":procedureID,
                             @"userID":[OKUserManager instance].currentUser.identifier,
                             @"caseID":caseID,
                             @"timePointID":timePointID};
    [self requestWithMethod:@"GET" path:@"getOngoingClinicalDetail" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
}


-(NSArray*)casesFromJSON:(id)json
{
    if ([[json class]isSubclassOfClass:[NSArray class]]) {
        NSMutableArray *cases = [NSMutableArray array];
        [json enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            OKCase *newCase = [OKCase new];
            [newCase setModelWithDictionary:obj];
            [cases addObject:newCase];
        }];
        return cases;
    }else
        return nil;
}

@end
