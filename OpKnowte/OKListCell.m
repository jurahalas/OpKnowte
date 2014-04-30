//
//  OKListCell.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/25/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKListCell.h"

@implementation OKListCell

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
    [_plusButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    _buttonIsTapped = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)plusButtonTapped:(id)sender {
    if (!_buttonIsTapped) {
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"minusGreenIcon"] forState:UIControlStateNormal];
        _buttonIsTapped = YES;
    } else {
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
        _buttonIsTapped = NO;
    }
    
}
@end
