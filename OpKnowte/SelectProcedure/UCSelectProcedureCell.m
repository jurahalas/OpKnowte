//
//  UCSelectProcedureCell.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/12/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSelectProcedureCell.h"
#import "UCProcedureModel.h"
#import "UCSelectProcedureViewController.h"
@implementation UCSelectProcedureCell
@synthesize isSelected = isSelected_;
@synthesize label;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkBtnPressed:(id)sender {
    if(procedureModel.isSelected)
    {
        [_checkBtn setImage:[UIImage imageNamed:@"proceduresUnCheck.png"] forState:UIControlStateNormal];
        procedureModel.isSelected = false;
    }
    else
    {
        [_checkBtn setImage:[UIImage imageNamed:@"proceduresCheck.png"] forState:UIControlStateNormal];
        procedureModel.isSelected = true;
    }
}
-(void) loadCellContent:(UCProcedureModel*)model
{
    procedureModel = model;
    label.text = model.title;
    if(!procedureModel.isSelected)
    {
        [_checkBtn setImage:[UIImage imageNamed:@"proceduresUnCheck.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_checkBtn setImage:[UIImage imageNamed:@"proceduresCheck.png"] forState:UIControlStateNormal];
    }
}
@end
