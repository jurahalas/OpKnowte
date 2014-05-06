//
//  OKUserModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKUserModel.h"

@implementation OKUserModel

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties
        self.firstName = [decoder decodeObjectForKey:@"FIRSTNAME"];
        self.lastName = [decoder decodeObjectForKey:@"LASTNAME"];
        self.email = [decoder decodeObjectForKey:@"EMAILADDRESS"];
        self.password = [decoder decodeObjectForKey:@"PASSWORD"];
        self.title = [decoder decodeObjectForKey:@"TITLE"];
        self.userID = [decoder decodeObjectForKey:@"USERID"];
        self.status = [decoder decodeObjectForKey:@"status"];
    }
    return self;
}


-(void) setModelWithDictionary:(NSDictionary *)dictionary {
   
    _firstName = [dictionary valueForKey:@"FIRSTNAME"];
    _lastName = [dictionary valueForKey:@"LASTNAME"] ;
    _email = [dictionary valueForKey:@"EMAILADDRESS"];
    _password = [dictionary valueForKey:@"PASSWORD"];
    _title = [dictionary valueForKey:@"TITLE"] ;
    _userID = [dictionary valueForKey:@"USERID"] ;
    _status = [dictionary valueForKey:@"status"];
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties
    [encoder encodeObject:self.firstName forKey:@"FIRSTNAME"];
    [encoder encodeObject:self.lastName forKey:@"LASTNAME"];
    [encoder encodeObject:self.email forKey:@"EMAILADDRESS"];
    [encoder encodeObject:self.password forKey:@"PASSWORD"];
    [encoder encodeObject:self.title forKey:@"TITLE"];
    [encoder encodeObject:self.userID forKey:@"USERID"];
    [encoder encodeObject:self.status forKey:@"status"];
}

@end
