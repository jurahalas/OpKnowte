//
//  OKSelectCaseTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"


@interface OKSelectCaseTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *caseName;
@property (strong, nonatomic) IBOutlet UILabel *dataLable;
@property (strong, nonatomic) IBOutlet UIImageView *selectCaseIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
@end