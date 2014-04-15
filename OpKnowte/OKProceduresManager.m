//
//  OKProceduresManager.m
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProceduresManager.h"

@implementation OKProceduresManager

+ (OKProceduresManager *)instance
{
    static dispatch_once_t pred;
    static OKProceduresManager *manager = nil;
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    
    return manager;
}


- (void)getAllProceduresWithId:(NSInteger)procedureId text:(NSString*)text abbreviation:(NSString*)abbreaviation handler:(void(^)(NSString *errorMsg))handler;
{
    NSDictionary *params = @{};

    [self requestWithMethod:@"GET" path:@"getAllProc" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
    }];
}

@end