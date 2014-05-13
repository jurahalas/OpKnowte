//
//  OKContactManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/16/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKUserModel.h"

@interface OKContactManager : OKBaseManager

//-(void)addContactWithRoleID:(NSString *)roleID name:(NSString *)name email:(NSString *)email steetAddress:(NSString *)streetAddress city:(NSString *)city state:(NSString *)state zip:(NSString *)zip country:(NSString *)country fax:(NSString *)fax contactID:(NSString *)contactID  handler:(void(^)(NSString *errorMsg))handler;

-(void)addContactWithName:(NSString *)name roleID:(NSString *)roleID email:(NSString *)email steetAddress:(NSString *)streetAddress city:(NSString *)city state:(NSString *)state zip:(NSString *)zip country:(NSString *)country fax:(NSString *)fax updatedBy:(NSString *)updatedBy handler:(void(^)(NSString *errorMsg, id responseJSON))handler;

-(void)deleteContactWithContactID:(NSString *)contactID handler:(void(^)(NSString *errorMsg, id responseJSON))handler;

-(void)getContactsByUserID:(NSString *)userID roleID:(NSString *)roleID handler:(void(^)(NSString *errorMsg, NSMutableArray *contactsArray))handler;

+(void)doContactRequestWithRoleID:(NSString *)roleID handler:(void(^)(NSString *errorMsg, id responseJSON))handler;

+(void)getContactSettingsWithHandler:(void(^)(NSString *errorMsg, id responseJSON))handler;

@end
