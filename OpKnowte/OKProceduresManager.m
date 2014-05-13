//
//  OKProceduresManager.m
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProceduresManager.h"
#import "OKProcedureModel.h"
#import "OKUserManager.h"
#import "OKCaseManager.h"

@implementation OKProceduresManager

+ (void)doProceduresRequest:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [[OKProceduresManager instance]doProceduresRequest:handler];
}


- (void)doProceduresRequest:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [self requestWithMethod:@"GET" path:GET_ALL_PROCEDURES params:nil handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];

}


- (void)getAllProceduresWithHandler:(void(^)(NSString *errorMsg, NSMutableArray *proceduresArray))handler
{
    [self requestWithMethod:@"GET" path:@"getAllProc" params:nil handler:^(NSError *error, id json) {
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