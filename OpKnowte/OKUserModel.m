//
//  OKUserModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKUserModel.h"

@implementation OKUserModel

-(void) setModelWithDictionary:(NSDictionary *)dictionary {
   
    _firstName = [dictionary valueForKey:@"FIRSTNAME"];
    _lastName = [dictionary valueForKey:@"LASTNAME"] ;
    _email = [dictionary valueForKey:@"EMAILADDRESS"];
    _password = [dictionary valueForKey:@"PASSWORD"];
    _title = [dictionary valueForKey:@"TITLE"] ;
    _userID = [dictionary valueForKey:@"USERID"] ;
    _status = [dictionary valueForKey:@"status"];

}
@end
