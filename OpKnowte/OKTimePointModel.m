//
//  OKTimePointModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKTimePointModel.h"

@implementation OKTimePointModel

-(void) setModelWithDictionary:(NSDictionary *)dictionary {
    
    _timePointID = [dictionary objectForKey:@"id"];
    _timePointName = [dictionary objectForKey:@"timePointName"] ;
    
}

@end
