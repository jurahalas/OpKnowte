//
//  OKEditProcedureTemplateTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKEditProcedureTemplateTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *editProcedureLabel;
@property (strong, nonatomic) IBOutlet UIImageView *editProcedureIcon;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;

@end
