//
//  OKSurgeonPerformanceDataComparisonContentCell.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/22/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSurgeonPerformanceDataComparisonContentCell.h"

@implementation OKSurgeonPerformanceDataComparisonContentCell

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
-(void) setLabelsWithData:(NSString*) data bloodLoss:(NSString*) bloodLoss sampleSize:(NSString*) sampleSize{
    
    _dataLabel.text = data;
    _bloodLossLabel.text = bloodLoss;
    _sampleSizeLabel.text = sampleSize;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

@end
