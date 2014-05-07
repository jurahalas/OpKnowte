//
//  OKTemplateManager.h
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKTemplate.h"

@interface OKTemplateManager : OKBaseManager

+(OKTemplateManager*)instance;

- (void)getTemplate:(NSString *)sergeonID withProcedureID:(NSString *)procedureID handler:(void(^)(NSString *errorMg, OKTemplate *templateObj))handler;

@end
