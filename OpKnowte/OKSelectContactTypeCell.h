//
//  OKSelectContactTypeCell.h
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKSelectContactTypeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactTypeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
