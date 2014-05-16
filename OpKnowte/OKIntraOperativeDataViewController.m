//
//  OKIntraOperativeDataViewController.m
//  OpKnowte
//
//  Created by Olegek on 15.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKIntraOperativeDataViewController.h"
#import "OKDatePicker.h"
#import "OKSLListCell.h"
#import "RangeSlider.h"
#import "OKProcedureModel.h"
#import "OKSurgicalLogsManager.h"
#import "OKIntraOperativeDataTableViewCell.h"

@interface OKIntraOperativeDataViewController ()<OKIntraOperativeProtocol>

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


@property (strong, nonatomic) IBOutlet UILabel *caseFromLabel;
@property (strong, nonatomic) IBOutlet UILabel *caseToLabel;

@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UILabel *diselectAllLabel;
@property (strong, nonatomic) IBOutlet UIButton *diselectAllButton;
@property (strong, nonatomic) IBOutlet UILabel *searchLabel;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) IBOutlet UIView *bottombuttonView;
@property (strong, nonatomic) IBOutlet UIButton *bottomButton;

@property(strong,nonatomic) RangeSlider *slider;

@property (nonatomic, strong) NSMutableArray *detailsArray;
@property (nonatomic, strong) NSMutableArray *choosedDetails;
@property (nonatomic, assign) BOOL deselectAll;
@property (nonatomic, strong) NSDateFormatter *dateformater;
@property (nonatomic, assign) BOOL dateFromButtonTapped;
@property (nonatomic, assign) BOOL dateToButtonTapped;

@end

@implementation OKIntraOperativeDataViewController

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
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    _detailsArray = [[NSMutableArray alloc] init];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addLeftButtonToNavbar];
    _procedureLabel.text = _procTitle;
    _choosedDetails = [[NSMutableArray alloc] init];
    [self setDatePickerDesign];
	[self setDesign];
     [_listTableView reloadData];
    _dateFromButton.tag = 1;
    _dateToButton.tag = 2;
    
    
}
-(NSMutableArray *)getFilterArray:(NSMutableArray *)data{
    NSMutableArray *filtered = [[NSMutableArray alloc] init];
    
    
    int total = [data count];
    int from = [_caseFromLabel.text intValue];
    int to = [_caseToLabel.text intValue];
    
    
    for (int i = 0; i<total; i++) {
        id model = data[i];
        int MRNumber =[[model valueForKey:@"MRNumber"] intValue];
        if ( MRNumber >= from && MRNumber <=to ) {
            [filtered addObject:data[i]];
        }
    }
    
    return filtered;
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
    OKSurgicalLogsManager *surgicalLogsManager = [OKSurgicalLogsManager instance];
    [surgicalLogsManager getSurgeonDatesByUserID:[OKUserManager instance].currentUser.identifier AndProcedureID:_procID handler:^(NSString *errorMsg, id dates) {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deleteFile:(NSString *)fileName{
    NSLog(@"%@",fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];
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
            [surgicalLogsManager getSurgeonPerformanceDataByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID FromTime:_dateFromTF.text ToTime:_dateToTF.text FromRecordNum:_caseFromLabel.text ToRecordNum:_caseToLabel.text handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
                NSLog(@"Eror - %@", errorMsg);
                
                _detailsArray = [self getFilterArray:dataArray];
                _deselectAll = YES;
                
                [_choosedDetails addObjectsFromArray:_detailsArray];
                
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
                NSString *str = @"01-01-1950";
                [self.datePicker setDate:[_dateformater dateFromString:str]];
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
    _bottombuttonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    _bottomButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _bottomButton.layer.cornerRadius = 14;
    
    _slider = [[RangeSlider alloc] initWithFrame:CGRectMake(60, 90, 244, 20)]; // the slider enforces a height of 30, although I'm not sure that this is necessary
	_slider.minimumRangeLength = .000005; // this property enforces a minimum range size. By default it is set to 0.0
	[_slider setMinThumbImage:[UIImage imageNamed:@"rangethumb.png"]]; // the two thumb controls are given custom images
	[_slider setMaxThumbImage:[UIImage imageNamed:@"rangethumb.png"]];
	UIImage *image; // there are two track images, one for the range "track", and one for the filled in region of the track between the slider thumbs
	[_slider setTrackImage:[[UIImage imageNamed:@"fullrange.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9.0, 9.0, 9.0, 9.0)]];
	image = [UIImage imageNamed:@"fillrange.png"];
	[_slider setInRangeTrackImage:image];
    [_slider addTarget:self action:@selector(report:) forControlEvents:UIControlEventValueChanged]; // The slider sends actions when the value of the minimum or maximum changes
	NSString *caseFromString = [NSString stringWithFormat:@"%d", (int)(_slider.min*100000)];
	_caseFromLabel.text = caseFromString;
    NSString *caseToString = [NSString stringWithFormat:@"%d", (int)(_slider.max*100000)];
    _caseToLabel.text = caseToString;
    [self.dateView addSubview:_slider];
    
}


- (void)report:(RangeSlider *)sender {
	NSString *caseFromString = [NSString stringWithFormat:@"%d", (int)(_slider.min*100000)];
	_caseFromLabel.text = caseFromString;
    NSString *caseToString = [NSString stringWithFormat:@"%d", (int)(_slider.max*100000)];
    _caseToLabel.text = caseToString;
    
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
    
    static NSString *cellIdentifier = @"IntraOperativeCell";
    OKIntraOperativeDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKIntraOperativeDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    
    for (NSArray * chosedD in _choosedDetails) {
        if ([[chosedD valueForKey:@"Patient_Name"] isEqualToString:cell.nameLabel.text]) {
            [cell setCellButtonBGImageWithGreenMinusIcon:YES];
        }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}


@end
