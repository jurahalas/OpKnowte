//
//  UCUtility.h
//  MZUroCapture
//
//  Created by Salman Iftikhar on 5/13/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessClass.h"

@interface UCUtility : NSObject

+ (void)showBlockView;
+ (void)hideBlockView;
+ (void)showInfoAlertView:(NSString *)title withMessage:(NSString *)message;
+ (BOOL)validateEmail:(NSString *)inputText;
+ (void)setLogInUserDefault:(UCRegisterModel *)userModel;
+ (UCStatusResponseModel *)getRegistrationObj:(id)response;
+ (id)getLoginDetails:(id)response;
+ (id)getForgotPasswordDetail:(id)response;
+ (NSMutableArray *)getProceduresList:(id)response;
+ (id)getTemplateDetail:(id)response;
+ (id)getContactInfoList:(id)response;
+ (id)getContactInfoListFromDictionary:(id)response;
+ (id)getAccessList:(id)response;
+ (id)getTemplateDetailVariables:(id)response;
+ (id)getAge:(NSString *)DOB;
+ (NSString *)getCommaSeparatedString:(NSArray *)arrayOfString;
+ (id)getCaseMode:(NSMutableDictionary *)selectedCase;
+ (void)deletePDF:(NSString *)path withDelay:(int)delay;
+ (id)getEmailsArray:(NSString *)response;


@end
