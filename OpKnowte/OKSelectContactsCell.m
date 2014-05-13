//
//  OKSelectContactsCell.m
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectContactsCell.h"

@implementation OKSelectContactsCell

- (void)awakeFromNib
{
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView  = cellIsSelected;
    self.backgroundColor = [UIColor clearColor];
    [_contactButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    _buttonIsTapped = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


-(void) setCellBGImageLight:(int) cellCount
{
    UIImageView *cellBG = [[UIImageView alloc]init];
    if (cellCount%2 == 1) {
        cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellLight"]];
    } else {
        cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDark"]];
    }
    self.backgroundView = cellBG;
}

-(void) setCellUserIntaractionDisabled
{
    [self setUserInteractionEnabled:NO];
    self.contactsType.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}


-(void) setCellUserIntaractionEnabled
{
    [self setUserInteractionEnabled:YES];
    self.contactsType.textColor = [UIColor colorWithWhite:1 alpha:1.f];
}


- (IBAction)contactButton:(id)sender {
    if (!_buttonIsTapped) {
        [self setCellButtonBGImageWithGreenMinusIcon:YES];
        NSLog(@"ololol");
    } else {
        [self setCellButtonBGImageWithGreenMinusIcon:NO];
        NSLog(@"tapped");
    }
}
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon{
    if (minusIcon) {
        [_contactButton setBackgroundImage:[UIImage imageNamed:@"minusGreenIcon"] forState:UIControlStateNormal];
    } else {
        [_contactButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    }
    _buttonIsTapped = minusIcon;
}


@end
