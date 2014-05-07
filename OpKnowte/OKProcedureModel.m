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
    
    self.identifier = [dictionary objectForKey:@"ProcId"];
    _procedureText = [dictionary objectForKey:@"ProcText"] ;
    _procedureShortName = [dictionary objectForKey:@"ProcNick"];
}


@end
