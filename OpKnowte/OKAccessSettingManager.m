//
//  OKAccessSettingManager.m
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessSettingManager.h"

@implementation OKAccessSettingManager

+ (OKAccessSettingManager *)instance
{
    static dispatch_once_t pred;
    static OKAccessSettingManager *manager = nil;
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    return manager;
}

#pragma mark - Update Access Settings

- (void)updateAccessSettingsWithUserID:(NSString *)userID withProcedureID:(NSString *)procedureID withList:(NSString *)list handler:(void(^)(NSString *errorMsg, NSDictionary * json))handler {
    
    NSDictionary *params = @{@"userID": userID,
                             @"procedureID": procedureID,
                             @"emailsID": list,
                             };
   
    [self requestWithMethod:@"POST" path:@"updateAccessSetting" params:params handler:^(NSError *error, id json) {
        
        NSLog(@"%@",json);
        
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
    
}

#pragma mark - GET ACCESS SETTING WEBSERVICE

- (void)getAccessSettingsWithUserID:(NSString *)userID AndProcedureID:(NSString *)procedureID handler:(void (^)(NSString *errorMsg, NSMutableArray *json))handler{
    
    NSDictionary *params = @{};
    
    NSString *url = [NSString stringWithFormat:@"getAccessSetting?userID=%@&procedureID=%@",userID,procedureID];
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
        NSLog(@"URL: %@",url);
        
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
}
@end
