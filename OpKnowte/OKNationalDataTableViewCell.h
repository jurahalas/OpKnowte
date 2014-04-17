//
//  OKNationalDataTableViewCell.h
//  OpKnowte
//
//  Created by Apple on 17.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKNationalDataTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nationalDataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *nationalDataIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;

@end