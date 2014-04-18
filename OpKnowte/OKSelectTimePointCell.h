//
//  OKSelectTimePointCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"
@interface OKSelectTimePointCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *timePointLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightArrowCellImage;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;


@end
