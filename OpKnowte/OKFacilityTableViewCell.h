//
//  OKFacilityTableViewCell.h
//  OpKnowte
//
//  Created by Apple on 29.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKFacilityTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *selectFacilityButton;
@property (strong, nonatomic) IBOutlet UILabel *facilityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightIcon;
- (IBAction)facilityButton:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;


-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
