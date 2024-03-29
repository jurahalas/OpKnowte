//
//  OKContactManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/16/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKUserModel.h"
#import "OKLoadingViewController.h"

@interface OKContactManager : OKBaseManager

+(OKContactManager*)instance;

//-(void)addContactWithRoleID:(NSString *)roleID name:(NSString *)name email:(NSString *)email steetAddress:(NSString *)streetAddress city:(NSString *)city state:(NSString *)state zip:(NSString *)zip country:(NSString *)country fax:(NSString *)fax contactID:(NSString *)contactID  handler:(void(^)(NSString *errorMsg))handler;

-(void)addContactWithName:(NSString *)name roleID:(NSString *)roleID email:(NSString *)email steetAddress:(NSString *)streetAddress city:(NSString *)city state:(NSString *)state zip:(NSString *)zip country:(NSString *)country fax:(NSString *)fax updatedBy:(NSString *)updatedBy handler:(void(^)(NSString *errorMsg))handler;

-(void)deleteContactWithContactID:(NSString *)contactID handler:(void(^)(NSString *errorMsg))handler;
-(void)getContactsByUserID:(NSString *)userID roleID:(NSString *)roleID handler:(void(^)(NSString *errorMsg, NSMutableArray *contactsArray))handler;
-(void) getOtherContactsByUserID: (NSString*) userID handler:(void(^)(NSString *errorMsg, NSMutableArray *contactsArray))handler;
-(void) getContactInfoByRoleID: (NSString*) roleID handler:(void(^)(NSString *errorMsg, NSMutableArray *contactsArray))handler;
@end
