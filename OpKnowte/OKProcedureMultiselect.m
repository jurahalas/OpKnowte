//
//  OKProcedureMultiselect.m
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureMultiselect.h"

@interface OKProcedureMultiselect ()

@property (strong, nonatomic) IBOutlet UIButton *button;

@end

@implementation OKProcedureMultiselect

-(void)setPlaceHolder:(NSString*)placeHolder
{
    [super setPlaceHolder:placeHolder];
    [self.button setTitle:placeHolder forState:UIControlStateNormal];
}


-(void)updateField:(NSString*)field WithData:(NSArray*)data;
{
    if(data.count != 0){
        [self.button setTitle:[data componentsJoinedByString:@", "] forState:UIControlStateNormal];
    }else{
        [self.button setTitle:self.placeHolder forState:UIControlStateNormal];
    }
    [self.delegate updateField:field withData:data];
}


-(BOOL)becomeFirstResponder
{
    [self buttonTapped:nil];
    return YES;
}


- (IBAction)buttonTapped:(id)sender
{
    [self.delegate showMultiselectVCForFieldWithName:self.fieldName withData:self.dataArray sender:self];
}

@end
