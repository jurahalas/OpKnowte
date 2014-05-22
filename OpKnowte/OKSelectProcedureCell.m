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
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView  = cellIsSelected;
    self.backgroundColor = [UIColor clearColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
-(void) setCellBGImageLight:(int) cellCount {
    UIImageView *cellBG = [[UIImageView alloc]init];
    if (cellCount%2 == 1) {
        cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellLight"]];
    } else {
        cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDark"]];
    }
    
    self.backgroundView = cellBG;
}



-(void) setCellUserIntaractionDisabled {
    
    [self setUserInteractionEnabled:NO];
    self.rightArrowCellImage.alpha = .3f;
    self.procedureLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}

-(void) setCellUserIntaractionEnabled {
    
    [self setUserInteractionEnabled:YES];
    self.rightArrowCellImage.alpha = 1.f;
    self.procedureLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    
}

@end
