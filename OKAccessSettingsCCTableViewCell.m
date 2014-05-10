//
//  OKAccessSettingsCCTableViewCell.m
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessSettingsCCTableViewCell.h"

@implementation OKAccessSettingsCCTableViewCell
@synthesize plusButton,buttonIsTapped;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView  = cellIsSelected;
    self.backgroundColor = [UIColor clearColor];
    
    [plusButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    buttonIsTapped = NO;
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
    self.contactNameLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}
-(void) setCellUserIntaractionEnabled {
    
    [self setUserInteractionEnabled:YES];
    self.contactNameLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon{
    if (minusIcon) {
        [plusButton setBackgroundImage:[UIImage imageNamed:@"minusGreenIcon"] forState:UIControlStateNormal];
    } else {
        [plusButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    }
    buttonIsTapped = minusIcon;
}

- (IBAction)plusButtonTappet:(id)sender {
    if (!buttonIsTapped) {
        [self setCellButtonBGImageWithGreenMinusIcon:YES];
        [self.delegate addVariableToTemplate:self.variableModel];
    } else {
        [self setCellButtonBGImageWithGreenMinusIcon:NO];
        [self.delegate deleteVariableFromTemplate:self.variableModel];
    }
}
@end
