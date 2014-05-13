//
//  OKSelectContactsCell.h
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKContactModel.h"

@interface OKSelectContactsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactsType;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;
- (IBAction)contactButton:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;
@property (strong, nonatomic) NSMutableArray *contactIDs;


-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end