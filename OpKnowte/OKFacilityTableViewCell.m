//
//  OKFacilityTableViewCell.m
//  OpKnowte
//
//  Created by Apple on 29.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFacilityTableViewCell.h"

@implementation OKFacilityTableViewCell


-(void)awakeFromNib{
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView  = cellIsSelected;
    self.backgroundColor = [UIColor clearColor];
    [_selectFacilityButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    _buttonIsTapped = NO;
  
    
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

- (IBAction)facilityButton:(id)sender
{
    if (!_buttonIsTapped) {
        [_selectFacilityButton setBackgroundImage:[UIImage imageNamed:@"minusGreenIcon"] forState:UIControlStateNormal];
        _buttonIsTapped = YES;
        [self.delegate addContactToSendToList:self.contact];
    } else {
        [_selectFacilityButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
        _buttonIsTapped = NO;
        [self.delegate deleteContactFromSendToList:self.contact];
    }
}

-(void) setCellUserIntaractionDisabled {
    
    [self setUserInteractionEnabled:NO];
    self.selectFacilityButton.alpha = 0.3f;
    self.facilityNameLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}
-(void) setCellUserIntaractionEnabled {
    
    [self setUserInteractionEnabled:YES];
    self.selectFacilityButton.alpha = 1.f;
    self.facilityNameLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
