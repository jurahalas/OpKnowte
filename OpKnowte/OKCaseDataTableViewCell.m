//
//  OKCaseDataTableViewCell.m
//  OpKnowte
//
//  Created by Olegek on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCaseDataTableViewCell.h"

@implementation OKCaseDataTableViewCell
@synthesize caseDataButton,caseDataLabel,buttonIsTapped;

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
    [caseDataButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    buttonIsTapped = NO;
    
    
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
    self.caseDataButton.alpha = 0.3f;
    self.caseDataLabel.textColor = [UIColor colorWithWhite:1 alpha:.3f];
}
-(void) setCellUserIntaractionEnabled {
    
    [self setUserInteractionEnabled:YES];
    self.caseDataButton.alpha = 1.f;
    self.caseDataLabel.textColor = [UIColor colorWithWhite:1 alpha:1.f];
    
}

- (IBAction)caseDataButton:(id)sender {
    if (!buttonIsTapped) {
        [self setCellButtonBGImageWithGreenMinusIcon:YES];
        [self.delegate addVariableToTemplate:self.variableModel];
    } else {
        [self setCellButtonBGImageWithGreenMinusIcon:NO];
        [self.delegate deleteVariableFromTemplate:self.variableModel];
    }
}
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon{
    if (minusIcon) {
        [caseDataButton setBackgroundImage:[UIImage imageNamed:@"minusGreenIcon"] forState:UIControlStateNormal];
    } else {
        [caseDataButton setBackgroundImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    }
     buttonIsTapped = minusIcon;
}
@end
