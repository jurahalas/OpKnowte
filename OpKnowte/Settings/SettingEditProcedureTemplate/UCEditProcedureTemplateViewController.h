//
//  UCEditProcedureTemplateViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/8/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UCEditProcedureTemplateViewController : UIViewController
{
    IBOutlet UILabel *headerLbl_;
}

@property (nonatomic, retain) UCTemplateResponseModel *templateModel;
@property (nonatomic, retain) NSMutableArray *templateVariables;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)caseDataButtonPressed:(id)sender;
- (IBAction)indicationsButtonPressed:(id)sender;
- (IBAction)procedureButtonPressed:(id)sender;


@end
