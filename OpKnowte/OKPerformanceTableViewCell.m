//
//  OKPerformanceTableViewCell.m
//  OpKnowte
//
//  Created by Apple on 24.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPerformanceTableViewCell.h"

@implementation OKPerformanceTableViewCell


-(void)awakeFromNib{
    UIImageView *cellIsSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellActiveBG"]];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView  = cellIsSelected;
    self.backgroundColor = [UIColor clearColor];
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
    self.performanceIcon.alpha = 0.3f;
    self.performanceLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}
-(void) setCellUserIntaractionEnabled {
    
    [self setUserInteractionEnabled:YES];
    self.performanceIcon.alpha = 1.f;
    self.performanceLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
