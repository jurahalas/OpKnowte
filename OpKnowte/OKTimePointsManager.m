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

+ (void)getAllTimePoints:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [[OKTimePointsManager instance]getAllTimePoints:handler];
}


- (void)getAllTimePointsWithHandler:(void(^)(NSString *errorMsg,  NSArray *timePointsArray))handler
{
    [self requestWithMethod:@"GET" path:@"getAllTimePoints" params:nil handler:^(NSError *error, id json) {
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


- (void)getAllTimePoints:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [self requestWithMethod:@"GET" path:@"getAllTimePoints" params:nil handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
}

@end
