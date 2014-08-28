//
//  OKUserListTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 27.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKUserModel.h"

@protocol OKUserDelegate <NSObject>

-(void) addUserToArray:(NSString*)userID;
-(void) deleteUserFromArray:(NSString*)userID;

@end

@interface OKUserListTableViewCell : UITableViewCell

@property (nonatomic, weak) id <OKUserDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
@property (strong, nonatomic) IBOutlet UILabel *emaillabel;
@property (nonatomic) BOOL buttonIsTapped;
@property (strong, nonatomic) NSString *userID;

- (IBAction)plusButtonTapped:(id)sender;

-(void) setCellBGImageLight:(int) cellCount;
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon;

@end
