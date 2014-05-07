//
//  OKTemplateManager.m
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKTemplateManager.h"

@implementation OKTemplateManager

+(OKTemplateManager*)instance
{
    static dispatch_once_t pred;
    static OKTemplateManager *manager = nil;
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


- (void)getTemplate:(NSString *)sergeonID withProcedureID:(NSString *)procedureID handler:(void(^)(NSString *errorMg, OKTemplate *templateObj))handler
{
    NSDictionary *params = @{@"procedureID":procedureID,
                             @"surgeonID":sergeonID};
    [self requestWithMethod:@"GET" path:@"getTemplateBySurgeonIDAndProcedureID" params:params handler:^(NSError *error, id json) {
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg){
            OKTemplate *template = [OKTemplate new];
            [template setModelWithDictionary:json];
            handler(nil, template);
        }else
            handler(errorMsg, nil);
    }];
}


@end
