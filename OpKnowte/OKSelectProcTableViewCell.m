//
//  OKSelectProcTableViewCell.m
//  OpKnowte
//
//  Created by Apple on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectProcTableViewCell.h"

@implementation OKSelectProcTableViewCell

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


-(void) setCellBGImageLight:(int) cellCount
{
    UIImageView *cellBG = [[UIImageView alloc]init];
    cellBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellLight"]];
    self.backgroundView = cellBG;
}

@end
