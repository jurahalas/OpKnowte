//
//  OKSendFaxManager.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/9/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSendFaxManager.h"

@implementation OKSendFaxManager
+ (OKSendFaxManager *)instance
{
    static dispatch_once_t pred;
    static OKSendFaxManager *manager = nil;
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    return manager;
}


- (void)sendFaxWithUserID:(NSString*) userID Message:(NSString*) message AndFaxNumbers:(NSString*) faxNumbers  handler:(void(^)(NSString *errorMsg, NSDictionary *json))handler
{
    NSDictionary *params = @{@"userId":     userID,
                             @"message":    message,
                             @"faxNumber":  faxNumbers
                            };
   
    [self requestWithMethod:@"POST" path:@"sendFaxByUserId" params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
       handler([self getErrorMessageFromJSON:json error:error], json);
    }];
}
@end
