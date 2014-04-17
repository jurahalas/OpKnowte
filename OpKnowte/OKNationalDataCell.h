//
//  OKNationalDataCell.h
//  OpKnowte
//
//  Created by Apple on 16.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKNationalDataCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nationalDataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *nationalDataIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;

@end
