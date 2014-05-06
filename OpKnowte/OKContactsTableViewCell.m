//
//  OKContactsTableViewCell.m
//  OpKnowte
//
//  Created by Apple on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKContactsTableViewCell.h"

@implementation OKContactsTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


-(void)awakeFromNib{
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView  = cellIsSelected;
    self.backgroundColor = [UIColor clearColor];
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
    self.contactsRighthIcon.alpha = 0.3f;
    self.contactsLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}


-(void) setCellUserIntaractionEnabled
{
    [self setUserInteractionEnabled:YES];
    self.contactsLabel.alpha = 1.f;
    self.contactsLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
}

@end