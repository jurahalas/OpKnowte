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
        self.templateID = [dictionary objectForKey:@"templateID"];
        self.procedureID = [dictionary objectForKey:@"procedureID"];
        self.caseData = [dictionary objectForKey:@"caseData"];
        self.procedureText = [dictionary objectForKey:@"procedureText"];
        self.indicationText = [dictionary objectForKey:@"indicationsText"];
    }
    else {
        self.message = [dictionary objectForKey:@"msg"];
    }
}

@end
