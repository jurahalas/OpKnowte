//
//  OKBaseManager.m
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKApiClient.h"
#import <AFJSONRequestOperation.h>

@implementation OKBaseManager


-(NSString*)getErrorMessageFromJSON:(id)json error:(NSError*)error
{
    NSString *errorMsg = [json objectForKey:@"msg"];
    NSString *status  = [json objectForKey:@"status"];
    if([status isEqualToString:@"false"]){
        if(!errorMsg){
            errorMsg =[error localizedDescription];
        }
    }else{
        errorMsg = nil;
    }
    return errorMsg;
}


-(void)requestWithMethod:(NSString*)method path:(NSString*)path params:(NSDictionary*)params handler:(void(^)(NSError *error, id json))handler
{
    NSMutableURLRequest *r = [[OKApiClient sharedManager]requestWithMethod:method path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:r success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        handler(nil, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        handler(error, JSON);
    } ];
    [operation start];
}

@end
