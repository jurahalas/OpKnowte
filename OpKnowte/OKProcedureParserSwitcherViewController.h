//
//  OKProcedureParserSwitcherViewController.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/23/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@protocol OKProceduresParserSwitcherViewControllerDelegate <NSObject>

-(void)updateField:(NSString*)name withValue:(BOOL)newValue;

@end
@interface OKProcedureParserSwitcherViewController : UIViewController

@property (nonatomic, weak) id<OKProceduresParserSwitcherViewControllerDelegate>delegate;

-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;

@end
