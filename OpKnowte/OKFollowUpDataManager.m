//
//  OKFollowUpDataManager.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFollowUpDataManager.h"
#import "OKShockwaveLithotripsyModel.h"
#import "OKLRRadicalProstatectomyModel.h"
#import "OKLRPartialNephrectomyModel.h"
#import "OKPenileProsthesisModel.h"

@implementation OKFollowUpDataManager
+ (OKFollowUpDataManager *)instance
{
    static dispatch_once_t pred;
    static OKFollowUpDataManager *manager = nil;
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    return manager;
}


- (void)getNationalDatesByProcedureID:(NSString*) procedureID  handler:(void(^)(NSString *errorMsg, id dates))handler
{
    NSDictionary *params = @{};
    
    NSString *url = [NSString stringWithFormat:@"getNationalDates?procedureID=%@", procedureID];
    NSLog(@"%@",url);
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        id datesDictionary = [self getDatesDictionaryFrom:json];
        handler([self getErrorMessageFromJSON:json error:error], datesDictionary);
    }];
}

- (void)getNationalPerformancDataByUserID:(NSString*) userID ProcedureID:(NSString *)procedureID FromTime:(NSString *)fromDate ToTime:(NSString *)toDate handler:(void(^)(NSString *errorMsg, NSMutableArray *dataArray))handler{
    
    NSDictionary *params = @{};
    NSString *url = [NSString stringWithFormat:@"getSharedCases?userID=%@&procedureID=%@&timeFrom=%@&timeTo=%@", userID ,procedureID,fromDate, toDate];
    NSLog(@"%@",url);

    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        NSMutableArray *proceduresArray = [[NSMutableArray alloc] init];
        for (NSDictionary *procedure in [json objectForKey:@"sharedCases"]) {
            if ([procedureID  isEqualToString:@"1"]) {
                //                OKLRRadicalProstatectomyModel *procModel = [[OKLRRadicalProstatectomyModel alloc] init];
                //                [procModel setModelWithDictionary:procedure];
                //                [proceduresArray addObject:procModel];
            } else if ([procedureID  isEqualToString:@"2"]){
                OKLRPartialNephrectomyModel *procModel = [[OKLRPartialNephrectomyModel alloc] init];
                [procModel setModelWithDictionary:procedure];
                [proceduresArray addObject:procModel];
            } else if ([procedureID  isEqualToString:@"9"]){
                //                OKPenileProsthesisModel *procModel = [[OKPenileProsthesisModel alloc] init];
                //                [procModel setModelWithDictionary:procedure];
                //                [proceduresArray addObject:procModel];
            } else if ([procedureID  isEqualToString:@"10"]){
                OKShockwaveLithotripsyModel *procModel = [[OKShockwaveLithotripsyModel alloc] init];
                [procModel setModelWithDictionary:procedure];
                [proceduresArray addObject:procModel];
            }
        }
        
        handler([self getErrorMessageFromJSON:json error:error], proceduresArray);
    }];
}
- (void)getClinicalDetailsByCaseArray:(NSMutableArray *)caseArray handler:(void(^)(NSString *errorMsg, NSMutableArray *dataArray))handler{
    
    NSDictionary *params = @{};
    NSMutableArray *idArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i<caseArray.count; i++) {
        [idArray addObject:[caseArray[i] valueForKey:@"DetailID"]];
    }
    NSString *list = [idArray componentsJoinedByString:@","];
    NSString *url = [NSString stringWithFormat:@"getClinicalDetailByCaseIDs?caseIDs=%@",list];
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"clinicalData"]];
        handler([self getErrorMessageFromJSON:json error:error], dataArray);
    }];

    
}



















-(id)getDatesDictionaryFrom:(NSDictionary *)response {
    NSMutableArray *dates = [[NSMutableArray alloc]init];
    NSDictionary *dict = response;
    NSArray *arr = [dict objectForKey:@"contacts"];
    NSArray *array = [self sortCasesAccordingToDate:arr];
    
    if ((array) && ([array count] > 0)) {
        
        for (NSDictionary *dict in array) {
            NSString *str = [dict objectForKey:@"DateOfService"];
            [dates addObject:str];
        }
    } else {
        [dates removeAllObjects];
    }
    arr = nil;
    array = nil;
    return dates;
}

-(NSArray *)sortCasesAccordingToDate:(NSArray *)array{
    NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *c1, NSDictionary *c2)
                         {
                             NSString *date1 = [c1 objectForKey:@"DateOfService"];
                             NSString *date2 = [c2 objectForKey:@"DateOfService"];
                             NSDate *d1;// = [[NSDate alloc] init];
                             NSDate *d2;// = [[NSDate alloc] init];
                             NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                             [dateFormat1 setDateFormat:@"MM-dd-yyyy"];
                             d1 = [dateFormat1 dateFromString:date1];
                             d2 = [dateFormat1 dateFromString:date2];
                             return [d1 compare:d2];
                         } ];
    
    NSArray *ary = [newArray mutableCopy];
    return ary;
}

@end
