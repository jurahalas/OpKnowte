//
//  OKContactManager.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/16/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKContactManager.h"
#import "OKContactModel.h"

@implementation OKContactManager

+ (OKContactManager *)instance {
    
    static dispatch_once_t pred;
    static OKContactManager *manager = nil;
    
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    
    return manager;
    
}


-(void)addContactWithName:(NSString *)name roleID:(NSString *)roleID email:(NSString *)email steetAddress:(NSString *)streetAddress city:(NSString *)city state:(NSString *)state zip:(NSString *)zip country:(NSString *)country fax:(NSString *)fax updatedBy:(NSString *)updatedBy handler:(void(^)(NSString *errorMsg))handler
{

    NSDictionary *params = @{
                             @"roleID":         roleID,
                             @"name":           name,
                             @"emailAddress":   email,
                             @"streetAddress":  streetAddress,
                             @"city":           city,
                             @"state":          state,
                             @"zip":            zip,
                             @"country":        country,
                             @"fax":            fax,
                             @"updatedBy":      updatedBy
                             };
    
    [self requestWithMethod:@"POST" path:@"addContact" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
        
    }];
    
}

-(void)deleteContactWithContactID:(NSString *)contactID handler:(void(^)(NSString *errorMsg))handler {
    
    NSDictionary *params = @{};
    NSString *url = [NSString stringWithFormat:@"deleteContact?id=%@", contactID];
    
    [self requestWithMethod:@"DELETE" path:url params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);
    }];
    
}
-(void)getContactsByUserID:(NSString *)userID roleID:(NSString *)roleID handler:(void(^)(NSString *errorMsg, NSMutableArray *contactsArray))handler {
    
    NSDictionary *params = nil;
    NSString *url = [NSString stringWithFormat:@"getContactsByUserIDAndRoleID?userID=%@&roleID=%@", userID, roleID];
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
        NSMutableArray *contactsArray = [[NSMutableArray alloc] init];
        for (NSDictionary *contact in [json objectForKey:@"contacts"] ) {
            OKContactModel *contactModel = [[OKContactModel alloc] init];
            [contactModel setModelWithDictionary:contact];
            [contactsArray addObject:contactModel];
        }
        handler([self getErrorMessageFromJSON:json error:error], contactsArray);


    }];
}

@end
