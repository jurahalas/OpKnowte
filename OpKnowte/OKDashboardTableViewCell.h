//
//  OKDashboardTableViewCell.h
//  OpKnowte
//
//  Created by Apple on 22.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKDashboardTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cellImage;
@property (strong, nonatomic) IBOutlet UILabel *cellName;
@property (strong, nonatomic) IBOutlet UIImageView *cellRightIcon;


-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
