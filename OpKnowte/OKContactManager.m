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


-(void)addContactWithName:(NSString *)name roleID:(NSString *)roleID email:(NSString *)email steetAddress:(NSString *)streetAddress city:(NSString *)city state:(NSString *)state zip:(NSString *)zip country:(NSString *)country fax:(NSString *)fax updatedBy:(NSString *)updatedBy handler:(void(^)(NSString *errorMsg, id responseJSON))handler
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
        handler([self getErrorMessageFromJSON:json error:error], json);
        NSLog(@"%@",json);
    }];
}


-(void)deleteContactWithContactID:(NSString *)contactID handler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    NSDictionary *params = @{@"id":contactID};
    [self requestWithMethod:@"DELETE" path:@"deleteContact" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
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


+(void)doContactRequestWithRoleID:(NSString *)roleID handler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [self doContactRequestWithRoleID:roleID handler:handler];
}


+(void)getContactSettingsWithHandler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    [[OKContactManager instance]getContactSettingsWithHandler:handler];
}


-(void)getContactSettingsWithHandler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID};
    [self requestWithMethod:@"GET" path:GET_CONTACT_SETTINGS params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


-(void)doContactRequestWithRoleID:(NSString *)roleID handler:(void(^)(NSString *errorMsg, id responseJSON))handler
{
    NSDictionary *params = @{@"userID":[OKUserManager instance].currentUser.userID,
                             @"roleID":roleID};
    [self requestWithMethod:@"GET" path:GET_CONTACT_LIST params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error],json);
    }];
}


@end
