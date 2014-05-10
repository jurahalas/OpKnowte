//
//  OKLTemplateViewController.h
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"
#import "OKProcedureTemplateModel.h"

@class OKProcedureTemplateModel;

@protocol OKLTemplateViewControllerDelegate <NSObject>

-(void) updateTemplateModelWith: (OKProcedureTemplateModel*) templateModel;

@end
@interface OKLTemplateViewController : OKBaseViewController

@property (nonatomic, weak) id <OKLTemplateViewControllerDelegate> delegate;

@property (strong, nonatomic) OKProcedureTemplateModel *templateModel;
@property (strong, nonatomic) NSMutableArray *variablesArray;
@end
