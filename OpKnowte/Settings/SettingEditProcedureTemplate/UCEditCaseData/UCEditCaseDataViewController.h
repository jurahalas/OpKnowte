//
//  UCEditCaseDataViewController.h
//  MZUroCapture
//
//  Created by Atif Joyia on 22/05/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCEditProcedureTemplateViewController.h"

@interface UCEditCaseDataViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UILabel *headerLbl;
@property (nonatomic, retain) UCEditProcedureTemplateViewController *parent;
@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) IBOutlet UITableView *caseDataTable;
@property (nonatomic, retain) NSMutableArray *caseDataArray;


@end
