//
//  OKTemplateTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKTemplateTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *templateLable;
@property (strong, nonatomic) IBOutlet UIImageView *templateIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
@end
