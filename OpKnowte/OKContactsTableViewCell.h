//
//  OKContactsTableViewCell.h
//  OpKnowte
//
//  Created by Apple on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKContactsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *contactsRighthIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
