//
//  OKSLListCell.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSLListCell.h"

@implementation OKSLListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    UIImageView *cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteCellBG"]];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundView = cellBG;
    self.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    self.selectedBackgroundView  = cellIsSelected;
    
   // [_plusButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
   // _buttonIsTapped = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)plusButtonTapped:(id)sender {
//    if (!_buttonIsTapped) {
//        [self setCellButtonBGImageWithGreenMinusIcon:YES];
//        [self.delegate addModelToList:_model];
//    } else {
//        [self setCellButtonBGImageWithGreenMinusIcon:NO];
//        [self.delegate deleteModelFromList:_model];
//    }
    NSLog(@"button tapped");
    
}
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon{
//    if (minusIcon) {
//        [_plusButton setBackgroundImage:[UIImage imageNamed:@"minusGreenIcon"] forState:UIControlStateNormal];
//    } else {
//        [_plusButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
//    }
//    _buttonIsTapped = minusIcon;
}


@end
