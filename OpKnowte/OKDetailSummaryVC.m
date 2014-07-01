//
//  OKDetailSummaryVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/13/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKDetailSummaryVC.h"
#include "OKDetailSumaryCell.h"
#import "OKProcedureTemplateVariablesModel.h"
#import "OKProcedureTemplateModel.h"
#import "OKProceduresManager.h"
#import "OKFakeTableViewCell.h"

@interface OKDetailSummaryVC ()
@property (strong, nonatomic) IBOutlet UITableView *detailSummaryTable;
@property (strong, nonatomic) NSMutableArray *keysForValues;

@end

@implementation OKDetailSummaryVC

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
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    self.detailSummaryTable.backgroundColor = [UIColor clearColor];
    
    self.detailSummaryTable.frame = CGRectMake(self.detailSummaryTable.frame.origin.x, self.detailSummaryTable.frame.origin.y+64.f, self.detailSummaryTable.frame.size.width, (self.detailSummaryTable.frame.size.height-50));
    [self addBottomTabBar];
    
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
        self.detailSummaryTable.frame = CGRectMake(self.detailSummaryTable.frame.origin.x, self.detailSummaryTable.frame.origin.y-65, self.detailSummaryTable.frame.size.width, self.detailSummaryTable.frame.size.height-50);
    }
    
    _keysForValues = [[NSMutableArray alloc] init];
    OKProceduresManager *procedureManager = [OKProceduresManager instance];
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    [procedureManager getProcedureTemplateVariablesByProcedureID:_procID handler:^(NSString *errorMsg, NSMutableArray *templateVariables) {
        
        NSLog(@"Error - %@", errorMsg);
        _keysForValues = templateVariables;
        for (int i=0; i<_keysForValues.count; i++) {
            OKProcedureTemplateVariablesModel *tempModel = _keysForValues[i];
            if ([_model valueForKey:tempModel.value]==nil) {
                [_keysForValues removeObjectAtIndex:i];
                i--;
            }
        }
        [_detailSummaryTable reloadData];
        [[OKLoadingViewController instance] hide];
        

    }];
    

}


-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}
- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _keysForValues.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FakeCellIdentifier = @"FakeCell";
    OKFakeTableViewCell *FakeCell = [[OKFakeTableViewCell alloc] init];
    
    static NSString *cellIdentifier = @"detailCell";
    OKDetailSumaryCell *cell = [[OKDetailSumaryCell alloc]init];

    if (indexPath.row < [_keysForValues count]) {
    
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[OKDetailSumaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    
    //    OKContactManager *contactsManager = [OKContactManager instance];
        OKProcedureTemplateVariablesModel *variableModel = _keysForValues[indexPath.row];
        NSString *variableValue = [[NSString alloc] init];
        if ([[[_model valueForKey:variableModel.value] class] isSubclassOfClass:[NSMutableArray class]] ) {
            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
            valuesArray = [_model valueForKey:variableModel.value];
            for (int i = 0; i < valuesArray.count; i++) {
                if ([valuesArray[i] isEqualToString:@" "]) {
                    [valuesArray removeObjectAtIndex:i];
                    i--;
                }
            }
        
            variableValue = [[_model valueForKey:variableModel.value] componentsJoinedByString:@"; "];
        } else {
            variableValue = [_model valueForKey:variableModel.value];
        }
    
    
        [cell setLabelsWithKey:variableModel.key AndValue:variableValue ];
        [tableView setContentInset:UIEdgeInsetsMake(1.0, 0.0, 0.0, 0.0)];
        return cell;
    }else {
        FakeCell = [tableView dequeueReusableCellWithIdentifier:FakeCellIdentifier forIndexPath:indexPath];
        if (!FakeCell) {
            FakeCell = [[OKFakeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FakeCellIdentifier];
        }
        return FakeCell;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
