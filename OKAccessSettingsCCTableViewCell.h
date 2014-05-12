//
//  OKAccessSettingsCCTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OKAccessSettingsCC <NSObject>

-(void) plus;
-(void) minus;

@end

@interface OKAccessSettingsCCTableViewCell : UITableViewCell

@property (nonatomic, weak) id <OKAccessSettingsCC> delegate;

@property (strong, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)plusButtonTappet:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;
@property (nonatomic) int buttonIndetifier;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
