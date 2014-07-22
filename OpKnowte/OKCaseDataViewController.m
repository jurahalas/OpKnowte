//
//  OKCaseDataViewController.m
//  OpKnowte
//
//  Created by Olegek on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCaseDataViewController.h"
#import "OKCaseDataTableViewCell.h"

@interface OKCaseDataViewController () <OKCaseDataTableViewCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *caseDataTableView;
@property (strong, nonatomic) NSMutableArray *choosedVariables;
@end

@implementation OKCaseDataViewController
@synthesize caseDataTableView;

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    caseDataTableView.backgroundColor = [UIColor clearColor];
    self.caseDataTableView.dataSource = self;
    self.caseDataTableView.delegate = self;
    caseDataTableView.frame = CGRectMake(caseDataTableView.frame.origin.x, caseDataTableView.frame.origin.y, caseDataTableView.frame.size.width, (caseDataTableView.frame.size.height - 51.f));
    
    
    _choosedVariables = [NSMutableArray arrayWithArray:[_templateModel.caseData componentsSeparatedByString:@","]];
    [caseDataTableView reloadData];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTemplateModelWith:_templateModel];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _variablesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) addVariableToTemplate:(OKProcedureTemplateVariablesModel *)contact{
    NSMutableArray *choosedModelsArray = [[NSMutableArray alloc] init];
    choosedModelsArray = [self addValueOfModel:contact toArray:YES];
    NSString *newCaseData = [choosedModelsArray componentsJoinedByString:@","];
    _templateModel.caseData = newCaseData;
}


-(void) deleteVariableFromTemplate:(OKProcedureTemplateVariablesModel *)contact{
    NSMutableArray *choosedModelsArray = [[NSMutableArray alloc] init];
    choosedModelsArray = [self addValueOfModel:contact toArray:NO];
    NSString *newCaseData =[choosedModelsArray componentsJoinedByString:@","];
    _templateModel.caseData = newCaseData;
}


-(NSMutableArray*) addValueOfModel:(OKProcedureTemplateVariablesModel *)contact toArray: (BOOL) add{
    
    NSMutableArray *choosedModelsArray = [[NSMutableArray alloc] init];
    for (OKProcedureTemplateVariablesModel *model in _variablesArray) {
        if ([_choosedVariables containsObject:[NSString stringWithFormat:@"(%@)",model.value]]) {
            [choosedModelsArray addObject:model];
        }
    }
    if (choosedModelsArray.count) {
        int choosedModelArrayCount = choosedModelsArray.count;
        for (int i = 0; i<choosedModelsArray.count; i++) {
            OKProcedureTemplateVariablesModel *model = (OKProcedureTemplateVariablesModel*)choosedModelsArray[i];
            int modelID = (int)model.ID;
            int contactID = (int)contact.ID;
            if (add) {
                if (modelID < contactID ) {
                    [choosedModelsArray insertObject:contact atIndex:i+1];
                    break;
                }
            } else {
                if (modelID == contactID ) {
                    [choosedModelsArray removeObjectAtIndex:i];
                    break;
                }
            }
        }
        if (choosedModelArrayCount == choosedModelsArray.count) {
            [choosedModelsArray addObject:contact];
        }

    } else {
        [choosedModelsArray addObject:contact];
    }

    [_choosedVariables removeAllObjects];
    for (OKProcedureTemplateVariablesModel *model in choosedModelsArray) {
        [_choosedVariables addObject:[NSString stringWithFormat:@"(%@)",model.value]];
    }
    
    return _choosedVariables;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    OKCaseDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKCaseDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    OKProcedureTemplateVariablesModel *varModel = [[OKProcedureTemplateVariablesModel alloc] init];
    varModel = (OKProcedureTemplateVariablesModel*)_variablesArray[indexPath.row];
    cell.caseDataLabel.text = varModel.key;
    cell.variableModel = varModel;
    NSLog(@"%hhd", [_choosedVariables containsObject:[NSString stringWithFormat:@"(%@)",varModel.value]]);
    [cell setCellButtonBGImageWithGreenMinusIcon:[_choosedVariables containsObject:[NSString stringWithFormat:@"(%@)",varModel.value]]];
    cell.delegate = self;
    [cell setCellBGImageLight:indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
