//
//  OKDetailSumaryCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/13/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKDetailSumaryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *procedureKeyLabel;
@property (strong, nonatomic) IBOutlet UILabel *procedureValueLabel;

-(void) setLabelsWithKey: (NSString*) key AndValue:(NSString*) value;

@end
