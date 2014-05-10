//
//  OKAccessSettingsCCTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKAccessSettingsCCTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)plusButtonTappet:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
@end
