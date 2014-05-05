//
//  OKProcedureSwitcher.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureSwitcher.h"

@implementation OKProcedureSwitcher

-(void) setup{
    [self.delegate updateField:self.fieldName withBoolValue:self.customSwitcher.isOn];
}


-(void)setPlaceHolder:(NSString*)placeHolder
{
    [super setPlaceHolder:placeHolder];
    _customLabel.text = placeHolder;
}


- (IBAction)switcherAction:(id)sender {
    
    [self.delegate updateField:self.fieldName withBoolValue:self.customSwitcher.isOn];
}

@end
