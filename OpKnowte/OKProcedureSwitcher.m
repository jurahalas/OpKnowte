//
//  OKProcedureSwitcher.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureSwitcher.h"

@implementation OKProcedureSwitcher

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OKProcedureSwitcher" owner:self options:nil];
        self.view.frame = frame;
        [self setup];
    }
    return self;
}

-(void) setup{
    [self.delegate updateField:self.fieldName withBoolValue:self.customSwitcher.isOn];
}

-(void)setFieldName:(NSString*)name{
    _fieldName = name;
}
-(void)setPlaceHolder:(NSString*)placeHolder{
    _customLabel.text = placeHolder;
}

- (IBAction)switcherAction:(id)sender {
    
    [self.delegate updateField:self.fieldName withBoolValue:self.customSwitcher.isOn];
}

@end
