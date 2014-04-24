//
//  OKPerformanceTableViewCell.h
//  OpKnowte
//
//  Created by Apple on 24.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKPerformanceTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *performanceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *performanceIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
