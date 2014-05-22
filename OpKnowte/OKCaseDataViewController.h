//
//  OKCaseDataViewController.h
//  OpKnowte
//
//  Created by Olegek on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"
#import "OKProcedureTemplateModel.h"


@class OKProcedureTemplateModel;

@protocol OKCaseDataViewControllerDelegate <NSObject>

-(void) updateTemplateModelWith: (OKProcedureTemplateModel*) templateModel;

@end


@interface OKCaseDataViewController : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <OKCaseDataViewControllerDelegate> delegate;

@property (strong, nonatomic) OKProcedureTemplateModel *templateModel;
@property (strong, nonatomic) NSMutableArray *variablesArray;

@end
