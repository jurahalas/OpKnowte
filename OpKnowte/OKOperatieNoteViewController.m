//
//  OKOperatieNoteViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOperatieNoteViewController.h"
#import "OKShockwaveLithotripsyModel.h"
#import "OKLRPartialNephrectomyModel.h"

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

@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) NSMutableArray *values;

@property (strong, nonatomic) OKShockwaveLithotripsyModel *SWLModel;
@property (strong, nonatomic) OKLRPartialNephrectomyModel *LRPNModel;

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
    _keys = [[NSMutableArray alloc] initWithObjects:
    @"Patient Name",
    @"Patient DOB",
    @"Sex",
    @"Medical Record Number",
    @"Date of Service",
    @"Anesthesia Performed",
    @"Anesthesia Location",
    @"Stones Count",
    @"Rate of Waves",
    @"kV of Waves",
    @"2 Minutes Pause Performed",
    @"Follow Up",
    @"Complications", nil];
   
   
    _values =  [[NSMutableArray alloc] initWithObjects:
                [self.model valueForKey:@"patientName"],
                [self.model valueForKey:@"patientDOB"],
                [self.model valueForKey:@"gender"],
                [self.model valueForKey:@"mrNumber"],
                [self.model valueForKey:@"dateOfService"],
                [self.model valueForKey:@"anesthesiaPerformed"],
                [self.model valueForKey:@"anesthesiaLocation"],
                [self.model valueForKey:@"stonesCount"],
                [self.model valueForKey:@"rateOfWaves"],
                [self.model valueForKey:@"kvOfWaves"],
                [self.model valueForKey:@"pausePerformed"],
                [self.model valueForKey:@"followUp"],
                [self.model valueForKey:@"complications"],nil ];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    segmentControllView.backgroundColor = [UIColor clearColor];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
  
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segmentControllBG.png"]];
    [self.segmentControllView addSubview:backgroundView];
    
    caseDataTableView.backgroundColor = [UIColor clearColor];

    self.caseDataTableView.dataSource = self;
    self.caseDataTableView.delegate = self;
    
   caseDataTableView.frame = CGRectMake(caseDataTableView.frame.origin.x, caseDataTableView.frame.origin.y, caseDataTableView.frame.size.width, (caseDataTableView.frame.size.height - 60.f));

    [self.caseDataTableView reloadData];

    [self indicationMethod];
    [self procedureMethod];
    
    self.caseDataTableView.hidden = NO;
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)indicationMethod{

    IndicationView.backgroundColor = [UIColor clearColor];
    
    NSString *stonesSizes = nil;
    NSString *stonesLocations = nil;
    for (NSString *stonesSize in [self.model valueForKey:@"stonesSizes"]) {
        if (![stonesSize isEqualToString:@" "]) {
            if (stonesSizes == nil)
                stonesSizes = stonesSize;
            else
                stonesSizes = [NSString stringWithFormat:@"%@,%@",stonesSizes, stonesSize];

            
        }
       
    }
    for (NSString *stonesLocation in [self.model valueForKey:@"stonesLocations"]) {
        if (![stonesLocation isEqualToString:@" "]) {
            if (stonesLocations == nil)
                stonesLocations = stonesLocation;
            else
                stonesLocations = [NSString stringWithFormat:@"%@,%@",stonesLocations, stonesLocation];
        }
        
    }
    NSString *indicationText = [NSString stringWithFormat:@"(%@) is a (%@) year old (%@) with a history of nephrolithiasis, currently with a (%@) (%@) stone. Options for management were discussed with the patient. The indications, procedure, and expectations for shockwave lithotripsy were discussed with the patient. Risks including but not limited to infections, bleeding, hematoma, residual stone, recurrent stone, steinstrasse, need for further or additional procedures were discussed with the patient and they have asked me to proceed.",
                                [self.model valueForKey:@"patientName"],
                                [self.model valueForKey:@"patientDOB"],
                                [self.model valueForKey:@"gender"],
                                stonesSizes,
                                stonesLocations
                                ];
                             
    
    indicationLabel.text = indicationText;
    
    [indicationLabel sizeToFit];
    indicationScrollView.contentSize = CGSizeMake(indicationScrollView.contentSize.width, indicationLabel.frame.size.height+80);
    [indicationScrollView addSubview:indicationLabel];
    [self.IndicationView addSubview:indicationScrollView];
    
}

-(void)procedureMethod{

    procedureView.backgroundColor = [UIColor clearColor];
    NSString *stonesSizes = nil;
    NSString *stonesLocations = nil;
    NSString *degreesOfFragmentation = nil;
    NSString *totalShocks = nil;
    for (NSString *stonesSize in [self.model valueForKey:@"stonesSizes"]) {
        if (![stonesSize isEqualToString:@" "]) {
            if (stonesSizes == nil)
                stonesSizes = stonesSize;
            else
                stonesSizes = [NSString stringWithFormat:@"%@,%@",stonesSizes, stonesSize];
        }
        
    }
    for (NSString *stonesLocation in [self.model valueForKey:@"stonesLocations"]) {
        if (![stonesLocation isEqualToString:@" "]) {
            if (stonesLocations == nil)
                stonesLocations = stonesLocation;
            else
                stonesLocations = [NSString stringWithFormat:@"%@,%@",stonesLocations, stonesLocation];
        }
        
    }
    for (NSString *degreeOfFragmentation in [self.model valueForKey:@"degreeOfFragmentation"]) {
        if (![degreeOfFragmentation isEqualToString:@" "]) {
            if (degreesOfFragmentation == nil)
                degreesOfFragmentation = degreeOfFragmentation;
            else
            degreesOfFragmentation = [NSString stringWithFormat:@"%@,%@",degreesOfFragmentation, degreeOfFragmentation];
        }
        
    }
    for (NSString *totalShock in [self.model valueForKey:@"totalShocks"]) {
        if (![totalShock isEqualToString:@" "]) {
            if (totalShocks == nil)
                totalShocks = totalShock;
            else
            totalShocks = [NSString stringWithFormat:@"%@,%@",totalShocks, totalShock];
        }
        
    }
    
    NSString * procedureText = [NSString stringWithFormat:@"After appropriate (%@) anesthesia was administered, the patient was positioned supine on the lithotripsy table. The stone(s) was(were) localized under fluoroscopy in both craniocaudal and anteroposterior views. A total of (%@) were delivered to the (%@) (%@). Shockwaves were delivered at a rate of (%@) and (%@). (%@). There was (%@) fragmentation of the (%@) (%@). The patient was awakened from anesthesia and taken to the recovery room in stable condition. (%@). Disposition: The patient is to followup in (%@).",
                                [self.model valueForKey:@"anesthesiaPerformed"],
                                totalShocks,
                                stonesSizes,
                                stonesLocations,
                                [self.model valueForKey:@"rateOfWaves"],
                                [self.model valueForKey:@"kvOfWaves"],
                                [self.model valueForKey:@"pausePerformed"],
                                degreesOfFragmentation,
                                stonesSizes,
                                stonesLocations,
                                [self.model valueForKey:@"complications"],
                                [self.model valueForKey:@"followUp"]
                                ];
   
    procedureLable.text = procedureText;
    
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
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.IndicationView.hidden = YES;
            self.procedureView.hidden = YES;
            self.caseDataTableView.hidden = NO;
            break;
        case 1:
            self.IndicationView.hidden = NO;
            self.procedureView.hidden = YES;
            self.caseDataTableView.hidden = YES;
            break;
        case 2:
            self.IndicationView.hidden = YES;
            self.procedureView.hidden = NO;
            self.caseDataTableView.hidden = YES;
        default:
            break;
    }
    
    
}
#pragma mark Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"caseData";
    OKOperatieNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKOperatieNoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setLabelsWithKey:_keys[indexPath.row] AndValue:_values[indexPath.row]];
     [tableView setContentInset:UIEdgeInsetsMake(1.0, 0.0, 0.0, 0.0)];
    return cell;
}

@end
