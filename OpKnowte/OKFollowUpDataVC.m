//
//  OKFollowUpDataVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFollowUpDataVC.h"
#import "OKFollowUpDataCell.h"
#import "OKProcedureModel.h"
#import "OKDatePicker.h"
#import "OKSurgicalLogsManager.h"
#import "OKFollowUpDataManager.h"
#import "OKSelectTimePointViewController.h"

@interface OKFollowUpDataVC () <OKFollowUpDataCellDelegate>
@property (strong, nonatomic) IBOutlet UIView *procedureView;
@property (strong, nonatomic) IBOutlet UILabel *procedureLabel;
@property (strong, nonatomic) IBOutlet UIButton *procedureButton;


@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet OKCustomTextField *dateFromTF;
@property (strong, nonatomic) IBOutlet OKCustomTextField *dateToTF;

@property (strong, nonatomic) OKDatePicker *datePicker;
@property (strong, nonatomic) UIView *pickerBGView;
@property (strong, nonatomic) IBOutlet UIButton *dateFromButton;
@property (strong, nonatomic)IBOutlet UIButton *dateToButton;




@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UILabel *diselectAllLabel;
@property (strong, nonatomic) IBOutlet UIButton *diselectAllButton;
@property (strong, nonatomic) IBOutlet UILabel *searchLabel;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) IBOutlet UIView *selectTimePeriodView;
@property (strong, nonatomic) IBOutlet UIButton *selectTimePeriodButton;


@property (nonatomic, strong) NSMutableArray *surgeonDataArray;
@property (nonatomic, strong) NSMutableArray *nationalDataArray;

@property (nonatomic, strong) NSMutableArray *surgeonClinicalData;
@property (nonatomic, strong) NSMutableArray *nationalClinicalData;

@property (nonatomic, strong) NSMutableArray *choosedDetails;
@property (nonatomic, assign) BOOL deselectAll;
@property (nonatomic, strong) NSDateFormatter *dateformater;
@property (nonatomic, assign) BOOL dateFromButtonTapped;
@property (nonatomic, assign) BOOL dateToButtonTapped;

@end

@implementation OKFollowUpDataVC

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
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    _surgeonDataArray = [[NSMutableArray alloc] init];
    _nationalDataArray = [[NSMutableArray alloc] init];
    
    _surgeonClinicalData = [[NSMutableArray alloc] init];
    _nationalClinicalData = [[NSMutableArray alloc] init];
    
    _choosedDetails = [[NSMutableArray alloc] init];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Follow Up Data";
    [self addLeftButtonToNavbar];
    _procedureLabel.text = _procTitle;
    [self setDatePickerDesign];
	[self setDesign];
    [_listTableView reloadData];
    _dateFromButton.tag = 1;
    _dateToButton.tag = 2;
    
    
    
}

-(void) setDatePickerDesign {
    float yPoint;
    if (IS_IPHONE_5 ) {
        yPoint = 406;
    } else {
        yPoint = 318;
    }
    _pickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, yPoint, 320, 162)];
    _pickerBGView.backgroundColor = [UIColor colorWithRed:24/255. green:59/255. blue:85/255. alpha:.90];
    self.datePicker = [[OKDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    [self.datePicker setTextColor:[UIColor whiteColor]];
    _dateformater = [[NSDateFormatter alloc] init];
    [_dateformater setDateFormat:@"MM-dd-yyyy"];
    [self.datePicker setMaximumDate:[NSDate date]];
    [self.view addSubview:_pickerBGView];
    [_pickerBGView addSubview:_datePicker];
    _pickerBGView.hidden = YES;
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    
    OKFollowUpDataManager *followUpDataManager = [OKFollowUpDataManager instance];
    [followUpDataManager getNationalDatesByProcedureID:_procID handler:^(NSString *errorMsg, id dates) {
        NSLog(@"Eror - %@", errorMsg);
        
        if ((dates) && ([dates count] > 0)) {
            int count = [dates count];
            _dateFromTF.text = [dates objectAtIndex:0];
            _dateToTF.text = [dates objectAtIndex:count-1];
        }
        OKSurgicalLogsManager *surgicalLogsManager = [OKSurgicalLogsManager instance];
        [surgicalLogsManager getSurgeonPerformanceDataByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID FromTime:_dateFromTF.text ToTime:_dateToTF.text FromRecordNum:@"1" ToRecordNum:@"1"  handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
            NSLog(@"Eror - %@", errorMsg);
            
            _surgeonDataArray = dataArray;
            _choosedDetails = [dataArray mutableCopy];
            [_listTableView reloadData];
            [followUpDataManager getNationalPerformancDataByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID FromTime:_dateFromTF.text  ToTime:_dateToTF.text handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
                NSLog(@"Eror - %@", errorMsg);
                
                _nationalDataArray = dataArray;
                
            }];
            
        }];
        [[OKLoadingViewController instance] hide];
    }];
    
    
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    if (IS_IOS7) {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    } else {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );}
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
}


-(void)viewWillAppear:(BOOL)animated{

    
}


- (IBAction)procedureButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectTimePeriodButtonTapped:(id)sender {
    if (_choosedDetails.count) {
        [[OKLoadingViewController instance] showWithText:@"Loading..."];
        OKFollowUpDataManager *followUpDataManager = [OKFollowUpDataManager instance];
        [followUpDataManager getClinicalDetailsByCaseArray:_choosedDetails handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
            
            NSLog(@"Eror - %@", errorMsg);
            _surgeonClinicalData = dataArray;
            [followUpDataManager getClinicalDetailsByCaseArray:_nationalDataArray handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
                NSLog(@"Eror - %@", errorMsg);
                _nationalClinicalData = dataArray;
                [[OKLoadingViewController instance] hide];
                [self performSegueWithIdentifier:@"fromFollowUpDataToTimePoints" sender:nil];
            }]; 
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Choose at least one case"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }


}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromFollowUpDataToTimePoints"]){
        OKSelectTimePointViewController *sharVC = (OKSelectTimePointViewController*)segue.destinationViewController;
        sharVC.cameFromVC = @"FollowUpData";
        sharVC.performanceCases = [[NSMutableArray alloc] initWithArray:_nationalClinicalData];
        sharVC.surgeonCases = [[NSMutableArray alloc] initWithArray:_surgeonClinicalData];
        sharVC.totlaNationalCases = [[NSMutableArray alloc] initWithArray:_nationalDataArray];
        sharVC.totalSurgeonCases = [[NSMutableArray alloc] initWithArray:_choosedDetails];       
                                   
    } 
}


- (IBAction)diselectAllButton:(id)sender {
    [_choosedDetails removeAllObjects];
    _deselectAll = YES;
    [_listTableView reloadData];
}


- (IBAction)searchButton:(id)sender {
    [_choosedDetails removeAllObjects];
    if (_dateFromTF.text.length == 0 || _dateToTF.text.length == 0) {
        UIAlertView *emptyFieldsError = [[UIAlertView alloc] initWithTitle:@"" message:@"Please fill all required fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [emptyFieldsError show];
    }else{
        
        if ([self varifyDates]) {
            [[OKLoadingViewController instance] showWithText:@"Loading..."];
            OKFollowUpDataManager *followUpDataManager = [OKFollowUpDataManager instance];
            OKSurgicalLogsManager *surgicalLogsManager = [OKSurgicalLogsManager instance];
            [surgicalLogsManager getSurgeonPerformanceDataByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID FromTime:_dateFromTF.text ToTime:_dateToTF.text FromRecordNum:@"1" ToRecordNum:@"1"  handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
                NSLog(@"Eror - %@", errorMsg);
                
                _surgeonDataArray = dataArray;
                _choosedDetails = [dataArray mutableCopy];
                [_listTableView reloadData];
                [followUpDataManager getNationalPerformancDataByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID FromTime:_dateFromTF.text  ToTime:_dateToTF.text handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
                    NSLog(@"Eror - %@", errorMsg);
                    
                    _nationalDataArray = dataArray;
                    
                }];
                [[OKLoadingViewController instance] hide];
            }];
        }else{
            UIAlertView *dateError = [[UIAlertView alloc] initWithTitle:@"" message:@"From time cannot be in future of To time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [dateError show];
            
        }
    }
    
}


-(BOOL)varifyDates{
    NSDate *d1;
    NSDate *d2;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MM-dd-yyyy"];
    d1 = [dateFormat1 dateFromString:_dateFromTF.text];
    d2 = [dateFormat1 dateFromString:_dateToTF.text];
    
    NSComparisonResult result = [d2 compare:d1];
    
    switch (result)
    {
        case NSOrderedAscending: NSLog(@"%@ is in future from %@", d1, d2);
            return NO;
            break;
        case NSOrderedDescending: NSLog(@"%@ is in past from %@", d1, d2);
            return YES;
            break;
        case NSOrderedSame: NSLog(@"%@ is the same as %@", d1, d2);
            return YES;
            break;
        default: NSLog(@"erorr dates %@, %@", d1, d2);
            return NO;
            break;
    }
}


- (IBAction)dateFromButtonTapped:(id)sender {
    if (!_dateToButtonTapped) {
        if (_pickerBGView.hidden) {
            if (_dateFromTF.text.length > 0) {
                [self.datePicker setDate:[_dateformater dateFromString:_dateFromTF.text]];
            } else {
                NSString *str = @"01-01-1950";
                [self.datePicker setDate:[_dateformater dateFromString:str]];
            }
            _dateFromButtonTapped = YES;
        } else {
            _dateFromTF.text = [NSString stringWithFormat:@"%@", [_dateformater stringFromDate:self.datePicker.date]];
            _dateFromButtonTapped = NO;
        }
        _pickerBGView.hidden = !_pickerBGView.hidden;
        
    }
    
}
- (IBAction)dateToButtonTapped:(id)sender {
    if (!_dateFromButtonTapped) {
        if (_pickerBGView.hidden) {
            if (_dateToTF.text.length > 0) {
                [self.datePicker setDate:[_dateformater dateFromString:_dateToTF.text]];
            } else {
                [self.datePicker setDate:[NSDate date]];
            }
            _dateToButtonTapped = YES;
        } else {
            _dateToTF.text = [NSString stringWithFormat:@"%@", [_dateformater stringFromDate:self.datePicker.date]];
            _dateToButtonTapped = NO;
        }
        _pickerBGView.hidden = !_pickerBGView.hidden;
    }
    
    
}

- (void)backButton {
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void) setDesign{
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    _procedureView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellDark"]];
    _listTableView.backgroundColor = [UIColor clearColor];
    _dateView.backgroundColor = [UIColor colorWithRed:19/255.f green:65/255.f blue:91/255.f alpha:1];
    _dateFromTF.text = @"";
    _dateToTF.text = @"";
    
    _searchView.backgroundColor = [UIColor clearColor];
    _selectTimePeriodView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    _selectTimePeriodButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _selectTimePeriodButton.layer.cornerRadius = 14;
    _selectTimePeriodButton.clipsToBounds = YES;
}

#pragma mark - tableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_surgeonDataArray.count) {
        return 0;
    } else {
        return _surgeonDataArray.count;
    }
    
    
}
-(void)addModelToList:(id)model{
    [_choosedDetails addObject:model];
    
}
-(void)deleteModelFromList:(id)model{
    
    for (int i = 0; i<_choosedDetails.count; i++) {
        id searchedModel = [_choosedDetails objectAtIndex:i];
        if ([[searchedModel valueForKey:@"DetailID"] isEqualToString:[model valueForKey:@"DetailID"]]) {
            [_choosedDetails removeObjectAtIndex:i];
            break;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"FollowUpCell";
    OKFollowUpDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKFollowUpDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setCellButtonBGImageWithGreenMinusIcon:YES];
    if (_deselectAll) {
        [cell setCellButtonBGImageWithGreenMinusIcon:NO];
        if (indexPath.row == _surgeonDataArray.count-1) {
            _deselectAll = NO;
        }
    }
    
    
    id model = _surgeonDataArray[indexPath.row];
    cell.model = model;
    cell.nameLabel.text = [model valueForKey:@"var_patientName"];
    cell.dateLabel.text = [model valueForKey:@"var_DOS"];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
