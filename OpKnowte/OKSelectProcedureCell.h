//
//  OKSelectProcedureCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKSelectProcedureCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *procedureLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightArrowCellImage;

-(void) setCellUserIntaractionDisabled;

@end
