//
//  OKContactModel.m
//  OpKnowte
//
//  Created by Apple on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKContactModel.h"

@implementation OKContactModel


-(void) setModelWithDictionary:(NSDictionary *)dictionary
{
    _contactID = [dictionary valueForKey:@"contactID"];
    _contactRoleID = [dictionary valueForKey:@"roleID"] ;
    _contactName = [dictionary valueForKey:@"name"];
    _contactEmail = [dictionary valueForKey:@"emailAddress"];
    _contactNumber = [dictionary valueForKey:@"contactNo"] ;
    _contactStreetAddress = [dictionary valueForKey:@"streetAddress"] ;
    _contactCity = [dictionary valueForKey:@"city"];
    _contactState = [dictionary valueForKey:@"state"];
    _contactZip = [dictionary valueForKey:@"zip"];
    _contactCountry = [dictionary valueForKey:@"country"];
    _contactFax = [dictionary valueForKey:@"fax"];
}


@end
