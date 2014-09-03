//
//  OKImmediateDataVC.m
//  OpKnowte
//
//  Created by Apple on 16.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKImmediateDataVC.h"
#import "OKPostOpDataGraphsVC.h"
#import "OKProceduresManager.h"

@interface OKImmediateDataVC ()
@property (strong, nonatomic) IBOutlet UITableView *immediateDataTable;
@property (strong, nonatomic) NSArray *tableData;

@end

@implementation OKImmediateDataVC

@synthesize selectedCases, sumOfAges, isCalculated, positiveDMargins,maleCount,LRMCount, cytoStentCount,adhesiolysisCount,vasAnomolyCount,intraOpUSCount,renalSRCount,coagulantCount,transfusionCount,consoleTimeCount,roomTimeCount,clampTimeCount,bloodLossCount,tumorSizeCount,bmiCount,maxAge,minAge,minBmi,maxBmi,minClampTime,maxClampTime,minConsoleTime,maxConsoleTime,minRoomTime,maxRoomTime,minBloodLoss,maxBloodLoss,minTumorSize,maxTumorSize;

@synthesize surgeonCases, isNationalData, totalSurgeonCount, totalNationalCount;

@synthesize sur_adhesiolysisCount, sur_bloodLossCount, sur_bmiCount, sur_clampTimeCount, sur_coagulantCount, sur_consoleTimeCount, sur_cytoStentCount, sur_intraOpUSCount, sur_LRMCount, sur_maleCount, sur_maxAge, sur_maxBloodLoss, sur_maxBmi, sur_maxClampTime, sur_maxConsoleTime, sur_maxRoomTime, sur_maxTumorSize, sur_minAge, sur_minBloodLoss, sur_minBmi, sur_minClampTime, sur_minConsoleTime, sur_minRoomTime, sur_minTumorSize, sur_positiveDMargins, sur_renalSRCount, sur_roomTimeCount, sur_sumOfAges, sur_transfusionCount, sur_tumorSizeCount, sur_vasAnomolyCount;





- (void)viewDidLoad
{
    [super viewDidLoad];
    self.comp_dictionary = [[NSMutableDictionary alloc] init];
    self.irri_dictionary = [[NSMutableDictionary alloc] init];
    self.diag_dictionary = [[NSMutableDictionary alloc] init];
    self.devimp_dictionary = [[NSMutableDictionary alloc] init];
    self.diluse_dictionary = [[NSMutableDictionary alloc] init];
    self.dilwas_dictionary = [[NSMutableDictionary alloc] init];
    self.restyp_dictionary = [[NSMutableDictionary alloc] init];
    self.dilto_dictionary= [[NSMutableDictionary alloc] init];


    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if ([_procID isEqualToString:@"1"]) {
        self.tableData = @[
                           @"Average Age of Patient",
//                           @"Male vs. Female",
                           @"BMI",
                           @"Blood Loss",
   //                        @"Intra-Op Transfusion",
                           @"Room Time",
                           @"Console Time",
                           @"Adhesiolysis",
                           @"Bladder Neck Recon",
                           @"Complications"
                           ];

    } else if ([_procID isEqualToString:@"2"]) {
        self.tableData = @[
                           @"Average Age of Patient",
                           @"Male vs. Female",
                           @"BMI",
                           @"Left vs. Right Renal Mass",
                           @"Patients with Cysto/Stent",
                           @"Tumor Size",
//                           @"Tumor Characteristics",
                           @"Cases Requiring Adhesiolysis",
                           @"Cases with Vascular Anomoly",
                           @"Intra-Operative Ultra Sound",
                           @"Deep Margins",
    //                       @"Margins",
                           @"Renal Collecting System Repair",
                           @"Average Clamp Time",
                           @"Coagulants",
                           @"Blood Loss",
                           @"Console Time",
                           @"Room Time",
//                           @"Complications",
                           @"Cases Requiring Transfusion"
//                           @"Advanced Options"
                           ];

    } else if ([_procID isEqualToString:@"9"]) {
        self.tableData = @[
                           @"Average Age of Patient",
                           @"Diagnosis",
                           @"Device Implanted",
                           @"Dilators used",
                           @"Dilated to",
                           @"Dilation was",
                           @"Average device length",
                           @"Reservoir side",
                           @"Reservoir type",
                           @"Reservoir filled to",
                           @"Drain Placed",
                           @"Irrigation antibiotics used",
                           @"Complications  "
                           
                           ];

    } else if ([_procID isEqualToString:@"10"]) {
        self.tableData = @[
                           @"Average Age of Patient",
                           @"Male vs. Female"
                           ];

    }

    [self addBottomTabBar];
    _immediateDataTable.backgroundColor = [UIColor clearColor];
    self.immediateDataTable.dataSource = self;
    self.immediateDataTable.delegate = self;
    _immediateDataTable.frame = CGRectMake(_immediateDataTable.frame.origin.x, _immediateDataTable.frame.origin.y, _immediateDataTable.frame.size.width, (_immediateDataTable.frame.size.height - 57.f));
    [self.immediateDataTable reloadData];
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

#pragma mark - IBActions
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table View methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKImmediateDataCell *cell = [[OKImmediateDataCell alloc] init];
    cell = (OKImmediateDataCell*)[_immediateDataTable cellForRowAtIndexPath:indexPath];
    if ([cell.immediateDataLabel.text isEqualToString:@"BMI"] || [cell.immediateDataLabel.text isEqualToString:@"Average device length" ]) {
        [self BMI];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Average Age of Patient"]){
        [self AverageAgeOfPatient];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Bladder Neck Recon"]){
        [self VascularAnomoly];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Male vs. Female"]|| [cell.immediateDataLabel.text isEqualToString:@"Drain Placed"]){
        [self MaleFemale];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Left vs. Right Renal Mass"] || [cell.immediateDataLabel.text isEqualToString:@"Reservoir side"]){
        [self LeftRightRenalMass];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Patients with Cysto/Stent"] || [cell.immediateDataLabel.text isEqualToString:@"Complications  "]){
        [self CytoStent];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Tumor Size"] || [cell.immediateDataLabel.text isEqualToString:@"Reservoir filled to"]){
        [self TumorSize];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Tumor Characteristics"]){
        [self TumorCharacteristics];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Cases Requiring Adhesiolysis"] || [cell.immediateDataLabel.text isEqualToString:@"Adhesiolysis"]){
        [self AdhesiolysisRequired];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Cases with Vascular Anomoly"]){
        [self VascularAnomoly];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Intra-Operative Ultra Sound"]){
        [self IntraOpUltraSound];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Deep Margins"]){
        [self DeepMargins];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Margins"]){
        [self Margins];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Renal Collecting System Repair"]){
        [self RenalSystemRepair];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Average Clamp Time"]){
        [self AverageClampTime];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Coagulants"]){
        [self Coagulants];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Blood Loss"]){
        [self BloodLoss];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Console Time"]){
        [self ConsoleTime];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Room Time"]){
        [self RoomTime];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Complications"]){
        [self Complications];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Cases Requiring Transfusion"] || [cell.immediateDataLabel.text isEqualToString:@"Intra-Op Transfusion"]){
        [self TransfusionRequired];
    } else if ([cell.immediateDataLabel.text isEqualToString:@"Irrigation antibiotics used"]){
        [self irrigationAntiUsed];
    } else if ([cell.immediateDataLabel.text isEqualToString:@"Diagnosis"]){
        [self Diagnosis];
    } else if ([cell.immediateDataLabel.text isEqualToString:@"Device Implanted"]){
        [self DeviceImplanted];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Dilators used"]){
        [self DilatorsUsed];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Dilation was"]){
        [self DilationWas];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Reservoir type"]){
        [self ReservoirType];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Dilated to"]){
        [self Dilatedto];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableData.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"immediateCell";
    OKImmediateDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKImmediateDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.immediateDataLabel.text = self.tableData[indexPath.row];
    [cell setCellBGImageLight:(int)indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.surgeonCases = [[NSMutableArray alloc] init];
        isNationalData = YES;
    }
    return self;
}




-(void) Dilatedto {
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"Dilatedto";
    
    controller.dilto_dictionary = [[NSMutableDictionary alloc] init];
    //s_dilto_9mm;
    //s_dilto_10mm;
    //s_dilto_11mm;

    if ([self.dilto_dictionary valueForKey:@"s_dilto_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.dilto_dictionary valueForKey:@"s_dilto_9mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_9mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_9mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_9mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"s_dilto_10mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_10mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_10mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_10mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"s_dilto_11mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_11mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_11mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_11mm"];
        }
        
        //+++++++
        //s_dilto_12mm;
        //s_dilto_13mm;
        //s_dilto_14mm;
        //s_dilto_na;
        if ([self.dilto_dictionary valueForKey:@"s_dilto_12mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_12mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_12mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_12mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"s_dilto_13mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_13mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_13mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_13mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"s_dilto_14mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_14mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_14mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_14mm"];
        }
        
        //+++++++

        if ([self.dilto_dictionary valueForKey:@"s_dilto_na"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_na"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_na"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"s_dilto_na"];
        }

        
    }
    //    restyp_Conceal
    //    restyp_Spherical
    //    restyp_Cloverleaf
    //s_dilto_9mm;
    //s_dilto_10mm;
    //s_dilto_11mm;
    
    if ([self.dilto_dictionary valueForKey:@"dilto_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.dilto_dictionary valueForKey:@"dilto_9mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_9mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_9mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_9mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"dilto_10mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_10mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_10mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_10mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"dilto_11mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_11mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_11mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_11mm"];
        }
        
        //+++++++
        //s_dilto_12mm;
        //s_dilto_13mm;
        //s_dilto_14mm;
        //s_dilto_na;
        if ([self.dilto_dictionary valueForKey:@"dilto_12mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_12mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_12mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_12mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"dilto_13mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_13mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_13mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_13mm"];
        }
        if ([self.dilto_dictionary valueForKey:@"dilto_14mm"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_14mm"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_14mm"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_14mm"];
        }
        
        //+++++++
        
        if ([self.dilto_dictionary valueForKey:@"dilto_na"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_na"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_na"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilto_dictionary setObject:noneN forKey:@"dilto_na"];
        }
        
        
    }
    
    
    controller.dilto_dictionary = self.dilto_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];
}



-(void) ReservoirType{
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"ReservoirType";
    
    controller.restyp_dictionary = [[NSMutableDictionary alloc] init];
//    s_restyp_Conceal
//    s_restyp_Spherical
//    s_restyp_Cloverleaf
    if ([self.restyp_dictionary valueForKey:@"s_restyp_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.restyp_dictionary valueForKey:@"s_restyp_Conceal"] != nil) {
            NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Conceal"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.restyp_dictionary setObject:noneN forKey:@"s_restyp_Conceal"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.restyp_dictionary setObject:noneN forKey:@"s_restyp_Conceal"];
        }
        if ([self.restyp_dictionary valueForKey:@"s_restyp_Spherical"] != nil) {
            NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Spherical"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.restyp_dictionary setObject:noneN forKey:@"s_restyp_Spherical"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.restyp_dictionary setObject:noneN forKey:@"s_restyp_Spherical"];
        }
        if ([self.restyp_dictionary valueForKey:@"s_restyp_Cloverleaf"] != nil) {
            NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Cloverleaf"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.restyp_dictionary setObject:noneN forKey:@"s_restyp_Cloverleaf"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.restyp_dictionary setObject:noneN forKey:@"s_restyp_Cloverleaf"];
        }
        
    }
    //    restyp_Conceal
    //    restyp_Spherical
    //    restyp_Cloverleaf
    if ([self.restyp_dictionary valueForKey:@"restyp_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.restyp_dictionary valueForKey:@"restyp_Conceal"] != nil) {
            NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Conceal"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.restyp_dictionary setObject:noneN forKey:@"restyp_Conceal"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.restyp_dictionary setObject:noneN forKey:@"restyp_Conceal"];
        }
        if ([self.restyp_dictionary valueForKey:@"restyp_Spherical"] != nil) {
            NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Spherical"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.restyp_dictionary setObject:noneN forKey:@"restyp_Spherical"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.restyp_dictionary setObject:noneN forKey:@"restyp_Spherical"];
        }
        if ([self.restyp_dictionary valueForKey:@"restyp_Cloverleaf"] != nil) {
            NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Cloverleaf"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.restyp_dictionary setObject:noneN forKey:@"restyp_Cloverleaf"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.restyp_dictionary setObject:noneN forKey:@"restyp_Cloverleaf"];
        }
        
        
    }
    
    
    controller.restyp_dictionary = self.restyp_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)DilationWas {
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"DilationWas";
    
    controller.dilwas_dictionary = [[NSMutableDictionary alloc] init];
    //s_dilwas_straightforward
    //s_dilwas_difficultduetoscarring
    //s_dilwas_difficultduetoanatomy
    if ([self.dilwas_dictionary valueForKey:@"s_dilwas_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.dilwas_dictionary valueForKey:@"s_dilwas_straightforward"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_straightforward"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilwas_dictionary setObject:noneN forKey:@"s_dilwas_straightforward"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilwas_dictionary setObject:noneN forKey:@"s_dilwas_straightforward"];
        }
        if ([self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoscarring"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoscarring"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilwas_dictionary setObject:noneN forKey:@"s_dilwas_difficultduetoscarring"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilwas_dictionary setObject:noneN forKey:@"s_dilwas_difficultduetoscarring"];
        }
        if ([self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoanatomy"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoanatomy"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilwas_dictionary setObject:noneN forKey:@"s_dilwas_difficultduetoanatomy"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilwas_dictionary setObject:noneN forKey:@"s_dilwas_difficultduetoanatomy"];
        }
        
    }
    //s_dilwas_straightforward
    //s_dilwas_difficultduetoscarring
    //s_dilwas_difficultduetoanatomy
    if ([self.dilwas_dictionary valueForKey:@"dilwas_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.dilwas_dictionary valueForKey:@"dilwas_straightforward"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_straightforward"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilwas_dictionary setObject:noneN forKey:@"dilwas_straightforward"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilwas_dictionary setObject:noneN forKey:@"dilwas_straightforward"];
        }
        if ([self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoscarring"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoscarring"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilwas_dictionary setObject:noneN forKey:@"dilwas_difficultduetoscarring"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilwas_dictionary setObject:noneN forKey:@"dilwas_difficultduetoscarring"];
        }
        if ([self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoanatomy"] != nil) {
            NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoanatomy"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.dilwas_dictionary setObject:noneN forKey:@"dilwas_difficultduetoanatomy"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.dilwas_dictionary setObject:noneN forKey:@"dilwas_difficultduetoanatomy"];
        }
        
        
    }
    
    
    controller.dilwas_dictionary = self.dilwas_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];

}

-(void) DilatorsUsed{
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"DilatorsUsed";
    
    controller.diluse_dictionary = [[NSMutableDictionary alloc] init];
    
    if ([self.diluse_dictionary valueForKey:@"s_diluse_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.diluse_dictionary valueForKey:@"s_diluse_Brooks"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Brooks"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diluse_dictionary setObject:noneN forKey:@"s_diluse_Brooks"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diluse_dictionary setObject:noneN forKey:@"s_diluse_Brooks"];
        }
        if ([self.diluse_dictionary valueForKey:@"s_diluse_Hegar"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Hegar"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diluse_dictionary setObject:noneN forKey:@"s_diluse_Hegar"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diluse_dictionary setObject:noneN forKey:@"s_diluse_Hegar"];
        }
        if ([self.diluse_dictionary valueForKey:@"s_diluse_Furlow"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Furlow"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diluse_dictionary setObject:noneN forKey:@"s_diluse_Furlow"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diluse_dictionary setObject:noneN forKey:@"s_diluse_Furlow"];
        }
        
    }
    
    if ([self.diluse_dictionary valueForKey:@"diluse_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.diluse_dictionary valueForKey:@"diluse_Brooks"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Brooks"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diluse_dictionary setObject:noneN forKey:@"diluse_Brooks"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diluse_dictionary setObject:noneN forKey:@"diluse_Brooks"];
        }
        if ([self.diluse_dictionary valueForKey:@"diluse_Hegar"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Hegar"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diluse_dictionary setObject:noneN forKey:@"diluse_Hegar"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diluse_dictionary setObject:noneN forKey:@"diluse_Hegar"];
        }
        if ([self.diluse_dictionary valueForKey:@"diluse_Furlow"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Furlow"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diluse_dictionary setObject:noneN forKey:@"diluse_Furlow"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diluse_dictionary setObject:noneN forKey:@"diluse_Furlow"];
        }

        
    }
    
    
    controller.diluse_dictionary = self.diluse_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];
}



-(void) DeviceImplanted{
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"DeviceImplanted";

    controller.devimp_dictionary = [[NSMutableDictionary alloc] init];

    if ([self.devimp_dictionary valueForKey:@"devimp_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.devimp_dictionary valueForKey:@"devimp_AMS700CX"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700CX"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_AMS700CX"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_AMS700CX"];
        }
        if ([self.devimp_dictionary valueForKey:@"devimp_AMS700CXR"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700CXR"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_AMS700CXR"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_AMS700CXR"];
        }
        if ([self.devimp_dictionary valueForKey:@"devimp_AMS700LGX"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700LGX"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_AMS700LGX"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_AMS700LGX"];
        }
        if ([self.devimp_dictionary valueForKey:@"devimp_ColoplastTitan"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_ColoplastTitan"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_ColoplastTitan"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"devimp_ColoplastTitan"];
        }

    }

    if ([self.devimp_dictionary valueForKey:@"s_devimp_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.devimp_dictionary valueForKey:@"s_devimp_AMS700CX"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700CX"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_AMS700CX"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_AMS700CX"];
        }
        if ([self.devimp_dictionary valueForKey:@"s_devimp_AMS700CXR"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700CXR"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_AMS700CXR"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_AMS700CXR"];
        }
        if ([self.devimp_dictionary valueForKey:@"s_devimp_AMS700LGX"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700LGX"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_AMS700LGX"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_AMS700LGX"];
        }
        if ([self.devimp_dictionary valueForKey:@"s_devimp_ColoplastTitan"] != nil) {
            NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_ColoplastTitan"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_ColoplastTitan"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.devimp_dictionary setObject:noneN forKey:@"s_devimp_ColoplastTitan"];
        }

    }
    
    
    controller.devimp_dictionary = self.devimp_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];

}


-(void) Diagnosis{
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"Diagnosis";
    
    controller.diag_dictionary = [[NSMutableDictionary alloc] init];
    //    s_diag_ErectileDysfunction;
    //    s_diag_PeyroniesDisease;
    //   s_diag_ProstateCancer;
    //
    //    s_diag_Hypertension;
    //    s_diag_Dyslipidemia;
    //    s_diag_CoronaryArteryDisease;
    //
    //    s_diag_DiabetesMellitus;
    //    s_diag_SpinalCordInjury;
    //    s_diag_PelvicTrauma;
    //    s_diag_PenileTrauma;
    //=============================================================================================================================================================
    if ([self.diag_dictionary valueForKey:@"diag_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.diag_dictionary valueForKey:@"diag_ErectileDysfunction"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_ErectileDysfunction"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_ErectileDysfunction"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_ErectileDysfunction"];
        }
        
        if ([self.diag_dictionary valueForKey:@"diag_PeyroniesDisease"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PeyroniesDisease"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_PeyroniesDisease"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_PeyroniesDisease"];
        }
        
        if ([self.diag_dictionary valueForKey:@"diag_ProstateCancer"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_ProstateCancer"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_ProstateCancer"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_ProstateCancer"];
        }
        
        //++++++++++++++++++++++++++
        
        if ([self.diag_dictionary valueForKey:@"diag_Hypertension"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_Hypertension"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_Hypertension"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_Hypertension"];
        }
        
        if ([self.diag_dictionary valueForKey:@"diag_Dyslipidemia"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_Dyslipidemia"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_Dyslipidemia"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_Dyslipidemia"];
        }
        
        if ([self.diag_dictionary valueForKey:@"diag_CoronaryArteryDisease"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_CoronaryArteryDisease"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_CoronaryArteryDisease"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
           [self.diag_dictionary setObject:noneN forKey:@"diag_CoronaryArteryDisease"];
        }
        
        //+++++++++++++++++++++
        //    s_diag_DiabetesMellitus;
        //    s_diag_SpinalCordInjury;
        //    s_diag_PelvicTrauma;
        //    s_diag_PenileTrauma;

        if ([self.diag_dictionary valueForKey:@"diag_DiabetesMellitus"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_DiabetesMellitus"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_DiabetesMellitus"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_DiabetesMellitus"];
        }
        
        if ([self.diag_dictionary valueForKey:@"diag_SpinalCordInjury"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_SpinalCordInjury"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_SpinalCordInjury"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_SpinalCordInjury"];
        }
        
        if ([self.diag_dictionary valueForKey:@"diag_PelvicTrauma"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PelvicTrauma"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_PelvicTrauma"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_PelvicTrauma"];
        }
        
        //+++++++++++++++++++++++++++++
        
        if ([self.diag_dictionary valueForKey:@"diag_PenileTrauma"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PenileTrauma"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"diag_PenileTrauma"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"diag_PenileTrauma"];
        }
    }
    //=============================================================================================================================================================
    //=============================================================================================================================================================

    if ([self.diag_dictionary valueForKey:@"s_diag_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.diag_dictionary valueForKey:@"s_diag_ErectileDysfunction"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_ErectileDysfunction"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_ErectileDysfunction"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_ErectileDysfunction"];
        }
        
        if ([self.diag_dictionary valueForKey:@"s_diag_PeyroniesDisease"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PeyroniesDisease"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_PeyroniesDisease"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_PeyroniesDisease"];
        }
        
        if ([self.diag_dictionary valueForKey:@"s_diag_ProstateCancer"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_ProstateCancer"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_ProstateCancer"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_ProstateCancer"];
        }
        
        //++++++++++++++++++++++++++++++++
        
        if ([self.diag_dictionary valueForKey:@"s_diag_Hypertension"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_Hypertension"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_Hypertension"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_Hypertension"];
        }
        
        if ([self.diag_dictionary valueForKey:@"s_diag_Dyslipidemia"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_Dyslipidemia"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_Dyslipidemia"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_Dyslipidemia"];
        }
        
        if ([self.diag_dictionary valueForKey:@"s_diag_CoronaryArteryDisease"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_CoronaryArteryDisease"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_CoronaryArteryDisease"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_CoronaryArteryDisease"];
        }
        
        //++++++++++++++++++++++++++++++
        //    s_diag_DiabetesMellitus;
        //    s_diag_SpinalCordInjury;
        //    s_diag_PelvicTrauma;
        //    s_diag_PenileTrauma;
        if ([self.diag_dictionary valueForKey:@"s_diag_DiabetesMellitus"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_DiabetesMellitus"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_DiabetesMellitus"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_DiabetesMellitus"];
        }
        if ([self.diag_dictionary valueForKey:@"s_diag_SpinalCordInjury"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_SpinalCordInjury"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_SpinalCordInjury"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_SpinalCordInjury"];
        }
        if ([self.diag_dictionary valueForKey:@"s_diag_PelvicTrauma"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PelvicTrauma"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_PelvicTrauma"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_PelvicTrauma"];
        }
        if ([self.diag_dictionary valueForKey:@"s_diag_PenileTrauma"] != nil) {
            NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PenileTrauma"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_PenileTrauma"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.diag_dictionary setObject:noneN forKey:@"s_diag_PenileTrauma"];
        }
    }
    //=============================================================================================================================================================
    //=============================================================================================================================================================
    //=============================================================================================================================================================

    
    controller.diag_dictionary = self.diag_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];

}




-(void) irrigationAntiUsed{
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"Irrigation";
    
    controller.irri_dictionary = [[NSMutableDictionary alloc] init];
    //irri_Neomycin
    //irri_Bacitracin
    //irri_Gentamicin
    //irri_Vancomycin
    //irri_AmphotericinB
    //irri_Rifampin
    if ([self.irri_dictionary valueForKey:@"irri_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.irri_dictionary valueForKey:@"irri_Neomycin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Neomycin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Neomycin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Neomycin"];
        }
        if ([self.irri_dictionary valueForKey:@"irri_Bacitracin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Bacitracin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Bacitracin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Bacitracin"];
        }
        if ([self.irri_dictionary valueForKey:@"irri_Gentamicin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Gentamicin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Gentamicin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Gentamicin"];
        }
        if ([self.irri_dictionary valueForKey:@"irri_Vancomycin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Vancomycin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Vancomycin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Vancomycin"];
        }
        if ([self.irri_dictionary valueForKey:@"irri_AmphotericinB"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_AmphotericinB"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"irri_AmphotericinB"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"irri_AmphotericinB"];
        }
        if ([self.irri_dictionary valueForKey:@"irri_Rifampin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Rifampin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Rifampin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"irri_Rifampin"];
        }
    }
    if ([self.irri_dictionary valueForKey:@"s_irri_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.irri_dictionary valueForKey:@"s_irri_Neomycin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Neomycin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Neomycin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Neomycin"];
        }
        if ([self.irri_dictionary valueForKey:@"s_irri_Bacitracin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Bacitracin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Bacitracin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Bacitracin"];
        }
        if ([self.irri_dictionary valueForKey:@"s_irri_Gentamicin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Gentamicin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Gentamicin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Gentamicin"];
        }
        if ([self.irri_dictionary valueForKey:@"s_irri_Vancomycin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Vancomycin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Vancomycin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Vancomycin"];
        }
        if ([self.irri_dictionary valueForKey:@"s_irri_AmphotericinB"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_AmphotericinB"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_AmphotericinB"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_AmphotericinB"];
        }
        if ([self.irri_dictionary valueForKey:@"s_irri_Rifampin"] != nil) {
            NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Rifampin"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Rifampin"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.irri_dictionary setObject:noneN forKey:@"s_irri_Rifampin"];
        }
    }

    
    controller.irri_dictionary = self.irri_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)Complications{
    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"Complications";

    controller.comp_dictionary = [[NSMutableDictionary alloc] init];
    if ([self.comp_dictionary valueForKey:@"comp_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.comp_dictionary valueForKey:@"comp_none"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_none"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"comp_none"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"comp_none"];
        }
        if ([self.comp_dictionary valueForKey:@"comp_open"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_open"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"comp_open"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"comp_open"];
        }
        if ([self.comp_dictionary valueForKey:@"comp_bowel"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_bowel"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"comp_bowel"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"comp_bowel"];
        }
        if ([self.comp_dictionary valueForKey:@"comp_rectal"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_rectal"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"comp_rectal"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"comp_rectal"];
        }
        if ([self.comp_dictionary valueForKey:@"comp_transfusion"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_transfusion"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"comp_transfusion"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"comp_transfusion"];
        }
        
    }
    if ([self.comp_dictionary valueForKey:@"s_comp_sum"] != nil) {
        NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_sum"] ;
        int sum = [getNumberFromDictionary integerValue];
        if ([self.comp_dictionary valueForKey:@"s_comp_none"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_none"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_none"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_none"];
        }
        if ([self.comp_dictionary valueForKey:@"s_comp_open"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_open"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_open"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_open"];
        }
        if ([self.comp_dictionary valueForKey:@"s_comp_bowel"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_bowel"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_bowel"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_bowel"];
        }
        if ([self.comp_dictionary valueForKey:@"s_comp_rectal"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_rectal"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_rectal"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_rectal"];
        }
        if ([self.comp_dictionary valueForKey:@"s_comp_transfusion"] != nil) {
            NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_transfusion"] ;
            int none = [getNumberFromDictionary integerValue] ;
            none = none*100/sum;
            NSNumber *noneN = [NSNumber numberWithInt:none];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_transfusion"];
        } else {
            NSNumber *noneN = [NSNumber numberWithInt:0];
            [self.comp_dictionary setObject:noneN forKey:@"s_comp_transfusion"];
        }
        
    }

    controller.comp_dictionary = self.comp_dictionary;
    
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];
    

    
}


-(void)AverageAgeOfPatient{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"AverageAge";
    if (!self.selectedCases.count) {
        controller.averageAge = 0;
        controller.maxAge = 0;
        controller.minAge = 0;
    }else {
        if(sumOfAges<=0)
            sumOfAges = 100;
        controller.averageAge = sumOfAges/self.selectedCases.count;
        controller.maxAge = maxAge;
        controller.minAge = minAge;

    }
    
    
    if (!self.isNationalData) {
        
        if(!self.surgeonCases.count){
            if(sur_sumOfAges<=0)
                sur_sumOfAges = 100;
            controller.sur_averageAge = 0;
            controller.sur_maxAge = 0;
            controller.sur_minAge = 0;
            controller.isNationalData = YES;
        }else{
            if(sur_sumOfAges<=0)
                sur_sumOfAges = 100;
            controller.sur_averageAge = sur_sumOfAges/self.surgeonCases.count;
            controller.sur_maxAge = sur_maxAge;
            controller.sur_minAge = sur_minAge;
            controller.isNationalData = YES;
        }
        

        
    }
    
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    NSLog(@"%i",self.totalSurgeonCount);
    NSLog(@"%i",controller.SurgeonSize);
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)MaleFemale{

    [self reset];
    [self CalculateValues];
    
    float percentage = (maleCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"MaleFemale";
    if (!self.selectedCases.count) {
        
        controller.malePercentage = 0;
    }else {
        controller.malePercentage = percentage;
    }
    
    if (!self.isNationalData) {
        percentage = (sur_maleCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            
            controller.sur_malePercentage = 0;
        }else {
            controller.sur_malePercentage = percentage;
        }
        controller.sur_malePercentage = percentage;
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)BMI{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"BMI";
    if (!self.selectedCases.count) {
        
        controller.bmiPercentage = 0;
        controller.maxBmi = 0;
        controller.minBmi = 0;
    }else {
        controller.bmiPercentage = bmiCount/self.selectedCases.count;
        controller.maxBmi = maxBmi;
        controller.minBmi = minBmi;
    }

    NSLog(@"%hhd", isNationalData);
    if (!self.isNationalData) {
        if (!self.surgeonCases.count) {
            controller.sur_bmiPercentage = 0;
            controller.sur_maxBmi = 0;
            controller.sur_minBmi = 0;
        } else{
            controller.sur_bmiPercentage = sur_bmiCount/self.surgeonCases.count;
            controller.sur_maxBmi = sur_maxBmi;
            controller.sur_minBmi = sur_minBmi;
        }
        
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)LeftRightRenalMass{

    [self reset];
    [self CalculateValues];
    
    float percentage = (LRMCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"LeftRightRenal";
    if (!self.selectedCases.count) {
        controller.LRMPercentage = 0;

    } else{
        controller.LRMPercentage = percentage;

    }
    controller.LRMPercentage = percentage;
    
    if (!self.isNationalData) {

        percentage = (sur_LRMCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_LRMPercentage = 0;
            
        } else{
            controller.sur_LRMPercentage = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)CytoStent{

    [self reset];
    [self CalculateValues];
    
    float percentage = (cytoStentCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"CytoStent";
    
    controller.cytoStentPercentage = percentage;
    if (!self.selectedCases.count) {
        controller.cytoStentPercentage = 0;
        
    } else{
        controller.cytoStentPercentage = percentage;
        
    }
    if (!self.isNationalData) {
        percentage = (sur_cytoStentCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_cytoStentPercentage = 0;
            
        } else{
            controller.sur_cytoStentPercentage = percentage;
            
        }

        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)TumorSize{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"TumorSize";
    if (!self.selectedCases.count) {
        controller.tumorSizePercentage = 0;
        controller.maxTumorSize = 0;
        controller.minTumorSize = 0;
    } else{
        controller.tumorSizePercentage = tumorSizeCount/self.selectedCases.count;
        controller.maxTumorSize = maxTumorSize;
        controller.minTumorSize = minTumorSize;
    }

    
    if (!self.isNationalData) {
        if (!self.surgeonCases.count) {
            controller.sur_tumorSizePercentage = 0;
            controller.sur_maxTumorSize = 0;
            controller.sur_minTumorSize = 0;
        } else{
            controller.sur_tumorSizePercentage = sur_tumorSizeCount/self.surgeonCases.count;
            controller.sur_maxTumorSize = sur_maxTumorSize;
            controller.sur_minTumorSize = sur_minTumorSize;
        }

        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
//-(void)TumorCharacteristics{}
-(void)AdhesiolysisRequired{

    [self reset];
    [self CalculateValues];
    float percentage=0;
    percentage = (adhesiolysisCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"Adhesiolysis";
    if (!self.selectedCases.count) {
        controller.requiredPercentage = 0;

    } else{
        controller.requiredPercentage = percentage;

    }
    
    if (!self.isNationalData) {
        percentage = (sur_adhesiolysisCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_requiredPercentage = 0;
       
        } else{
            controller.sur_requiredPercentage = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)VascularAnomoly{

    [self reset];
    [self CalculateValues];
    
    float percentage=0;
    percentage = (vasAnomolyCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"VasAnomoly";
    if (!self.selectedCases.count) {
        controller.anomoliesPercentage = 0;
        
    } else{
        controller.anomoliesPercentage = percentage;
        
    }
    
    if (!self.isNationalData) {
        percentage = (sur_vasAnomolyCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_anomoliesPercentage = 0;
            
        } else{
            controller.sur_anomoliesPercentage = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)IntraOpUltraSound{

    [self reset];
    [self CalculateValues];
    
    float percentage=0;
    percentage = (intraOpUSCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"IOUS";
    
    if (!self.selectedCases.count) {
        controller.iousPercentage = 0;
        
    } else{
        controller.iousPercentage = percentage;
        
    }
    if (!self.isNationalData) {
        percentage = (sur_intraOpUSCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.iousPercentage = 0;
            
        } else{
            controller.iousPercentage = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)DeepMargins{

    [self reset];
    [self CalculateValues];
    
    float percentage=0;
    percentage = (positiveDMargins/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"DeepMargins";
    
    controller.dmPositive = percentage;
    if (!self.selectedCases.count) {
        controller.dmPositive = 0;
        
    } else{
        controller.dmPositive = percentage;
        
    }
    if (!self.isNationalData) {
        percentage = (sur_positiveDMargins/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_dmPositive = 0;
            
        } else{
            controller.sur_dmPositive = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
}
//-(void)Margins{}
-(void)RenalSystemRepair{

    [self reset];
    [self CalculateValues];
    
    float  percentage = (renalSRCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"RenalSR";
    if (!self.selectedCases.count) {
        controller.renalRSPercentage = 0;
        
    } else{
        controller.renalRSPercentage = percentage;
        
    }

    if (!self.isNationalData) {
        percentage = (sur_renalSRCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_renalRSPercentage = 0;
            
        } else{
            controller.sur_renalRSPercentage = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)AverageClampTime{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"ClampTime";
    if (!self.selectedCases.count) {
        controller.clampTimePercentage = 0;
        controller.maxClampTime = 0;
        controller.minClampTime = 0;
    } else{
        controller.clampTimePercentage = clampTimeCount/self.selectedCases.count;
        controller.maxClampTime = maxClampTime;
        controller.minClampTime = minClampTime;
    }

    
    if (!self.isNationalData) {
        if (!self.surgeonCases.count) {
            controller.sur_clampTimePercentage = 0;
            controller.sur_maxClampTime = 0;
            controller.sur_minClampTime = 0;
        } else{
            controller.sur_clampTimePercentage = sur_clampTimeCount/self.surgeonCases.count;
            controller.sur_maxClampTime = sur_maxClampTime;
            controller.sur_minClampTime = sur_minClampTime;
        }


        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
-(void)Coagulants{

    [self reset];
    [self CalculateValues];
    
    float percentage = (coagulantCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"Coagulant";
    
    if (!self.selectedCases.count) {
        controller.coagulantPercentage = 0;

    } else{
        controller.coagulantPercentage = percentage;

    }
    if (!self.isNationalData) {
        percentage = (sur_coagulantCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_coagulantPercentage = 0;
            
        } else{
            controller.sur_coagulantPercentage = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)BloodLoss{

    [self reset];
    [self CalculateValues];

    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];

    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        controller.graphToDraw = @"BloodLoss";
        if (!self.selectedCases.count) {
            controller.bloodLossPercentage = 0;
            controller.minBloodLoss = 0;
            controller.maxBloodLoss = 0;
        } else{
            controller.bloodLossPercentage = bloodLossCount/self.selectedCases.count;
            controller.minBloodLoss = minBloodLoss;
            controller.maxBloodLoss = maxBloodLoss;
        }
        if (!self.isNationalData) {
            if (!self.surgeonCases.count) {
                controller.sur_bloodLossPercentage = 0;
                controller.sur_minBloodLoss = 0;
                controller.sur_maxBloodLoss = 0;
            } else{
                controller.sur_bloodLossPercentage = sur_bloodLossCount/self.surgeonCases.count;
                controller.sur_minBloodLoss = sur_minBloodLoss;
                controller.sur_maxBloodLoss = sur_maxBloodLoss;
            }
            controller.isNationalData = YES;
        }
        
        controller.NationalSize = self.totalNationalCount;
        controller.SurgeonSize = self.totalSurgeonCount;
        //controller.NationalSize = [self.selectedCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
  
    }else{
        controller.graphToDraw = @"BloodLoss";
        if (!self.selectedCases.count) {
            controller.bloodLossPercentage = 0;
            controller.minBloodLoss = 0;
            controller.maxBloodLoss = 0;
        } else{
            controller.bloodLossPercentage = bloodLossCount/self.selectedCases.count;
            controller.minBloodLoss = minBloodLoss;
            controller.maxBloodLoss = maxBloodLoss;
        }

        
        if (!self.isNationalData) {
            if (!self.surgeonCases.count) {
                controller.sur_bloodLossPercentage = 0;
                controller.sur_minBloodLoss = 0;
                controller.sur_maxBloodLoss = 0;
            } else{
                controller.sur_bloodLossPercentage = sur_bloodLossCount/self.surgeonCases.count;
                controller.sur_minBloodLoss = sur_minBloodLoss;
                controller.sur_maxBloodLoss = sur_maxBloodLoss;
            }

            controller.isNationalData = YES;
        }
        
        controller.NationalSize = self.totalNationalCount;
        controller.SurgeonSize = self.totalSurgeonCount;
        //controller.NationalSize = [self.selectedCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)ConsoleTime{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"ConsoleTime";
    if (!self.selectedCases.count) {
        controller.consolePercentage = 0;
        controller.maxConsoleTime = 0;
        controller.minConsoleTime = 0;
    } else{
        controller.consolePercentage = consoleTimeCount/self.selectedCases.count;
        controller.maxConsoleTime = maxConsoleTime;
        controller.minConsoleTime = minConsoleTime;
    }

    
    if (!self.isNationalData) {
        if (!self.surgeonCases.count) {
            controller.sur_consolePercentage = 0;
            controller.sur_maxConsoleTime = 0;
            controller.sur_minConsoleTime = 0;
        } else{
            controller.sur_consolePercentage = sur_consoleTimeCount/self.surgeonCases.count;
            controller.sur_maxConsoleTime = sur_maxConsoleTime;
            controller.sur_minConsoleTime = sur_minConsoleTime;
        }

        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)RoomTime{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"RoomTime";
    if (!self.selectedCases.count) {
        controller.roomTimePercentage = 0;
        controller.minRoomTime = 0;
        controller.maxRoomTime = 0;
    } else{
        controller.roomTimePercentage = roomTimeCount/self.selectedCases.count;
        controller.minRoomTime = minRoomTime;
        controller.maxRoomTime = maxRoomTime;
    }

    
    if (!self.isNationalData) {
        if (!self.surgeonCases.count) {
            controller.sur_roomTimePercentage = 0;
            controller.sur_minRoomTime = 0;
            controller.sur_maxRoomTime = 0;
        } else{
            controller.sur_roomTimePercentage = sur_roomTimeCount/self.surgeonCases.count;
            controller.sur_minRoomTime = sur_minRoomTime;
            controller.sur_maxRoomTime = sur_maxRoomTime;
        }

        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    [self.navigationController pushViewController:controller animated:YES];
    
}
//-(void)Complications{}
-(void)TransfusionRequired{

    [self reset];
    [self CalculateValues];
    
    float percentage = 0;
    percentage = (transfusionCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"Transfusion";
    if (!self.selectedCases.count) {
        controller.transfusionPercentage = 0;

    } else{
        controller.transfusionPercentage = percentage;

    }
    
    if (!self.isNationalData) {
        percentage = (sur_transfusionCount/self.surgeonCases.count)*100;
        if (!self.surgeonCases.count) {
            controller.sur_transfusionPercentage = 0;
            
        } else{
            controller.sur_transfusionPercentage = percentage;
            
        }
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)reset{
    sumOfAges=0;
    positiveDMargins = 0;
    maleCount = 0;
    LRMCount = 0;
    cytoStentCount=0;
    adhesiolysisCount=0;
    vasAnomolyCount=0;
    intraOpUSCount=0;
    renalSRCount=0;
    coagulantCount=0;
    transfusionCount=0;
    consoleTimeCount=0;
    roomTimeCount=0;
    clampTimeCount=0;
    bloodLossCount=0;
    tumorSizeCount=0;
    bmiCount=0;
    maxAge=0;
    minAge=0;
    minBmi=0;
    maxBmi=0;
    minClampTime=0;
    maxClampTime=0;
    minConsoleTime=0;
    maxConsoleTime=0;
    minRoomTime=0;
    maxRoomTime=0;
    minBloodLoss=0;
    maxBloodLoss=0;
    minTumorSize=0;
    maxTumorSize=0;
    
    sur_sumOfAges=0;
    sur_positiveDMargins = 0;
    sur_maleCount = 0;
    sur_LRMCount = 0;
    sur_cytoStentCount=0;
    sur_adhesiolysisCount=0;
    sur_vasAnomolyCount=0;
    sur_intraOpUSCount=0;
    sur_renalSRCount=0;
    sur_coagulantCount=0;
    sur_transfusionCount=0;
    sur_consoleTimeCount=0;
    sur_roomTimeCount=0;
    sur_clampTimeCount=0;
    sur_bloodLossCount=0;
    sur_tumorSizeCount=0;
    sur_bmiCount=0;
    sur_maxAge=0;
    sur_minAge=0;
    sur_minBmi=0;
    sur_maxBmi=0;
    sur_minClampTime=0;
    sur_maxClampTime=0;
    sur_minConsoleTime=0;
    sur_maxConsoleTime=0;
    sur_minRoomTime=0;
    sur_maxRoomTime=0;
    sur_minBloodLoss=0;
    sur_maxBloodLoss=0;
    sur_minTumorSize=0;
    sur_maxTumorSize=0;
}

-(void)CalculateValues{
    
    if ([_procID isEqualToString:@"2"]) {
        
    
        for(int i=0;i<self.selectedCases.count;i++){
            
            NSDictionary *dic = [self.selectedCases objectAtIndex:i];
            NSString *dob = [dic valueForKey:@"var_patientDOB"];
            // NSString *dos = [dic objectForKey:@"DateOfService"];
            float age = [self CalculateAge:dob];
            NSLog(@" ^^^^ Age Retreived :: %f",age);
            sumOfAges+= age;
            if(i == 0){
                maxAge = age;
                minAge = age;
            }
            else{
                if(age>maxAge){
                    maxAge = age;
                }
                if(age<minAge){
                    minAge = age;
                }
            }
            if(![[dic valueForKey:@"var_margin"] isEqualToString:@"NO"]){
                positiveDMargins+=1;
            }
            if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
                maleCount+=1;
            }
            if([[dic valueForKey:@"var_preOp"] isEqualToString:@"Left renal mass"]){
                LRMCount+=1;
            }
            if(![[dic valueForKey:@"var_cysto"] isEqualToString:@"NO"]){
                cytoStentCount+=1;
            }
            if(![[dic valueForKey:@"var_adhTook"] isEqualToString:@"NO"]){
                adhesiolysisCount+=1;
            }
            if(![[dic valueForKey:@"var_vasAnomolies"] isEqualToString:@"NO"]){
                vasAnomolyCount+=1;
            }
            if(![[dic valueForKey:@"var_renalUltraSound"] isEqualToString:@"NO"]){
                intraOpUSCount+=1;
            }
            if(![[dic valueForKey:@"var_RCSRepair"] isEqualToString:@"NO"]){
                renalSRCount+=1;
            }
            if(![[dic valueForKey:@"var_coagulant"] isEqualToString:@"NO"]){
                coagulantCount+=1;
            }
            if(![[dic valueForKey:@"var_transfusion"] isEqualToString:@"NO"]){
                transfusionCount+=1;
            }
            if([dic valueForKey:@"var_tumorSize"]){
                float tsize =[[dic valueForKey:@"var_tumorSize"] floatValue];
                tumorSizeCount+=tsize;
                if(i == 0){
                    minTumorSize = tsize;
                    maxTumorSize = tsize;
                }else{
                    if(tsize>maxTumorSize){
                        maxTumorSize = tsize;
                    }
                    if(tsize<minTumorSize){
                        minTumorSize = tsize;
                    }
                }
            }
            if([dic valueForKey:@"var_bmi"]){
                float bmi = [[dic valueForKey:@"var_bmi"] floatValue];
                bmiCount+= bmi;
                if(i == 0){
                    minBmi = bmi;
                    maxBmi = bmi;
                }else{
                    if(bmi>maxBmi){
                        maxBmi = bmi;
                    }
                    if(bmi<minBmi){
                        minBmi = bmi;
                    }
                }
            }
            if([dic valueForKey:@"var_counselTime"]){
                NSString *str = [dic valueForKey:@"var_counselTime"];
                NSArray *ary = [str componentsSeparatedByString:@" "];
                int val = [[ary objectAtIndex:0] intValue];
                NSLog(@" ***** Value Retreived  ::  %i",val);
                consoleTimeCount+=val;
                if(i == 0){
                    minConsoleTime = val;
                    maxConsoleTime = val;
                }else{
                    if(val>maxConsoleTime){
                        maxConsoleTime = val;
                    }
                    if(val<minConsoleTime){
                        minConsoleTime = val;
                    }
                }
            }
            if([dic valueForKey:@"var_roomTime"]){
                NSString *str = [dic valueForKey:@"var_roomTime"];
                NSArray *ary = [str componentsSeparatedByString:@" "];
                int val = [[ary objectAtIndex:0] intValue];
                NSLog(@" ***** Value for Room Time Retreived  ::  %i",val);
                roomTimeCount+=val;
                if(i == 0){
                    minRoomTime = val;
                    maxRoomTime = val;
                }else{
                    if(val>maxRoomTime){
                        maxRoomTime = val;
                    }
                    if(val<minRoomTime){
                        minRoomTime = val;
                    }
                }
            }
            if([dic valueForKey:@"var_clamp"]){
                NSString *str = [dic valueForKey:@"var_clamp"];
                NSArray *ary = [str componentsSeparatedByString:@" "];
                int val = [[ary objectAtIndex:0] intValue];
                NSLog(@" ***** Value for Clamp Time Retreived  ::  %i",val);
                clampTimeCount+=val;
                if(i == 0){
                    minClampTime = val;
                    maxClampTime = val;
                }else{
                    if(val>maxClampTime){
                        maxClampTime = val;
                    }
                    if(val<minClampTime){
                        minClampTime = val;
                    }
                }
                
            }
            if([dic valueForKey:@"var_bloodLoss"]){
                NSString *str = [dic valueForKey:@"var_bloodLoss"];
                NSArray *ary = [str componentsSeparatedByString:@" "];
                int val = [[ary objectAtIndex:0] intValue];
                NSLog(@" ***** Value for  Blood Loss Retreived  ::  %i",val);
                bloodLossCount+=val;
                if(i == 0){
                    minBloodLoss = val;
                    maxBloodLoss = val;
                }else{
                    if(val>maxBloodLoss){
                        maxBloodLoss = val;
                    }
                    if(val<minBloodLoss){
                        minBloodLoss = val;
                    }
                }
            }
        }
    //isCalculated = YES;
    // }
    
    for(int i=0;i<self.surgeonCases.count;i++){
        
        NSDictionary *dic = [self.surgeonCases objectAtIndex:i];
        NSString *dob = [dic valueForKey:@"var_patientDOB"];
        // NSString *dos = [dic objectForKey:@"DateOfService"];
        float age = [self CalculateAge:dob];
        NSLog(@" ^^^^ Age Retreived :: %f",age);
        sur_sumOfAges+= age;
        if(i == 0){
            sur_maxAge = age;
            sur_minAge = age;
        }
        else{
            if(age>sur_maxAge){
                sur_maxAge = age;
            }
            if(age<sur_minAge){
                sur_minAge = age;
            }
        }
        if(![[dic valueForKey:@"var_margin"] isEqualToString:@"NO"]){
            sur_positiveDMargins+=1;
        }
        if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
            sur_maleCount+=1;
        }
        if([[dic valueForKey:@"var_preOp"] isEqualToString:@"Left renal mass"]){
            sur_LRMCount+=1;
        }
        if(![[dic valueForKey:@"var_cysto"] isEqualToString:@"NO"]){
            sur_cytoStentCount+=1;
        }
        if(![[dic valueForKey:@"var_adhTook"] isEqualToString:@"NO"]){
            sur_adhesiolysisCount+=1;
        }
        if(![[dic valueForKey:@"var_vasAnomolies"] isEqualToString:@"NO"]){
            sur_vasAnomolyCount+=1;
        }
        if(![[dic valueForKey:@"var_renalUltraSound"] isEqualToString:@"NO"]){
            sur_intraOpUSCount+=1;
        }
        if(![[dic valueForKey:@"var_RCSRepair"] isEqualToString:@"NO"]){
            sur_renalSRCount+=1;
        }
        if(![[dic valueForKey:@"var_coagulant"] isEqualToString:@"NO"]){
            sur_coagulantCount+=1;
        }
        if(![[dic valueForKey:@"var_transfusion"] isEqualToString:@"NO"]){
            sur_transfusionCount+=1;
        }
        if([dic valueForKey:@"var_tumorSize"]){
            float tsize =[[dic valueForKey:@"var_tumorSize"] floatValue];
            sur_tumorSizeCount+=tsize;
            if(i == 0){
                sur_minTumorSize = tsize;
                sur_maxTumorSize = tsize;
            }else{
                if(tsize>sur_maxTumorSize){
                    sur_maxTumorSize = tsize;
                }
                if(tsize<sur_minTumorSize){
                    sur_minTumorSize = tsize;
                }
            }
        }
        if([dic valueForKey:@"var_bmi"]){
            float bmi = [[dic valueForKey:@"var_bmi"] floatValue];
            sur_bmiCount+= bmi;
            if(i == 0){
                sur_minBmi = bmi;
                sur_maxBmi = bmi;
            }else{
                if(bmi>sur_maxBmi){
                    sur_maxBmi = bmi;
                }
                if(bmi<sur_minBmi){
                    sur_minBmi = bmi;
                }
            }
        }
        if([dic valueForKey:@"var_counselTime"]){
            NSString *str = [dic valueForKey:@"var_counselTime"];
            NSArray *ary = [str componentsSeparatedByString:@" "];
            int val = [[ary objectAtIndex:0] intValue];
            NSLog(@" ***** Value Retreived  ::  %i",val);
            sur_consoleTimeCount+=val;
            if(i == 0){
                sur_minConsoleTime = val;
                sur_maxConsoleTime = val;
            }else{
                if(val>sur_maxConsoleTime){
                    sur_maxConsoleTime = val;
                }
                if(val<sur_minConsoleTime){
                    sur_minConsoleTime = val;
                }
            }
        }
        if([dic valueForKey:@"var_roomTime"]){
            NSString *str = [dic valueForKey:@"var_roomTime"];
            NSArray *ary = [str componentsSeparatedByString:@" "];
            int val = [[ary objectAtIndex:0] intValue];
            NSLog(@" ***** Value for Room Time Retreived  ::  %i",val);
            sur_roomTimeCount+=val;
            if(i == 0){
                sur_minRoomTime = val;
                sur_maxRoomTime = val;
            }else{
                if(val>sur_maxRoomTime){
                    sur_maxRoomTime = val;
                }
                if(val<sur_minRoomTime){
                    sur_minRoomTime = val;
                }
            }
        }
        if([dic valueForKey:@"var_clamp"]){
            NSString *str = [dic valueForKey:@"var_clamp"];
            NSArray *ary = [str componentsSeparatedByString:@" "];
            int val = [[ary objectAtIndex:0] intValue];
            NSLog(@" ***** Value for Clamp Time Retreived  ::  %i",val);
            sur_clampTimeCount+=val;
            if(i == 0){
                sur_minClampTime = val;
                sur_maxClampTime = val;
            }else{
                if(val>sur_maxClampTime){
                    sur_maxClampTime = val;
                }
                if(val<sur_minClampTime){
                    sur_minClampTime = val;
                }
            }
            
        }
        if([dic valueForKey:@"var_bloodLoss"]){
            NSString *str = [dic valueForKey:@"var_bloodLoss"];
            NSArray *ary = [str componentsSeparatedByString:@" "];
            int val = [[ary objectAtIndex:0] intValue];
            NSLog(@" ***** Value for  Blood Loss Retreived  ::  %i",val);
            sur_bloodLossCount+=val;
            if(i == 0){
                sur_minBloodLoss = val;
                sur_maxBloodLoss = val;
            }else{
                if(val>sur_maxBloodLoss){
                    sur_maxBloodLoss = val;
                }
                if(val<sur_minBloodLoss){
                    sur_minBloodLoss = val;
                }
            }
        }
    }
//==============================================================================================================================
//==============================================================================================================================
//==============================================================================================================================
    } else if([_procID isEqualToString:@"9"]){
        for(int i=0;i<self.selectedCases.count;i++){
            
            NSDictionary *dic = [self.selectedCases objectAtIndex:i];
            NSString *dob = [dic valueForKey:@"var_patientDOB"];
            // NSString *dos = [dic objectForKey:@"DateOfService"];
            float age = [self CalculateAge:dob];
            NSLog(@" ^^^^ Age Retreived :: %f",age);
            sumOfAges+= age;
            if(i == 0){
                maxAge = age;
                minAge = age;
            }
            else{
                if(age>maxAge){
                    maxAge = age;
                }
                if(age<minAge){
                    minAge = age;
                }
            }
            //male - drain placed
            if([[dic valueForKey:@"var_drainplaced"] isEqualToString:@"YES"]){
                maleCount+=1;
            }
            
            //tumor
            if([dic valueForKey:@"var_reservoirfilled"]){
                float tsize =[[dic valueForKey:@"var_reservoirfilled"] floatValue];
                tumorSizeCount+=tsize;
                if(i == 0){
                    minTumorSize = tsize;
                    maxTumorSize = tsize;
                }else{
                    if(tsize>maxTumorSize){
                        maxTumorSize = tsize;
                    }
                    if(tsize<minTumorSize){
                        minTumorSize = tsize;
                    }
                }
            }
            //bmi
            if([dic valueForKey:@"var_devicelength"]){
                float bmi = [[dic valueForKey:@"var_devicelength"] floatValue];
                bmiCount+= bmi;
                if(i == 0){
                    minBmi = bmi;
                    maxBmi = bmi;
                }else{
                    if(bmi>maxBmi){
                        maxBmi = bmi;
                    }
                    if(bmi<minBmi){
                        minBmi = bmi;
                    }
                }
            }
            //cysto
            if(![[dic valueForKey:@"var_complications"] isEqualToString:@"NO"]){
                cytoStentCount+=1;
            }
            //preop - renal mass
            if([[dic valueForKey:@"var_reservoirside"] isEqualToString:@"Left renal mass"]){
                LRMCount+=1;
            }
            
            //===============================================================================================
            //Irrigation antibiotics used (Neomycin, Bacitracin, Gentamicin, Vancomycin, Amphotericin B, Rifampin), multiple choices can be selected
            NSString *factors = [dic valueForKey:@"var_irrigationantibiotics"];
            NSArray *factorsA = [factors componentsSeparatedByString:@"; "];
            NSNumber *s_irri_sumNumber = [NSNumber numberWithInt:i+1];
            [self.irri_dictionary setObject:s_irri_sumNumber forKey:@"irri_sum"];
            if ([factorsA containsObject:@"Neomycin"]) {
                if ([self.irri_dictionary valueForKey:@"irri_Neomycin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Neomycin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Neomycin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Neomycin"];
                }
            }
            if ([factorsA containsObject:@"Bacitracin"]) {
                if ([self.irri_dictionary valueForKey:@"irri_Bacitracin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Bacitracin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Bacitracin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Bacitracin"];
                }
            }
            if ([factorsA containsObject:@"Gentamicin"]) {
                if ([self.irri_dictionary valueForKey:@"irri_Gentamicin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Gentamicin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Gentamicin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Gentamicin"];
                }
            }
            if ([factorsA containsObject:@"Vancomycin"]) {
                if ([self.irri_dictionary valueForKey:@"irri_Vancomycin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Vancomycin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Vancomycin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Vancomycin"];
                }
            }
            if ([factorsA containsObject:@"Amphotericin B"]) {
                if ([self.irri_dictionary valueForKey:@"irri_AmphotericinB"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_AmphotericinB"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_AmphotericinB"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_AmphotericinB"];
                }
            }
            if ([factorsA containsObject:@"Rifampin"]) {
                if ([self.irri_dictionary valueForKey:@"irri_Rifampin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Rifampin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Rifampin"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"irri_Rifampin"];
                }
            }
            
            
            
            
            
            //===============================================================================================
            //Diagnosis (Erectile Dysfunction, Peyronie’s Disease, Prostate Cancer,
            //Hypertension, Dyslipidemia, Coronary Artery Disease,
            //Diabetes Mellitus, Spinal Cord Injury, Pelvic Trauma,
            //Penile Trauma), multiple may be chosen
            
            //    s_diag_ErectileDysfunction;
            //    s_diag_PeyroniesDisease;
            //   s_diag_ProstateCancer;
            //

            NSString *diag_factors = [dic valueForKey:@"var_diagnosis"];
            NSArray *diag_factorsA = [diag_factors componentsSeparatedByString:@"; "];
            NSNumber *diag_s_irri_sumNumber = [NSNumber numberWithInt:i+1];
            [self.diag_dictionary setObject:diag_s_irri_sumNumber forKey:@"diag_sum"];
            if ([diag_factorsA containsObject:@"Erectile Dysfunction"]) {
                if ([self.diag_dictionary valueForKey:@"diag_ErectileDysfunction"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_ErectileDysfunction"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_ErectileDysfunction"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_ErectileDysfunction"];
                }
            }
            if ([diag_factorsA containsObject:@"Peyronie’s Disease"]) {
                if ([self.diag_dictionary valueForKey:@"diag_PeyroniesDisease"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_PeyroniesDisease"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PeyroniesDisease"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_PeyroniesDisease"];
                }
            }
            if ([diag_factorsA containsObject:@"Prostate Cancer"]) {
                if ([self.diag_dictionary valueForKey:@"diag_ProstateCancer"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_ProstateCancer"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_ProstateCancer"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_ProstateCancer"];
                }
            }
            //    s_diag_Hypertension;
            //    s_diag_Dyslipidemia;
            //    s_diag_CoronaryArteryDisease;
            //

            //++++++++
            if ([diag_factorsA containsObject:@"Hypertension"]) {
                if ([self.diag_dictionary valueForKey:@"diag_Hypertension"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_Hypertension"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_Hypertension"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_Hypertension"];
                }
            }
            if ([diag_factorsA containsObject:@"Dyslipidemia"]) {
                if ([self.diag_dictionary valueForKey:@"diag_Dyslipidemia"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_Dyslipidemia"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_Dyslipidemia"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_Dyslipidemia"];
                }
            }
            if ([diag_factorsA containsObject:@"Coronary Artery Disease"]) {
                if ([self.diag_dictionary valueForKey:@"diag_CoronaryArteryDisease"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_CoronaryArteryDisease"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_CoronaryArteryDisease"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_CoronaryArteryDisease"];
                }
            }
            //    s_diag_DiabetesMellitus;
            //    s_diag_SpinalCordInjury;
            //    s_diag_PelvicTrauma;
            //    s_diag_PenileTrauma;
            //++++++++
            if ([diag_factorsA containsObject:@"Diabetes Mellitus"]) {
                if ([self.diag_dictionary valueForKey:@"diag_DiabetesMellitus"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_DiabetesMellitus"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_DiabetesMellitus"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_DiabetesMellitus"];
                }
            }
            if ([diag_factorsA containsObject:@"Spinal Cord Injury"]) {
                if ([self.diag_dictionary valueForKey:@"diag_SpinalCordInjury"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_SpinalCordInjury"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_SpinalCordInjury"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_SpinalCordInjury"];
                }
            }
            if ([diag_factorsA containsObject:@"Pelvic Trauma"]) {
                if ([self.diag_dictionary valueForKey:@"diag_PelvicTrauma"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_PelvicTrauma"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PelvicTrauma"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_PelvicTrauma"];
                }
            }
            //++++++++
            if ([diag_factorsA containsObject:@"Penile Trauma"]) {
                if ([self.diag_dictionary valueForKey:@"diag_PenileTrauma"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_PenileTrauma"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PenileTrauma"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"diag_PenileTrauma"];
                }
            }

            
            
           
            
            
            NSString *devimp_factors = [dic valueForKey:@"var_deviceimplaned"];
            NSNumber *devimp_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.devimp_dictionary setObject:devimp_s_comp_sumNumber forKey:@"devimp_sum"];
            if ([devimp_factors isEqualToString:@"AMS 700 CX"]) {
                if ([self.devimp_dictionary valueForKey:@"s_devimp_AMS700CX"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_AMS700CX"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700CX"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_AMS700CX"];
                }
            } else if ([devimp_factors isEqualToString:@"AMS 700 CXR"]) {
                if ([self.devimp_dictionary valueForKey:@"devimp_AMS700CXR"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_AMS700CXR"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700CXR"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_AMS700CXR"];
                }
            } else if ([devimp_factors isEqualToString:@"AMS 700 LGX"]) {
                if ([self.devimp_dictionary valueForKey:@"devimp_AMS700LGX"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_AMS700LGX"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700LGX"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_AMS700LGX"];
                }
            } else if ([devimp_factors isEqualToString:@"Coloplast Titan"]) {
                if ([self.devimp_dictionary valueForKey:@"devimp_ColoplastTitan"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_ColoplastTitan"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_ColoplastTitan"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"devimp_ColoplastTitan"];
                }
            }

            
            
            
            //diluse_dictionary
            NSString *diluse_factors = [dic valueForKey:@"var_dilatorsused"];
            NSNumber *diluse_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.diluse_dictionary setObject:diluse_s_comp_sumNumber forKey:@"diluse_sum"];
            if ([diluse_factors isEqualToString:@"Brooks"]) {
                if ([self.diluse_dictionary valueForKey:@"diluse_Brooks"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"diluse_Brooks"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Brooks"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"diluse_Brooks"];
                }
            } else if ([diluse_factors isEqualToString:@"Hegar"]) {
                if ([self.diluse_dictionary valueForKey:@"diluse_Hegar"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"diluse_Hegar"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Hegar"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"diluse_Hegar"];
                }
            } else if ([diluse_factors isEqualToString:@"Furlow"]) {
                if ([self.diluse_dictionary valueForKey:@"diluse_Furlow"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"diluse_Furlow"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Furlow"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"diluse_Furlow"];
                }
            }
            
            
            
            //s_dilwas_straightforward
            //s_dilwas_difficultduetoscarring
            //s_dilwas_difficultduetoanatomy
            NSString *dilwas_factors = [dic valueForKey:@"var_dilationwas"];
            NSNumber *dilwas_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.dilwas_dictionary setObject:dilwas_s_comp_sumNumber forKey:@"dilwas_sum"];
            if ([dilwas_factors isEqualToString:@"straightforward"]) {
                if ([self.dilwas_dictionary valueForKey:@"dilwas_straightforward"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"dilwas_straightforward"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_straightforward"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"dilwas_straightforward"];
                }
            } else if ([dilwas_factors isEqualToString:@"difficult due to scarring"]) {
                if ([self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoscarring"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"dilwas_difficultduetoscarring"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoscarring"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"dilwas_difficultduetoscarring"];
                }
            } else if ([dilwas_factors isEqualToString:@"difficult due to anatomy"]) {
                if ([self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoanatomy"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"dilwas_difficultduetoanatomy"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoanatomy"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"dilwas_difficultduetoanatomy"];
                }
            }
            
            //    s_restyp_Conceal
            //    s_restyp_Spherical
            //    s_restyp_Cloverleaf
            NSString *restyp_factors = [dic valueForKey:@"var_reservoirtype"];
            NSNumber *restyp_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.restyp_dictionary setObject:restyp_s_comp_sumNumber forKey:@"restyp_sum"];
            if ([restyp_factors isEqualToString:@"Conceal"]) {
                if ([self.restyp_dictionary valueForKey:@"restyp_Conceal"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"restyp_Conceal"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Conceal"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"restyp_Conceal"];
                }
            } else if ([restyp_factors isEqualToString:@"Spherical"]) {
                if ([self.restyp_dictionary valueForKey:@"restyp_Spherical"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"restyp_Spherical"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Spherical"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"restyp_Spherical"];
                }
            } else if ([restyp_factors isEqualToString:@"Cloverleaf"]) {
                if ([self.restyp_dictionary valueForKey:@"restyp_Cloverleaf"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"restyp_Cloverleaf"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Cloverleaf"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"restyp_Cloverleaf"];
                }
            }
            
            //s_dilto_9mm;
            //s_dilto_10mm;
            //s_dilto_11mm;
            //s_dilto_12mm;
            //s_dilto_13mm;
            //s_dilto_14mm;
            //s_dilto_na;
            NSString *dilto_factors = [dic valueForKey:@"var_dilatedto"];
            NSNumber *dilto_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.dilto_dictionary setObject:dilto_s_comp_sumNumber forKey:@"dilto_sum"];
            if ([dilto_factors isEqualToString:@"9mm"]) {
                if ([self.dilto_dictionary valueForKey:@"dilto_9mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_9mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_9mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_9mm"];
                }
            } else if ([dilto_factors isEqualToString:@"10mm"]) {
                if ([self.dilto_dictionary valueForKey:@"dilto_10mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_10mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_10mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_10mm"];
                }
            } else if ([dilto_factors isEqualToString:@"11mm"]) {
                if ([self.dilto_dictionary valueForKey:@"dilto_11mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_11mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_11mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_11mm"];
                }
                
                //s_dilto_12mm;
                //s_dilto_13mm;
                //s_dilto_14mm;
                //s_dilto_na;
            } else if ([dilto_factors isEqualToString:@"12mm"]) {
                if ([self.dilto_dictionary valueForKey:@"dilto_12mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_12mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_12mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_12mm"];
                }
            } else if ([dilto_factors isEqualToString:@"13mm"]) {
                if ([self.dilto_dictionary valueForKey:@"dilto_13mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_13mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_13mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_13mm"];
                }
            } else if ([dilto_factors isEqualToString:@"14mm"]) {
                if ([self.dilto_dictionary valueForKey:@"dilto_14mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_14mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_14mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_14mm"];
                }
            } else if ([dilto_factors isEqualToString:@"n/a"]) {
                if ([self.dilto_dictionary valueForKey:@"dilto_na"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_na"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_na"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"dilto_na"];
                }
            }

        }
//==============================================================================================================================
//==============================================================================================================================
//==============================================================================================================================
        
        for(int i=0;i<self.surgeonCases.count;i++){
            
            NSDictionary *dic = [self.surgeonCases objectAtIndex:i];
            NSString *dob = [dic valueForKey:@"var_patientDOB"];
            // NSString *dos = [dic objectForKey:@"DateOfService"];
            float age = [self CalculateAge:dob];
            NSLog(@" ^^^^ Age Retreived :: %f",age);
            sur_sumOfAges+= age;
            if(i == 0){
                sur_maxAge = age;
                sur_minAge = age;
            }
            else{
                if(age>sur_maxAge){
                    sur_maxAge = age;
                }
                if(age<sur_minAge){
                    sur_minAge = age;
                }
            }
            //male - drain placed
            if([[dic valueForKey:@"var_drainplaced"] isEqualToString:@"YES"]){
                maleCount+=1;
            }
            
            //tumor
            if([dic valueForKey:@"var_reservoirfilled"]){
                float tsize =[[dic valueForKey:@"var_reservoirfilled"] floatValue];
                sur_tumorSizeCount+=tsize;
                if(i == 0){
                    sur_minTumorSize = tsize;
                    sur_maxTumorSize = tsize;
                }else{
                    if(tsize>sur_maxTumorSize){
                        sur_maxTumorSize = tsize;
                    }
                    if(tsize<sur_minTumorSize){
                        sur_minTumorSize = tsize;
                    }
                }
            }
            //bmi
            if([dic valueForKey:@"var_devicelength"]){
                float bmi = [[dic valueForKey:@"var_devicelength"] floatValue];
                sur_bmiCount+= bmi;
                if(i == 0){
                    sur_minBmi = bmi;
                    sur_maxBmi = bmi;
                }else{
                    if(bmi>sur_maxBmi){
                        sur_maxBmi = bmi;
                    }
                    if(bmi<sur_minBmi){
                        sur_minBmi = bmi;
                    }
                }
            }
            //cysto
            if(![[dic valueForKey:@"var_complications"] isEqualToString:@"NO"]){
                sur_cytoStentCount+=1;
            }
            //preop - renal mass
            if([[dic valueForKey:@"var_reservoirside"] isEqualToString:@"Left renal mass"]){
                sur_LRMCount+=1;
            }
            
            NSString *factors = [dic valueForKey:@"var_irrigationantibiotics"];
            NSArray *factorsA = [factors componentsSeparatedByString:@"; "];
            NSNumber *s_irri_sumNumber = [NSNumber numberWithInt:i+1];
            [self.irri_dictionary setObject:s_irri_sumNumber forKey:@"s_irri_sum"];
            if ([factorsA containsObject:@"Neomycin"]) {
                if ([self.irri_dictionary valueForKey:@"s_irri_Neomycin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Neomycin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Neomycin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Neomycin"];
                }
            }
            if ([factorsA containsObject:@"Bacitracin"]) {
                if ([self.irri_dictionary valueForKey:@"s_irri_Bacitracin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Bacitracin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Bacitracin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Bacitracin"];
                }
            }
            if ([factorsA containsObject:@"Gentamicin"]) {
                if ([self.irri_dictionary valueForKey:@"s_irri_Gentamicin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Gentamicin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Gentamicin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Gentamicin"];
                }
            }
            if ([factorsA containsObject:@"Vancomycin"]) {
                if ([self.irri_dictionary valueForKey:@"s_irri_Vancomycin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Vancomycin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Vancomycin"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Vancomycin"];
                }
            }
            if ([factorsA containsObject:@"Amphotericin B"]) {
                if ([self.irri_dictionary valueForKey:@"s_irri_AmphotericinB"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_AmphotericinB"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_AmphotericinB"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_AmphotericinB"];
                }
            }
            if ([factorsA containsObject:@"Rifampin"]) {
                if ([self.irri_dictionary valueForKey:@"s_irri_Rifampin"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Rifampin"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Rifampin"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.irri_dictionary setObject:s_comp_noneNumber forKey:@"s_irri_Rifampin"];
                }
            }
            
            //===============================================================================================
            //Diagnosis (Erectile Dysfunction, Peyronie’s Disease, Prostate Cancer,
            //Hypertension, Dyslipidemia, Coronary Artery Disease,
            //Diabetes Mellitus, Spinal Cord Injury, Pelvic Trauma,
            //Penile Trauma), multiple may be chosen
            
            //    s_diag_ErectileDysfunction;
            //    s_diag_PeyroniesDisease;
            //   s_diag_ProstateCancer;
            //
            
            NSString *diag_factors = [dic valueForKey:@"var_diagnosis"];
            NSArray *diag_factorsA = [diag_factors componentsSeparatedByString:@"; "];
            NSNumber *diag_s_irri_sumNumber = [NSNumber numberWithInt:i+1];
            [self.diag_dictionary setObject:diag_s_irri_sumNumber forKey:@"s_diag_sum"];
            if ([diag_factorsA containsObject:@"Erectile Dysfunction"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_ErectileDysfunction"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_ErectileDysfunction"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_ErectileDysfunction"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_ErectileDysfunction"];
                }
            }
            if ([diag_factorsA containsObject:@"Peyronie’s Disease"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_PeyroniesDisease"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_PeyroniesDisease"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PeyroniesDisease"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_PeyroniesDisease"];
                }
            }
            if ([diag_factorsA containsObject:@"Prostate Cancer"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_ProstateCancer"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_ProstateCancer"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_ProstateCancer"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_ProstateCancer"];
                }
            }
            //    s_diag_Hypertension;
            //    s_diag_Dyslipidemia;
            //    s_diag_CoronaryArteryDisease;
            //
            
            //++++++++
            if ([diag_factorsA containsObject:@"Hypertension"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_Hypertension"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_Hypertension"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_Hypertension"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_Hypertension"];
                }
            }
            if ([diag_factorsA containsObject:@"Dyslipidemia"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_Dyslipidemia"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_Dyslipidemia"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_Dyslipidemia"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_Dyslipidemia"];
                }
            }
            if ([diag_factorsA containsObject:@"Coronary Artery Disease"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_CoronaryArteryDisease"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_CoronaryArteryDisease"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_CoronaryArteryDisease"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_CoronaryArteryDisease"];
                }
            }
            //    s_diag_DiabetesMellitus;
            //    s_diag_SpinalCordInjury;
            //    s_diag_PelvicTrauma;
            //    s_diag_PenileTrauma;
            //++++++++
            if ([diag_factorsA containsObject:@"Diabetes Mellitus"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_DiabetesMellitus"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_DiabetesMellitus"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_DiabetesMellitus"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_DiabetesMellitus"];
                }
            }
            if ([diag_factorsA containsObject:@"Spinal Cord Injury"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_SpinalCordInjury"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_SpinalCordInjury"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_SpinalCordInjury"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_SpinalCordInjury"];
                }
            }
            if ([diag_factorsA containsObject:@"Pelvic Trauma"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_PelvicTrauma"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_PelvicTrauma"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PelvicTrauma"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_PelvicTrauma"];
                }
            }
            //++++++++
            if ([diag_factorsA containsObject:@"Penile Trauma"]) {
                if ([self.diag_dictionary valueForKey:@"s_diag_PenileTrauma"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_PenileTrauma"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PenileTrauma"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diag_dictionary setObject:s_comp_noneNumber forKey:@"s_diag_PenileTrauma"];
                }
            }
            
            
            
            
            
            //    s_devimp_AMS700CX;
            //    s_devimp_AMS700CXR;
            //    s_devimp_AMS700LGX;
            //    s_devimp_ColoplastTitan;
            NSString *devimp_factors = [dic valueForKey:@"var_deviceimplaned"];
            NSNumber *devimp_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.devimp_dictionary setObject:devimp_s_comp_sumNumber forKey:@"s_devimp_sum"];
            if ([devimp_factors isEqualToString:@"AMS 700 CX"]) {
                if ([self.devimp_dictionary valueForKey:@"s_devimp_AMS700CX"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_AMS700CX"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700CX"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_AMS700CX"];
                }
            } else if ([devimp_factors isEqualToString:@"AMS 700 CXR"]) {
                if ([self.devimp_dictionary valueForKey:@"s_devimp_AMS700CXR"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_AMS700CXR"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700CXR"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_AMS700CXR"];
                }
            } else if ([devimp_factors isEqualToString:@"AMS 700 LGX"]) {
                if ([self.devimp_dictionary valueForKey:@"s_devimp_AMS700LGX"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_AMS700LGX"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700LGX"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_AMS700LGX"];
                }
            } else if ([devimp_factors isEqualToString:@"Coloplast Titan"]) {
                if ([self.devimp_dictionary valueForKey:@"s_devimp_ColoplastTitan"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_ColoplastTitan"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_ColoplastTitan"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.devimp_dictionary setObject:s_comp_noneNumber forKey:@"s_devimp_ColoplastTitan"];
                }
            }
            
            
            
            
            //diluse_dictionary
            NSString *diluse_factors = [dic valueForKey:@"var_dilatorsused"];
            NSNumber *diluse_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.diluse_dictionary setObject:diluse_s_comp_sumNumber forKey:@"s_diluse_sum"];
            if ([diluse_factors isEqualToString:@"Brooks"]) {
                if ([self.diluse_dictionary valueForKey:@"s_diluse_Brooks"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"s_diluse_Brooks"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Brooks"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"s_diluse_Brooks"];
                }
            } else if ([diluse_factors isEqualToString:@"Hegar"]) {
                if ([self.diluse_dictionary valueForKey:@"s_diluse_Hegar"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"s_diluse_Hegar"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Hegar"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"s_diluse_Hegar"];
                }
            } else if ([diluse_factors isEqualToString:@"Furlow"]) {
                if ([self.diluse_dictionary valueForKey:@"s_diluse_Furlow"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"s_diluse_Furlow"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Furlow"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.diluse_dictionary setObject:s_comp_noneNumber forKey:@"s_diluse_Furlow"];
                }
            }
            
            //s_dilwas_straightforward
            //s_dilwas_difficultduetoscarring
            //s_dilwas_difficultduetoanatomy
            NSString *dilwas_factors = [dic valueForKey:@"var_dilationwas"];
            NSNumber *dilwas_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.dilwas_dictionary setObject:dilwas_s_comp_sumNumber forKey:@"s_dilwas_sum"];
            if ([dilwas_factors isEqualToString:@"straightforward"]) {
                if ([self.dilwas_dictionary valueForKey:@"s_dilwas_straightforward"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"s_dilwas_straightforward"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_straightforward"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"s_dilwas_straightforward"];
                }
            } else if ([dilwas_factors isEqualToString:@"difficult due to scarring"]) {
                if ([self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoscarring"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"s_dilwas_difficultduetoscarring"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoscarring"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"s_dilwas_difficultduetoscarring"];
                }
            } else if ([dilwas_factors isEqualToString:@"difficult due to anatomy"]) {
                if ([self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoanatomy"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"s_dilwas_difficultduetoanatomy"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoanatomy"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilwas_dictionary setObject:s_comp_noneNumber forKey:@"s_dilwas_difficultduetoanatomy"];
                }
            }
            
           
            
            
            //    s_restyp_Conceal
            //    s_restyp_Spherical
            //    s_restyp_Cloverleaf
            NSString *restyp_factors = [dic valueForKey:@"var_reservoirtype"];
            NSNumber *restyp_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.restyp_dictionary setObject:restyp_s_comp_sumNumber forKey:@"s_restyp_sum"];
            if ([restyp_factors isEqualToString:@"Conceal"]) {
                if ([self.restyp_dictionary valueForKey:@"s_restyp_Conceal"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"s_restyp_Conceal"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Conceal"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"s_restyp_Conceal"];
                }
            } else if ([restyp_factors isEqualToString:@"Spherical"]) {
                if ([self.restyp_dictionary valueForKey:@"s_restyp_Spherical"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"s_restyp_Spherical"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Spherical"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"s_restyp_Spherical"];
                }
            } else if ([restyp_factors isEqualToString:@"Cloverleaf"]) {
                if ([self.restyp_dictionary valueForKey:@"s_restyp_Cloverleaf"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"s_restyp_Cloverleaf"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Cloverleaf"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.restyp_dictionary setObject:s_comp_noneNumber forKey:@"s_restyp_Cloverleaf"];
                }
            }
            
            
            
            
            
            
            
            //s_dilto_9mm;
            //s_dilto_10mm;
            //s_dilto_11mm;
            //s_dilto_12mm;
            //s_dilto_13mm;
            //s_dilto_14mm;
            //s_dilto_na;
            NSString *dilto_factors = [dic valueForKey:@"var_dilatedto"];
            NSNumber *dilto_s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.dilto_dictionary setObject:dilto_s_comp_sumNumber forKey:@"s_dilto_sum"];
            if ([dilto_factors isEqualToString:@"9mm"]) {
                if ([self.dilto_dictionary valueForKey:@"s_dilto_9mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_9mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_9mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_9mm"];
                }
            } else if ([dilto_factors isEqualToString:@"10mm"]) {
                if ([self.dilto_dictionary valueForKey:@"s_dilto_10mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_10mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_10mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_10mm"];
                }
            } else if ([dilto_factors isEqualToString:@"11mm"]) {
                if ([self.dilto_dictionary valueForKey:@"s_dilto_11mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_11mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_11mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_11mm"];
                }
                
                //s_dilto_12mm;
                //s_dilto_13mm;
                //s_dilto_14mm;
                //s_dilto_na;
            } else if ([dilto_factors isEqualToString:@"12mm"]) {
                if ([self.dilto_dictionary valueForKey:@"s_dilto_12mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_12mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_12mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_12mm"];
                }
            } else if ([dilto_factors isEqualToString:@"13mm"]) {
                if ([self.dilto_dictionary valueForKey:@"s_dilto_13mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_13mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_13mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_13mm"];
                }
            } else if ([dilto_factors isEqualToString:@"14mm"]) {
                if ([self.dilto_dictionary valueForKey:@"s_dilto_14mm"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_14mm"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_14mm"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_14mm"];
                }
            } else if ([dilto_factors isEqualToString:@"n/a"]) {
                if ([self.dilto_dictionary valueForKey:@"s_dilto_na"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_na"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_na"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.dilto_dictionary setObject:s_comp_noneNumber forKey:@"s_dilto_na"];
                }
            }
            
            
            
            
        }
//==============================================================================================================================
//==============================================================================================================================
//==============================================================================================================================
    } else if([_procID isEqualToString:@"10"]) {
        for(int i=0;i<self.selectedCases.count;i++){
            
            NSDictionary *dic = [self.selectedCases objectAtIndex:i];
            NSString *dob = [dic valueForKey:@"var_patientDOB"];
            // NSString *dos = [dic objectForKey:@"DateOfService"];
            float age = [self CalculateAge:dob];
            NSLog(@" ^^^^ Age Retreived :: %f",age);
            sumOfAges+= age;
            if(i == 0){
                maxAge = age;
                minAge = age;
            }
            else{
                if(age>maxAge){
                    maxAge = age;
                }
                if(age<minAge){
                    minAge = age;
                }
            }

            if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
                maleCount+=1;
            }
        }

        
        for(int i=0;i<self.surgeonCases.count;i++){
            
            NSDictionary *dic = [self.surgeonCases objectAtIndex:i];
            NSString *dob = [dic valueForKey:@"var_patientDOB"];
            // NSString *dos = [dic objectForKey:@"DateOfService"];
            float age = [self CalculateAge:dob];
            NSLog(@" ^^^^ Age Retreived :: %f",age);
            sur_sumOfAges+= age;
            if(i == 0){
                sur_maxAge = age;
                sur_minAge = age;
            }
            else{
                if(age>sur_maxAge){
                    sur_maxAge = age;
                }
                if(age<sur_minAge){
                    sur_minAge = age;
                }
            }
            if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
                sur_maleCount+=1;
            }

        }
  
    }else if ([_procID isEqualToString:@"1"]) {
            
            for(int i=0;i<self.selectedCases.count;i++){
                
                
                NSDictionary *dic = [self.selectedCases objectAtIndex:i];
                NSString *dob = [dic valueForKey:@"var_patientDOB"];
                // NSString *dos = [dic objectForKey:@"DateOfService"];
                float age = [self CalculateAge:dob];
                NSLog(@" ^^^^ Age Retreived :: %f",age);
                sumOfAges+= age;
                if(i == 0){
                    maxAge = age;
                    minAge = age;
                }
                else{
                    if(age>maxAge){
                        maxAge = age;
                    }
                    if(age<minAge){
                        minAge = age;
                    }
                }
                
                
                
                NSString *factors = [dic valueForKey:@"var_factors"];
                NSNumber *s_comp_sumNumber = [NSNumber numberWithInt:i+1];
                [self.comp_dictionary setObject:s_comp_sumNumber forKey:@"comp_sum"];
                if ([factors isEqualToString:@"None"]) {
                    if ([self.comp_dictionary valueForKey:@"comp_none"] == nil) {
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_none"];
                    } else {
                        NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_none"] ;
                        int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                        s_comp_noneInt++;
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_none"];
                    }
                } else if ([factors isEqualToString:@"Converted to open"]) {
                    if ([self.comp_dictionary valueForKey:@"comp_open"] == nil) {
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_open"];
                    } else {
                        NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_open"] ;
                        int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                        s_comp_noneInt++;
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_open"];
                    }
                } else if ([factors isEqualToString:@"Bowel injury"]) {
                    if ([self.comp_dictionary valueForKey:@"comp_bowel"] == nil) {
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_bowel"];
                    } else {
                        NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_bowel"] ;
                        int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                        s_comp_noneInt++;
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_bowel"];
                    }
                } else if ([factors isEqualToString:@"Rectal injury"]) {
                    if ([self.comp_dictionary valueForKey:@"comp_rectal"] == nil) {
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_rectal"];
                    } else {
                        NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_rectal"] ;
                        int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                        s_comp_noneInt++;
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_rectal"];
                    }
                } else if ([factors isEqualToString:@"Transfusion"]) {
                    if ([self.comp_dictionary valueForKey:@"comp_transfusion"] == nil) {
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_transfusion"];
                    } else {
                        NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_transfusion"];
                        int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                        s_comp_noneInt++;
                        NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                        [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"comp_transfusion"];
                    }
                }
                
                
                
                
                if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
                    maleCount+=1;
                }
//                if(![[dic valueForKey:@"var_transfusion"] isEqualToString:@"NO"]){
//                    transfusionCount+=1;
//                }
                
                if([dic valueForKey:@"var_BMI"]){
                    float bmi = [[dic valueForKey:@"var_BMI"] floatValue];
                    bmiCount+= bmi;
                    if(i == 0){
                        minBmi = bmi;
                        maxBmi = bmi;
                    }else{
                        if(bmi>maxBmi){
                            maxBmi = bmi;
                        }
                        if(bmi<minBmi){
                            minBmi = bmi;
                        }
                    }
                }
                if([dic valueForKey:@"var_roomTime"]){
                    NSString *str = [dic valueForKey:@"var_roomTime"];
                    NSArray *ary = [str componentsSeparatedByString:@" "];
                    int val = [[ary objectAtIndex:0] intValue];
                    NSLog(@" ***** Value for Room Time Retreived  ::  %i",val);
                    roomTimeCount+=val;
                    if(i == 0){
                        minRoomTime = val;
                        maxRoomTime = val;
                    }else{
                        if(val>maxRoomTime){
                            maxRoomTime = val;
                        }
                        if(val<minRoomTime){
                            minRoomTime = val;
                        }
                    }
                }
                
                ////blood loss
                if([dic valueForKey:@"var_EBL"]){
                    NSString *str = [dic valueForKey:@"var_EBL"];
                    NSArray *ary = [str componentsSeparatedByString:@" "];
                    int val = [[ary objectAtIndex:0] intValue];
                    NSLog(@" ***** Value for  Blood Loss Retreived  ::  %i",val);
                    bloodLossCount+=val;
                    if(i == 0){
                        minBloodLoss = val;
                        maxBloodLoss = val;
                    }else{
                        if(val>maxBloodLoss){
                            maxBloodLoss = val;
                        }
                        if(val<minBloodLoss){
                            minBloodLoss = val;
                        }
                    }
                }
        
                if([dic valueForKey:@"var_consulTime"]){
                    NSString *str = [dic valueForKey:@"var_consulTime"];
                    NSArray *ary = [str componentsSeparatedByString:@" "];
                    int val = [[ary objectAtIndex:0] intValue];
                    NSLog(@" ***** Value Retreived  ::  %i",val);
                    consoleTimeCount+=val;
                    if(i == 0){
                        minConsoleTime = val;
                        maxConsoleTime = val;
                    }else{
                        if(val>maxConsoleTime){
                            maxConsoleTime = val;
                        }
                        if(val<minConsoleTime){
                            minConsoleTime = val;
                        }
                    }
                }
                
                if(![[dic valueForKey:@"var_lysisOfAdhesions"] isEqualToString:@"NO"]){
                    adhesiolysisCount+=1;
                }
                
                if(![[dic valueForKey:@"var_bladderNeckReconstruction"] isEqualToString:@"NO"]){
                    vasAnomolyCount+=1;
                }

            
            }
        
        
        for(int i=0;i<self.surgeonCases.count;i++){
            
            NSDictionary *dic = [self.surgeonCases objectAtIndex:i];
            
           
            NSString *factors = [dic valueForKey:@"var_factors"];
            NSNumber *s_comp_sumNumber = [NSNumber numberWithInt:i+1];
            [self.comp_dictionary setObject:s_comp_sumNumber forKey:@"s_comp_sum"];
            if ([factors isEqualToString:@"None"]) {
                if ([self.comp_dictionary valueForKey:@"s_comp_none"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_none"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_none"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_none"];
                }
            } else if ([factors isEqualToString:@"Converted to open"]) {
                if ([self.comp_dictionary valueForKey:@"s_comp_open"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_open"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_open"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_open"];
                }
            } else if ([factors isEqualToString:@"Bowel injury"]) {
                if ([self.comp_dictionary valueForKey:@"s_comp_bowel"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_bowel"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_bowel"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_bowel"];
                }
            } else if ([factors isEqualToString:@"Rectal injury"]) {
                if ([self.comp_dictionary valueForKey:@"s_comp_rectal"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_rectal"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_rectal"] ;
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_rectal"];
                }
            } else if ([factors isEqualToString:@"Transfusion"]) {
                if ([self.comp_dictionary valueForKey:@"s_comp_transfusion"] == nil) {
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:1];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_transfusion"];
                } else {
                    NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_transfusion"];
                    int s_comp_noneInt = [getNumberFromDictionary integerValue] ;
                    s_comp_noneInt++;
                    NSNumber *s_comp_noneNumber = [NSNumber numberWithInt:s_comp_noneInt];
                    [self.comp_dictionary setObject:s_comp_noneNumber forKey:@"s_comp_transfusion"];
                }
            }

            
            NSString *dob = [dic valueForKey:@"var_patientDOB"];
            // NSString *dos = [dic objectForKey:@"DateOfService"];
            float age = [self CalculateAge:dob];
            NSLog(@" ^^^^ Age Retreived :: %f",age);
            sur_sumOfAges+= age;
            if(i == 0){
                sur_maxAge = age;
                sur_minAge = age;
            }
            else{
                if(age>sur_maxAge){
                    sur_maxAge = age;
                }
                if(age<sur_minAge){
                    sur_minAge = age;
                }
            }
//            if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
//                sur_maleCount+=1;
//            }
            if([dic valueForKey:@"var_BMI"]){
                float bmi = [[dic valueForKey:@"var_BMI"] floatValue];
                sur_bmiCount+= bmi;
                if(i == 0){
                    sur_minBmi = bmi;
                    sur_maxBmi = bmi;
                }else{
                    if(bmi>sur_maxBmi){
                        sur_maxBmi = bmi;
                    }
                    if(bmi<sur_minBmi){
                        sur_minBmi = bmi;
                    }
                }
            }
            if([dic valueForKey:@"var_roomTime"]){
                NSString *str = [dic valueForKey:@"var_roomTime"];
                NSArray *ary = [str componentsSeparatedByString:@" "];
                int val = [[ary objectAtIndex:0] intValue];
                NSLog(@" ***** Value for Room Time Retreived  ::  %i",val);
                sur_roomTimeCount+=val;
                if(i == 0){
                    sur_minRoomTime = val;
                    sur_maxRoomTime = val;
                }else{
                    if(val>sur_maxRoomTime){
                        sur_maxRoomTime = val;
                    }
                    if(val<sur_minRoomTime){
                        sur_minRoomTime = val;
                    }
                }
            }
            if([dic valueForKey:@"var_EBL"]){
                NSString *str = [dic valueForKey:@"var_EBL"];
                NSArray *ary = [str componentsSeparatedByString:@" "];
                int val = [[ary objectAtIndex:0] intValue];
                NSLog(@" ***** Value for  Blood Loss Retreived  ::  %i",val);
                sur_bloodLossCount+=val;
                if(i == 0){
                    sur_minBloodLoss = val;
                    sur_maxBloodLoss = val;
                }else{
                    if(val>sur_maxBloodLoss){
                        sur_maxBloodLoss = val;
                    }
                    if(val<sur_minBloodLoss){
                        sur_minBloodLoss = val;
                    }
                }
            }
            if([dic valueForKey:@"var_consulTime"]){
                NSString *str = [dic valueForKey:@"var_consulTime"];
                NSArray *ary = [str componentsSeparatedByString:@" "];
                int val = [[ary objectAtIndex:0] intValue];
                NSLog(@" ***** Value Retreived  ::  %i",val);
                sur_consoleTimeCount+=val;
                if(i == 0){
                    sur_minConsoleTime = val;
                    sur_maxConsoleTime = val;
                }else{
                    if(val>sur_maxConsoleTime){
                        sur_maxConsoleTime = val;
                    }
                    if(val<sur_minConsoleTime){
                        sur_minConsoleTime = val;
                    }
                }
            }
            
            if(![[dic valueForKey:@"var_lysisOfAdhesions"] isEqualToString:@"NO"]){
                sur_adhesiolysisCount+=1;
            }
            
            if(![[dic valueForKey:@"var_bladderNeckReconstruction"] isEqualToString:@"NO"]){
                sur_vasAnomolyCount+=1;
            }
            
        }
    }
    
}

-(int)CalculateAge:(NSString *)DateOfBirth{
    
    // NSString *date1 = [c1 objectForKey:@"DateOfService"];
    // NSString *date2 = [c2 objectForKey:@"DateOfService"];
    NSDate *d1;// = [[NSDate alloc] init];
    NSDate *d2 = [NSDate date];// = [[NSDate alloc] init];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MM-dd-yyyy"];
    d1 = [dateFormat1 dateFromString:DateOfBirth];
    //d2 = [dateFormat1 dateFromString:DateOfService];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:d1
                                                 toDate:d2
                                                options:0];
    return components.year;
}

//-(IBAction)advancedOptions:(id)sender{
//
//    if (self.isNationalData) {
//
//    }else{
//        UCAdvancedOptions *controller = [[UCAdvancedOptions alloc] initWithNibName:@"UCAdvancedOptions" bundle:nil];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//
//}


-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
