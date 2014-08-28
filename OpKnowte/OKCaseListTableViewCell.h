//
//  OKCaseListTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 28.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKCaseListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *caseName;
@property (strong, nonatomic) IBOutlet UILabel *dataLable;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;

@property (nonatomic) BOOL buttonIsTapped;

-(void) setCellBGImageLight:(int) cellCount;
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon;

- (IBAction)plusButtonTapped:(id)sender;

@end
