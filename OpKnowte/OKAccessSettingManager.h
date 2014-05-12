//
//  OKAccessSettingManager.h
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKUserManager.h"
#import "OKProcedureTemplateModel.h"
#import "OKContactModel.h"

@interface OKAccessSettingManager : OKBaseManager

+ (OKAccessSettingManager *)instance;

- (void)updateAccessSettingsWithUserID:(NSString *)userID withProcedureID:(NSString *)procedureID withList:(NSString *)list handler:(void(^)(NSString *errorMsg, NSDictionary * json))handler;

- (void)getAccessSettingsWithUserID:(NSString *)userID AndProcedureID:(NSString *)procedureID handler:(void (^)(NSString *errorMsg, NSMutableArray *json))handler;

@end
