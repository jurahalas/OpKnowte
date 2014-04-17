//
//  OKSelectProcedureCell.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectProcedureCell.h"
#import "OKProceduresManager.h"
#import "OKSelectProcedureViewController.h"

@implementation OKSelectProcedureCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}


-(void)awakeFromNib{
    UIImageView *cellIsNotSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBG"]];
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundView = cellIsNotSelected;
    self.selectedBackgroundView  = cellIsSelected;
    self.backgroundColor = [UIColor clearColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


-(void) setCellUserIntaractionDisabled {
    [self setUserInteractionEnabled:NO];
    self.rightArrowCellImage.image = [UIImage imageNamed:@"rightInvalid"];
    self.procedureLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}

@end
