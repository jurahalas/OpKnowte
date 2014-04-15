//
//  OKCustomTextField.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKCustomTextField : UITextField
-(void) setCustomTextFieldPlaceholder: (NSString*) placeholder Secured:(BOOL) secured DownArrow:(BOOL) downArrow;
@end
