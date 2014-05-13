//
//  OKInstitutionManager.h
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKInstitutionManager : OKBaseManager

+ (void)getInstitutionSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)updateInstitutionList:(NSString *)procedureID withInstitionsList:(NSString *)list handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

@end
