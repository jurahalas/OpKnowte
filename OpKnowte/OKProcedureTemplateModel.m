//
//  OKProcedureTemplateModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/5/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureTemplateModel.h"

@implementation OKProcedureTemplateModel
-(void) setModelWithDictionary:(NSDictionary *)dictionary {
    
    _templateID = [dictionary objectForKey:@"templateID"];
    _procedureID = [dictionary objectForKey:@"procedureID"];
    _caseData = [dictionary objectForKey:@"caseData"];
    _procedureText = [dictionary objectForKey:@"procedureText"];
    _indicationText = [dictionary objectForKey:@"indicationsText"];
    _aSettings = [dictionary objectForKey:@"aSettings"];
}
@end
