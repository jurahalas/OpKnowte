//
//  OKBaseModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKSimpleTableItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;

+(id)itemWithTitle:(NSString*)title value:(NSString*)value;

@end

@interface OKBaseModel : NSObject

@property (nonatomic, strong) NSString *identifier;

-(void)setModelWithDictionary: (NSDictionary*) dictionary;

@end
