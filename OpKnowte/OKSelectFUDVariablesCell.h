//
//  OKSelectFUDVariablesCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/17/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKSelectFUDVariablesCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *variableLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightArrowCellImage;

-(void) setCellBGImageLight:(int) cellCount;
@end
