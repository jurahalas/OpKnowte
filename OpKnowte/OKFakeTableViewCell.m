//
//  OKFakeTableViewCell.m
//  OpKnowte
//
//  Created by Olegek on 19.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFakeTableViewCell.h"

@implementation OKFakeTableViewCell

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
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
