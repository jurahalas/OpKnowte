//
//  OKOperatieNoteTableViewCell.m
//  OpKnowte
//
//  Created by Olegek on 26.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOperatieNoteTableViewCell.h"

@implementation OKOperatieNoteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{

    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}
-(void) setLabels{
    self.caseDataKeyLabel.text = @"Key";
    self.caseDataValueLabel.text = @"Value";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
