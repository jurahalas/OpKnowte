//
//  OKNationalDataCell.m
//  OpKnowte
//
//  Created by Apple on 16.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKNationalDataCell.h"

@implementation OKNationalDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void) setCellTitle{
    self.nationalDataLabel.text = @"ololo";
    
}
-(void) setCellUserIntaractionDisabled {
    [self setUserInteractionEnabled:NO];
    self.nationalDataIcon.image = [UIImage imageNamed:@"rightInvalid"];
    self.nationalDataLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
    
}
-(void) setCellUserIntaractionEnabled {
    [self setUserInteractionEnabled:YES];
    self.nationalDataIcon.image = [UIImage imageNamed:@"right"];
    self.nationalDataLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    
}


@end
