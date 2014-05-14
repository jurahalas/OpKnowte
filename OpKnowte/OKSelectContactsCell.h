//
//  OKSelectContactsCell.h
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKContactModel.h"
@protocol OKSelectContactsCellDelegate <NSObject>

-(void) addContactToArray:(OKContactModel*)contact;
-(void) deleteContactFromArray:(OKContactModel*)contact;

@end


@interface OKSelectContactsCell : UITableViewCell
@property (nonatomic, weak) id <OKSelectContactsCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *contactsType;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;
- (IBAction)contactButton:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;
@property (strong, nonatomic) NSMutableArray *contactIDs;
@property (strong, nonatomic) OKContactModel *contactModel;


-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end