//
//  OKOperatieNoteViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOperatieNoteViewController.h"
#import "OKFacilityVC.h"
#import "OKProceduresManager.h"

#import "OKShockwaveLithotripsyModel.h"
#import "OKLRPartialNephrectomyModel.h"
#import "OKProcedureTemplateModel.h"
#import "OKProcedureTemplateVariablesModel.h"
#import "OKContactManager.h"
#import "OKContactModel.h"

@interface OKOperatieNoteViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UIView *segmentControllView;
@property (strong, nonatomic) IBOutlet UITableView *caseDataTableView;
@property (strong, nonatomic) IBOutlet UIView *IndicationView;
@property (strong, nonatomic) IBOutlet UILabel *indicationLabel;
@property (strong, nonatomic) IBOutlet UIView *procedureView;
@property (strong, nonatomic) IBOutlet UILabel *procedureLable;
@property (strong, nonatomic) IBOutlet UIScrollView *indicationScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *procedureScrollView;

@property (strong, nonatomic) NSMutableArray *keysForValues;
@property (strong, nonatomic) NSMutableArray *caseDataValues;


@property (strong, nonatomic) IBOutlet UIView *saveButtonView;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) NSMutableDictionary *templateDictionary;
@property (strong, nonatomic) NSMutableArray *caseDataArray;

@property (strong, nonatomic) IBOutlet UIView *segmentedControllView;

@property (strong, nonatomic) OKProcedureTemplateModel *templateModel;
@end

@implementation OKOperatieNoteViewController
@synthesize segmentControl,caseDataTableView,IndicationView,indicationLabel,procedureView,procedureLable,indicationScrollView,procedureScrollView,segmentControllView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    _keysForValues = [[NSMutableArray alloc] init];
    _caseDataValues =[[NSMutableArray alloc] init];
    _caseDataArray =[[NSMutableArray alloc] init];
    _templateDictionary = [[NSMutableDictionary alloc] init];
    
    OKProceduresManager *procedureManager = [OKProceduresManager instance];
    
    [procedureManager getProcedureTemplateVariablesByProcedureID:[NSString stringWithFormat:@"%d", _procedureID] handler:^(NSString *errorMsg, NSMutableArray *templateVariables) {
        
        NSLog(@"Error - %@", errorMsg);
        _keysForValues = templateVariables;
        [procedureManager getProcedureTemplateByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:[NSString stringWithFormat:@"%d", _procedureID] handler:^(NSString *errorMsg, NSDictionary *template) {
            NSLog(@"Error - %@", errorMsg);
            _templateModel = [[OKProcedureTemplateModel alloc] init];
            [_templateModel  setModelWithDictionary:template];
            
            
            NSString *tempStr =  _templateModel.caseData;
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@")" withString:@""];
            
            
            NSMutableArray *selectedCaseDataArray = [NSMutableArray arrayWithArray:[tempStr componentsSeparatedByString:@","]];
            
            for (NSString *str in selectedCaseDataArray) {
                
                for (OKProcedureTemplateVariablesModel *allKeys in self.keysForValues) {
                    
                    if ([str isEqualToString:allKeys.value]) {
                        
                        OKProcedureTemplateVariablesModel *tempModel = [[OKProcedureTemplateVariablesModel alloc]init];
                        
                        tempModel.key = allKeys.key;
                        tempModel.value = allKeys.value;
                        
                        [self.caseDataValues addObject:tempModel];
                        tempModel = nil;
                        break;
                    }
                }
            }
            
            
            [self.caseDataTableView reloadData];
            [self indicationMethod];
            [self procedureMethod];
            [[OKLoadingViewController instance] hide];
            
        }];
    }];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    segmentControllView.backgroundColor = [UIColor clearColor];
    _saveButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _saveButton.layer.cornerRadius = 14;
    _saveButton.clipsToBounds = YES;
    _saveButtonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segmentControllBG.png"]];
    
    [self.segmentControllView addSubview:backgroundView];
    
    caseDataTableView.backgroundColor = [UIColor clearColor];
    
    self.caseDataTableView.dataSource = self;
    self.caseDataTableView.delegate = self;
    
    caseDataTableView.frame = CGRectMake(caseDataTableView.frame.origin.x, caseDataTableView.frame.origin.y, caseDataTableView.frame.size.width, (caseDataTableView.frame.size.height - 60.f));
    
    [self.caseDataTableView reloadData];
    
    self.caseDataTableView.hidden = NO;
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    
    self.segmentedControllView.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.segmentedControllView.backgroundColor = [UIColor clearColor];
    
    [self .segmentControl setSelectedSegmentIndex:0];
    
    for (UIControl *subview in [segmentControl subviews]) {
        
        if ([subview isSelected]){
            [subview setTintColor:[UIColor colorWithRed: 255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
        }
    }
    
    [self.segmentControl setDividerImage:[UIImage imageNamed:@"scSeparator"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)indicationMethod{
    
    IndicationView.backgroundColor = [UIColor clearColor];
    
    
    NSString *indicationText = _templateModel.indicationText;
    
    for (OKProcedureTemplateVariablesModel *allKeys in self.keysForValues) {
        
        NSString *variableValue = [[NSString alloc] init];
        if ([[[_model valueForKey:allKeys.value] class] isSubclassOfClass:[NSMutableArray class]] ) {
            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
            valuesArray = [_model valueForKey:allKeys.value];
            for (int i = 0; i < valuesArray.count; i++) {
                if ([valuesArray[i] isEqualToString:@" "]) {
                    [valuesArray removeObjectAtIndex:i];
                    i--;
                }
            }
            
            variableValue = [[_model valueForKey:allKeys.value] componentsJoinedByString:@"; "];
        } else {
            variableValue = [_model valueForKey:allKeys.value];
        }
        if (variableValue != nil) {
            indicationText = [indicationText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];
        } else {
            indicationText = [indicationText stringByReplacingOccurrencesOfString:allKeys.value withString:@" "];
        }
    }
    
    indicationLabel.text = indicationText;
    NSString *indicationString = [indicationText stringByReplacingOccurrencesOfString:@"(" withString:@""];
    indicationString = [indicationString stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    [_templateDictionary setObject:indicationString forKey:@"indicationText"];
    
    [indicationLabel sizeToFit];
    indicationScrollView.contentSize = CGSizeMake(indicationScrollView.contentSize.width, indicationLabel.frame.size.height+80);
    [indicationScrollView addSubview:indicationLabel];
    [self.IndicationView addSubview:indicationScrollView];
    
}

-(void)procedureMethod{
    
    procedureView.backgroundColor = [UIColor clearColor];
    NSString * procedureText = _templateModel.procedureText;
    
    for (OKProcedureTemplateVariablesModel *allKeys in self.keysForValues) {
        
        NSString *variableValue = [[NSString alloc] init];
        if ([[[_model valueForKey:allKeys.value] class] isSubclassOfClass:[NSMutableArray class]] ) {
            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
            valuesArray = [_model valueForKey:allKeys.value];
            for (int i = 0; i < valuesArray.count; i++) {
                if ([valuesArray[i] isEqualToString:@" "]) {
                    [valuesArray removeObjectAtIndex:i];
                    i--;
                }
            }
            
            variableValue = [[_model valueForKey:allKeys.value] componentsJoinedByString:@"; "];
        } else {
            variableValue = [_model valueForKey:allKeys.value];
        }
        if (variableValue != nil) {
            procedureText = [procedureText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];
        } else {
            procedureText = [procedureText stringByReplacingOccurrencesOfString:allKeys.value withString:@" "];
        }
    }
    
    
    procedureLable.text = procedureText;
    
    NSString *procedureString = [procedureText stringByReplacingOccurrencesOfString:@"(" withString:@""];
    procedureString = [procedureString stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    [_templateDictionary setObject:procedureString forKey:@"procedureText"];
    
    [procedureLable sizeToFit];
    procedureScrollView.contentSize = CGSizeMake(procedureScrollView.contentSize.width, procedureLable.frame.size.height+80);
    [procedureScrollView addSubview:procedureLable];
    [self.procedureView addSubview:procedureScrollView];
    
}

#pragma mark IBAction

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentControlButton:(UISegmentedControl *)sender {
    UIColor *selectedColor = [UIColor colorWithRed: 255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    for (UIControl *subview in [segmentControl subviews]) {
        
        if ([subview isSelected]){
            [subview setTintColor:selectedColor];
        }
        else
            [subview setTintColor:deselectedColor];
    }
    
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    self.caseDataTableView.hidden = YES;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.caseDataTableView.hidden = NO;
            break;
        case 1:
            self.IndicationView.hidden = NO;
            break;
        case 2:
            self.procedureView.hidden = NO;
        default:
            break;
    }
    
    
}
#pragma mark Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _caseDataValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"caseData";
    OKOperatieNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKOperatieNoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    OKContactManager *contactsManager = [OKContactManager instance];
    OKProcedureTemplateVariablesModel *variableModel = _caseDataValues[indexPath.row];
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
    } else if([variableModel.value isEqualToString:@"var_physicans"] || [variableModel.value isEqualToString:@"var_assistant"] || [variableModel.value isEqualToString:@"var_anesthesiologist"]){
        variableValue = [_model valueForKey:[NSString stringWithFormat:@"%@_names",variableModel.value]];
    } else {
        variableValue = [_model valueForKey:variableModel.value];
    }
    
    

    
    OKProcedureTemplateVariablesModel *caseDataObject = [[OKProcedureTemplateVariablesModel alloc]init];
    caseDataObject.key = variableModel.key;
    caseDataObject.value = variableValue;
    [_caseDataArray addObject:caseDataObject];
    
    
    [cell setLabelsWithKey:variableModel.key AndValue:variableValue ];
    [tableView setContentInset:UIEdgeInsetsMake(1.0, 0.0, 0.0, 0.0)];
    return cell;
}
- (IBAction)saveButtonTapped:(id)sender {
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKProceduresManager *proceduresManager = [OKProceduresManager instance];
    
    [proceduresManager saveProcedureWithSurgeonID:[OKUserManager instance].currentUser.identifier ProcedureID:[NSString stringWithFormat:@"%d", _procedureID] AndProcedureModel:self.model handler:^(NSString *errorMsg, id json) {
        
        NSLog(@"Error - %@", errorMsg);
        [[OKLoadingViewController instance] hide];
        if (errorMsg == nil) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            OKFacilityVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"FacilityVC"];
            [_templateDictionary setObject:_caseDataArray forKey:@"caseData"];
            vc.templateDictionary = _templateDictionary;
            [self.navigationController pushViewController:vc animated:YES];
            //[self performSegueWithIdentifier:@"fromOpNoteToFacility" sender:self];
            
        } else {
            if ([[json valueForKey:@"status"] isEqualToString:@"false"]) {
                UIAlertView *alertNoContacts = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                          message:@"Record number already in use."
                                                                         delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles: nil];
                [alertNoContacts show];
                
            }
        }
        
        [[OKLoadingViewController instance] hide];
        
        
    }];
    
}

@end
