//
//  OKDetailSumaryCell.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/13/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKDetailSumaryCell.h"

@implementation OKDetailSumaryCell

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


-(void) setLabelsWithKey: (NSString*) key AndValue:(NSString*) value{
    if (key != nil) {
        self.procedureKeyLabel.text = key;

    } else {
        self.procedureKeyLabel.text = @"N/A";
    }
    if (value != nil && ![value isKindOfClass:[NSNull class]] && value != NULL ) {
        self.procedureValueLabel.text = value;
    }else {
        self.procedureValueLabel.text = @"N/A";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
