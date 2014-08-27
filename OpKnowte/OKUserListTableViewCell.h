//
//  OKUserListTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 27.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKUserListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;

- (IBAction)plusButtonTapped:(id)sender;

-(void) setCellBGImageLight:(int) cellCount;

@end
