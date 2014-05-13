//
//  NSObject+CONSTANTS.m
//  MZUroCapture
//
//  Created by Salman Iftikhar on 5/13/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "CONSTANTS.h"

@implementation CONSTANTS

+ (NSString*)GetUrl:(NSString*)neededUrl {
    return [NSString stringWithFormat:@"%@%@", BASEURL, neededUrl];
}

@end
