//
//  OKBaseManager.h
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKApiClient.h"
#import <AFJSONRequestOperation.h>

@interface OKBaseManager : NSObject

-(NSString*)getErrorMessageFromJSON:(id)json error:(NSError*)error;

-(void)requestWithMethod:(NSString*)method path:(NSString*)path params:(NSDictionary*)params handler:(void(^)(NSError *error, id json))handler;

@end
