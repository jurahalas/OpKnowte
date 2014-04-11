//
//  OKViewController.h
//  OpKnowte
//
//  Created by Eugene on 09.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKApiClient.h"

@interface OKViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *jsonButton;
- (IBAction)json:(id)sender;


@end
