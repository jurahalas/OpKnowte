//
//  OKAccessSettingsCCTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKContactModel.h"

@protocol OKAccessSettingsCC <NSObject>

-(void) addContactToList: (OKContactModel*) contact;
-(void) deleteContactFromList: (OKContactModel*) contact;

@end

@interface OKAccessSettingsCCTableViewCell : UITableViewCell

@property (nonatomic, weak) id <OKAccessSettingsCC> delegate;

@property (strong, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)plusButtonTappet:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;
@property (nonatomic, strong) OKContactModel *contactModel;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon;

@end
