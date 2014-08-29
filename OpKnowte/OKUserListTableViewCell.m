//
//  OKUserListTableViewCell.m
//  OpKnowte
//
//  Created by Olegek on 27.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKUserListTableViewCell.h"

@implementation OKUserListTableViewCell

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

    [self.plusButton setImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    self.buttonIsTapped = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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

- (IBAction)plusButtonTapped:(id)sender
{
    if (!self.buttonIsTapped) {
        [self setCellButtonBGImageWithGreenMinusIcon:YES];
        [self.delegate addUserToArray:self.userID];
    } else {
        [self setCellButtonBGImageWithGreenMinusIcon:NO];
        [self.delegate deleteUserFromArray:self.userID];
    }
}


-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon{
    if (minusIcon) {
        [self.plusButton setImage:[UIImage imageNamed:@"minusGreenIcon"] forState:UIControlStateNormal];
    } else {
        [self.plusButton setImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    }
    self.buttonIsTapped = minusIcon;
}


@end
