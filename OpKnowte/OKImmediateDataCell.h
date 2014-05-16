//
//  OKImmediateDataCell.h
//  OpKnowte
//
//  Created by Apple on 16.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKImmediateDataCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *immediateDataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
