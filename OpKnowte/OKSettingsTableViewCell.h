//
//  OKSettingsTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKSettingsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *settingsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *settingsIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
