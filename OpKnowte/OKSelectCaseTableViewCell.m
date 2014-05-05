//
//  OKSelectCaseTableViewCell.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectCaseTableViewCell.h"

@implementation OKSelectCaseTableViewCell

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

-(void) setCellUserIntaractionDisabled
{
    [self setUserInteractionEnabled:NO];
    self.selectCaseIcon.alpha = 0.3f;
    self.caseName.textColor = [UIColor colorWithWhite:1 alpha:.3f];
    self.dataLable.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}
-(void) setCellUserIntaractionEnabled {
    [self setUserInteractionEnabled:YES];
    self.selectCaseIcon.alpha = 1.f;
    self.caseName.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    self.dataLable.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    
}


@end
