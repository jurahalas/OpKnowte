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

@property (weak, nonatomic) IBOutlet UILabel *nationalDataLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nationalDataIcon;

-(void) setCellTitle;
-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;

@end
