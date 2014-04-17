//
//  OKBaseManager.m
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"


@implementation OKBaseManager

-(NSString*)getErrorMessageFromJSON:(id)json error:(NSError*)error {
    
    NSString *errorMsg = nil;
    if(error){
        errorMsg = [error localizedDescription];
    }
    return errorMsg;
    
}


-(void)requestWithMethod:(NSString*)method path:(NSString*)path params:(NSDictionary*)params handler:(void(^)(NSError *error, id json))handler {
    
    NSMutableURLRequest *r = [[OKApiClient sharedManager]requestWithMethod:method path:path parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:r success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        handler(nil, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        handler(error, JSON);
    } ];
    [operation start];
    
}

@end
