//
//  OKUserManager.h
//  OpKnowte
//
//  Created by Eugene on 11.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKUserManager : OKBaseManager

+(OKUserManager*)instance;

-(void)signinWithUserName:(NSString*)userName password:(NSString*)password handler:(void(^)(NSString *errorMsg))handler;

@end