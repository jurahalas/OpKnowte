//
//  OKFacilityTableViewCell.h
//  OpKnowte
//
//  Created by Apple on 29.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKContactModel.h"

@protocol OKFacilityTableViewCellDelegate <NSObject>

-(void) addContactToSendToList:(OKContactModel*)contact;
-(void) deleteContactFromSendToList:(OKContactModel*)contact;

@end


@interface OKFacilityTableViewCell : UITableViewCell

@property (nonatomic, weak) id<OKFacilityTableViewCellDelegate>delegate;

@property (strong, nonatomic) IBOutlet UIButton *selectFacilityButton;
@property (strong, nonatomic) IBOutlet UILabel *facilityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightIcon;
@property (strong, nonatomic) OKContactModel *contact;
- (IBAction)facilityButton:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;


-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
