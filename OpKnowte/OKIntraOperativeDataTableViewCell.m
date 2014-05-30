//
//  OKIntraOperativeDataTableViewCell.m
//  OpKnowte
//
//  Created by Olegek on 15.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKIntraOperativeDataTableViewCell.h"

@implementation OKIntraOperativeDataTableViewCell

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
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)plusButtonTapped:(id)sender {
    [self.delegate openSummaryViewWithModel:self.model];
    NSLog(@"button tapped");
}


@end
