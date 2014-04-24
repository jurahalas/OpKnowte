//
//  OKProcedureTextField.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureTextField.h"

@implementation OKProcedureTextField

- (id)initWithFrame:(CGRect)frame
{
    if(nil == (self = [super initWithFrame:frame]))
        return nil;
    [[NSBundle mainBundle] loadNibNamed:@"OKProcedureTextField" owner:self options:nil];
    [self setup];
    return self;
}


- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(nil == (self = [super initWithCoder:aDecoder]))
        return nil;
    [[NSBundle mainBundle] loadNibNamed:@"OKProcedureTextField" owner:self options:nil];
    [self setup];
    return self;
}
-(void) setup{
    _customTextField.text = @"";
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text];
}
-(void)setFieldName:(NSString*)name
{
    _fieldName = name;
}
-(void)setPlaceHolder:(NSString*)placeHolder{
    _customTextField.placeholder = placeHolder;
}
-(void)setType:(enum OKProcedureTextFieldType)type{
    if (OKProcedureSymbolicTF) {
        _customTextField.keyboardType = UIKeyboardTypeDefault;
    } else {
        _customTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
