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


-(void) setLabelsWithKey: (NSString*) key AndValue:(NSString*) value
{
    self.caseDataKeyLabel.text = key;
    self.caseDataValueLabel.text = value;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
