//
//  OKUserManager.h
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKUserModel.h"

@interface OKUserManager : OKBaseManager

@property (nonatomic, strong) OKUserModel* currentUser;

+(OKUserManager*)instance;


-(void)signinWithEmail:(NSString*)email password:(NSString*)password handler:(void(^)(NSString *errorMsg))handler;

- (void)signupWithFirstName:(NSString*)firstName lastName:(NSString*)lastName userEmail:(NSString*)email password:(NSString*)password userTitle:(NSString*)title handler:(void(^)(NSString *errorMsg))handler;

-(void)recoverPasswordWithEmail:(NSString*)email handler:(void(^)(NSString *errorMsg))handler;

-(void)changePasswordWithUserID:(NSString*)userID password:(NSString*)password handler:(void(^)(NSString *errorMsg))handler;

- (void)updateCurrentUserFromJSON:(NSDictionary*)json;

-(void)updateDataSharingSettingsWithProcID:(NSString *)procedureID userID:(NSString *)userID isSharing:(NSString*)sharing handler:(void(^)(NSString *errorMsg))handler;

-(void)getDataSharingSettingsWithUserID:(NSString*)userID andProcID:(NSString*)procID handler:(void(^)(NSString *errorMsg, id json))handler;

-(void)logout;

@end
