//
//  OKCaseManager.m
//  OpKnowte
//
//  Created by Eugene on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCaseManager.h"
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
        NSLog(@"Error - %@", error);
        NSLog(@"JSON - %@", json);

        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg)
            handler(nil, [self casesFromJSON:json]);
        else
            handler(errorMsg,nil);
        
        NSLog(@"Error - %@", errorMsg);
        
    }];
}


- (void)getOngoingClinicalDetailsForCaseID:(NSString*)caseID timePointID:(NSString *)timePointID procedureID:(NSString *)procedureID  handler:(void(^)(NSString *errorMsg, OKOngoingData *ongoingData ))handler
{
    NSDictionary *params = @{@"procedureID":procedureID,
                             @"userID":[OKUserManager instance].currentUser.identifier,
                             @"caseID":caseID,
                             @"timePointID":timePointID};
   
    [self requestWithMethod:@"GET" path:@"getOngoingClinicalDetail" params:params handler:^(NSError *error, id json) {
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg){
            OKOngoingData *ongData = [OKOngoingData new];
            [ongData setModelWithDictionary:[[json objectForKey:@"clinicalData"] objectAtIndex:0]];
            handler(nil, ongData);
        }else{
            handler(errorMsg, nil);
        }
    }];
}


- (void)addOngoingClinicalDetailsForCaseID:(NSString*)caseID timePointID:(NSString *)timePointID procedureID:(NSString *)procedureID ongoingData:(OKOngoingData*)ongoingData forProcedure:(NSString*)forProcedure handler:(void(^)(NSString *errorMsg))handler;
{
    NSDictionary *params1 = @{@"procedureID":procedureID,
                             @"userID":[OKUserManager instance].currentUser.identifier,
                             @"caseID":caseID,
                             @"timePointID":timePointID};
    
    NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithDictionary:params1];
    
    if([forProcedure isEqualToString:@"1"]){
        [params2 addEntriesFromDictionary:ongoingData.twoWeeksDictionaryForSending];
    }else if([forProcedure isEqualToString:@"2"]){
        [params2 addEntriesFromDictionary:ongoingData.sixWeeksDictionaryForSending];
    }else if([forProcedure isEqualToString:@"3"]){
        [params2 addEntriesFromDictionary:ongoingData.penileDictionaryForSending];
    }else if([forProcedure isEqualToString:@"4"]){
        [params2 addEntriesFromDictionary:ongoingData.roboticDictionaryForSending];
    }else if([forProcedure isEqualToString:@"5"]){
        [params2 addEntriesFromDictionary:ongoingData.shockwaveDictionaryForSending];
    }
    
    [self requestWithMethod:@"POST" path:@"addOngoingClinicalDetail" params:params2 handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
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
