//
//  OKDataCaptureTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKDataCaptureTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dataCaptureLable;
@property (strong, nonatomic) IBOutlet UIImageView *dataCaptureIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
@end
