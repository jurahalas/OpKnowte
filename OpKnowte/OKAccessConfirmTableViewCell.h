//
//  OKAccessConfirmTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKAccessConfirmTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ACLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ACIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
@end
