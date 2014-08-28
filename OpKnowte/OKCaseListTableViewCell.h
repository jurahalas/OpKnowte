//
//  OKCaseListTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 28.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKCase.h"

@interface OKCaseListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *caseName;

-(void) setCellBGImageLight:(int) cellCount;

@end
