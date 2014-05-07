//
//  NSString+NSDate.m
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "NSString+NSDate.h"

@implementation NSString (NSDate)

- (NSDate*)dateWithFormat:(NSString*)dateFormat
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDefaultDate:[NSDate date]];
    [df setDateFormat:dateFormat];
    return [df dateFromString:self];
}

@end
