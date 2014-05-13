//
//  OKCase.m
//  OpKnowte
//
//  Created by Apple on 12.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCase.h"

@implementation OKCase

-(void) setModelWithDictionary:(NSDictionary *)dictionary
{
    _patientName = [dictionary objectForKey:@"Patient_Name"] ;
    _dateOfService = [dictionary objectForKey:@"DateOfService"];
    _detailID = [dictionary objectForKey:@"DetailID"];
    
}


@end