//
//  OKLoadingViewController.h
//  OpKnowte
//
//  Created by Apple on 17.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKLoadingViewController : UIViewController

+ (OKLoadingViewController*) instance;

- (void)showWithText:(NSString*)text;
- (void)showInView:(UIView*)view withText:(NSString*)text;
- (void)hide;

@end
