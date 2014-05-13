//
//  OKSelectContactTypeCell.m
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectContactTypeCell.h"

@implementation OKSelectContactTypeCell


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
    self.rightIcon.alpha = 0.3f;
    self.contactTypeLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}


-(void) setCellUserIntaractionEnabled
{
    [self setUserInteractionEnabled:YES];
    self.rightIcon.alpha = 1.f;
    self.contactTypeLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
}


@end
