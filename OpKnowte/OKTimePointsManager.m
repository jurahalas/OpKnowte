//
//  OKTimePointsManager.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKTimePointsManager.h"
#import "OKTimePointModel.h"

@implementation OKTimePointsManager

+ (OKTimePointsManager *)instance
{
    static dispatch_once_t pred;
    static OKTimePointsManager *manager = nil;
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    return manager;
}


- (void)getAllTimePointsWithHandler:(void(^)(NSString *errorMsg, NSMutableArray *timePointsArray))handler
{
    NSDictionary *params = @{};
    
    [self requestWithMethod:@"GET" path:@"getAllTimePoints" params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
        NSMutableArray *timePointsArray = [[NSMutableArray alloc] init];
        for (NSDictionary *timePoint in [json objectForKey:@"timePoints"] ) {
            OKTimePointModel *timePointModel = [[OKTimePointModel alloc] init];
            [timePointModel setModelWithDictionary:timePoint];
            [timePointsArray addObject:timePointModel];
        }
        handler([self getErrorMessageFromJSON:json error:error], timePointsArray);
    }];
}

@end
