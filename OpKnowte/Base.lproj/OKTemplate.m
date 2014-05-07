//
//  OKTemplate.m
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKTemplate.h"

@implementation OKTemplate

-(void)setModelWithDictionary: (NSDictionary*) dictionary
{
    self.status = [dictionary objectForKey:@"status"];
    
    if ([self.status isEqualToString:@"true"]) {
        self.templateID = [templateDict objectForKey:@"templateID"];
        self.procedureID = [templateDict objectForKey:@"procedureID"];
        self.caseData = [templateDict objectForKey:@"caseData"];
        self.procedureText = [templateDict objectForKey:@"procedureText"];
        self.indicationText = [templateDict objectForKey:@"indicationsText"];
    }
    else {
        self.message = [templateDict objectForKey:@"msg"];
    }
}

@end
