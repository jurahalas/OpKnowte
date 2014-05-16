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


@property (nonatomic, strong) NSMutableArray *detailsArray;
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
    _detailsArray = [[NSMutableArray alloc] init];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Surgical Logs";
    [self addLeftButtonToNavbar];
    _procedureLabel.text = _procTitle;
    _choosedDetails = [[NSMutableArray alloc] init];
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
    
    
    
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
}


-(void)viewWillAppear:(BOOL)animated{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
//    OKSurgicalLogsManager *surgicalLogsManager = [OKSurgicalLogsManager instance];
//    [surgicalLogsManager getSurgeonDatesByUserID:[OKUserManager instance].currentUser.identifier AndProcedureID:_procID handler:^(NSString *errorMsg, id dates) {
//        NSLog(@"Eror - %@", errorMsg);
//        
//        if ((dates) && ([dates count] > 0)) {
//            
//            int count = [dates count];
//            _dateFromTF.text = [dates objectAtIndex:0];
//            _dateToTF.text = [dates objectAtIndex:count-1];
//            
//        }
//        [[OKLoadingViewController instance] hide];
//    }];
    OKFollowUpDataManager *followUpDataManager = [OKFollowUpDataManager instance];
    [followUpDataManager getNationalDatesByProcedureID:_procID handler:^(NSString *errorMsg, id dates) {
        NSLog(@"Eror - %@", errorMsg);
        
        if ((dates) && ([dates count] > 0)) {
            int count = [dates count];
            _dateFromTF.text = [dates objectAtIndex:0];
            _dateToTF.text = [dates objectAtIndex:count-1];
        }
        [[OKLoadingViewController instance] hide];
    }];
    
}


- (IBAction)procedureButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectTimePeriodButtonTapped:(id)sender {
}

- (IBAction)diselectAllButton:(id)sender {
    [_choosedDetails removeAllObjects];
    _deselectAll = YES;
    [_listTableView reloadData];
}


- (IBAction)searchButton:(id)sender {
    if (_dateFromTF.text.length == 0 || _dateToTF.text.length == 0) {
        UIAlertView *emptyFieldsError = [[UIAlertView alloc] initWithTitle:@"" message:@"Please fill all required fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [emptyFieldsError show];
    }else{
        
        if ([self varifyDates]) {
            [[OKLoadingViewController instance] showWithText:@"Loading..."];
            
            OKSurgicalLogsManager *surgicalLogsManager = [OKSurgicalLogsManager instance];
            [surgicalLogsManager getSurgeonPerformanceDataByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID FromTime:_dateFromTF.text ToTime:_dateToTF.text FromRecordNum:@"1" ToRecordNum:@"1"  handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
                NSLog(@"Eror - %@", errorMsg);
                
                _detailsArray = dataArray;
                _deselectAll = YES;
                [_listTableView reloadData];
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
    if (!_detailsArray.count) {
        return 0;
    } else {
        return _detailsArray.count;
    }
    
    
}
-(void)addModelToList:(id)model{
    [_choosedDetails addObject:model];
    
}
-(void)deleteModelFromList:(id)model{
    for (int i = 0; i<_choosedDetails.count; i++) {
        if ([[_choosedDetails[i] valueForKey:@"DetailID"] isEqualToString:[model valueForKey:@"DetailID"]]) {
            [_choosedDetails removeObjectAtIndex:i];
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
    if (_deselectAll) {
        [cell setCellButtonBGImageWithGreenMinusIcon:NO];
        if (indexPath.row == _detailsArray.count-1) {
            _deselectAll = NO;
        }
    }
    
    
    id model = _detailsArray[indexPath.row];
    cell.model = model;
    cell.nameLabel.text = [model valueForKey:@"Patient_Name"];
    cell.dateLabel.text = [model valueForKey:@"DateOfService"];
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
