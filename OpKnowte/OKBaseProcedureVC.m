//
//  OKBaseProcedureVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseProcedureVC.h"
#import "OKProcedureTextField.h"


@interface OKBaseProcedureVC () <OKProcedureTextFieldDelegate>

@property (nonatomic, strong) NSArray *interactionItems;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation OKBaseProcedureVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - OKProceduresParserTextFieldViewControllerDelegate

-(void)updateField:(NSString*)name withValue:(NSString*)newValue
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
