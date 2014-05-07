//
//  OKBaseModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@implementation OKSimpleTableItem

+(id)itemWithTitle:(NSString*)title value:(NSString*)value
{
    OKSimpleTableItem *item = [OKSimpleTableItem new];
    item.title = title;
    item.value = value;
    return item;
}

@end

@implementation OKBaseModel

-(void)setModelWithDictionary: (NSDictionary*) dictionary {
}

@end
