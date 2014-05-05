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
@property (strong, nonatomic) NSString *placeHolder;

@end

@implementation OKProcedureMultiselect

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"OKProcedureMultiselect" owner:self options:nil];
        self.frame = frame;
        [self addSubview:self.view];
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self setup];
    }
    return self;
}


-(void) setup
{
}


-(void)setPlaceHolder:(NSString*)placeHolder
{
    _placeHolder = placeHolder;
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


- (IBAction)buttonTapped:(id)sender
{
    [self.delegate showMultiselectVCForFieldWithName:self.fieldName withData:self.dataArray sender:self];
}

@end
