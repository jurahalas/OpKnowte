//
//  OKDatePicker.h
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKDatePicker : UIControl

@property (nonatomic, retain, readwrite) NSDate *minimumDate;
@property (nonatomic, retain, readwrite) NSDate *maximumDate;
@property (nonatomic, assign, readwrite) NSDate *date;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;
- (void)setTextColor:(UIColor*)textColor;

@end
