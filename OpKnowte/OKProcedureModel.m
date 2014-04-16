//
//  OKProcedureModel.m
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureModel.h"

@implementation OKProcedureModel

-(void) setModelWithDictionary:(NSDictionary *)dictionary {
    
    _procedureID = [dictionary valueForKey:@"PROCEDURE_ID"];
    _procedureText = [dictionary valueForKey:@"PROCEDURE_TEXT"] ;
    _procedureShortName = [dictionary valueForKey:@"PROCEDURE_NICK"];
    
}


@end
