//
//  OKSurgeonPerformanceDataComparisonTitleCell.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/22/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSurgeonPerformanceDataComparisonTitleCell.h"

@implementation OKSurgeonPerformanceDataComparisonTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

@end
