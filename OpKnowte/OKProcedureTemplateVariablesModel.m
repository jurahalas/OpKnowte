//
//  OKProcedureTemplateVariablesModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/5/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureTemplateVariablesModel.h"

@implementation OKProcedureTemplateVariablesModel
-(void) setModelWithDictionary:(NSDictionary *)dictionary {
    
    
    NSString *key = [dictionary objectForKey:@"varKey"] ;
    key = [key stringByReplacingOccurrencesOfString:@"(" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    _ID = [dictionary objectForKey:@"id"];
    _key = [dictionary objectForKey:@"varValue"];
    _value = key ;
}
@end
