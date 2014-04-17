//
//  OKProceduresManager.m
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProceduresManager.h"
#import "OKProcedureModel.h"

@implementation OKProceduresManager


+ (OKProceduresManager *)instance
{
    static dispatch_once_t pred;
    static OKProceduresManager *manager = nil;
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    return manager;
}


- (void)getAllProceduresWithHandler:(void(^)(NSString *errorMsg, NSMutableArray *proceduresArray))handler
{
    NSDictionary *params = @{};

    [self requestWithMethod:@"GET" path:@"getAllProc" params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
       
        NSMutableArray *proceduresArray = [[NSMutableArray alloc] init];
        for (NSDictionary *procedure in json) {
            OKProcedureModel *procModel = [[OKProcedureModel alloc] init];
            [procModel setModelWithDictionary:procedure];
            [proceduresArray addObject:procModel];
        }
        handler([self getErrorMessageFromJSON:json error:error], proceduresArray);
    }];
}


@end