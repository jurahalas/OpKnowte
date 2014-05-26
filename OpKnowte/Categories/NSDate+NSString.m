//
//  NSDate+NSString.m
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "NSDate+NSString.h"

@implementation NSDate (NSString)

-(NSString*)stringWithFormat:(NSString*)format
{
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:self];
}

@end

