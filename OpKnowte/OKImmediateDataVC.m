//
//  OKImmediateDataVC.m
//  OpKnowte
//
//  Created by Apple on 16.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKImmediateDataVC.h"
#import "OKPostOpDataGraphsVC.h"

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
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableData = @[
                       @"Average Age of Patient",
                       @"Male vs. Female",
                       @"BMI",
                       @"Left vs. Right Renal Mass",
                       @"Patients with Cysto/Stent",
                       @"Tumor Size",
                       @"Tumor Characteristics",
                       @"Cases Requiring Adhesiolysis",
                       @"Cases with Vascular Anomoly",
                       @"Intra-Operative Ultra Sound",
                       @"Deep Margins",
                       @"Margins",
                       @"Renal Collecting System Repair",
                       @"Average Clamp Time",
                       @"Coagulants",
                       @"Blood Loss",
                       @"Console Time",
                       @"Room Time",
                       @"Complications",
                       @"Cases Requiring Transfusion",
                       @"Advanced Options"
                       ];
    [self addBottomTabBar];
    _immediateDataTable.backgroundColor = [UIColor clearColor];
    self.immediateDataTable.dataSource = self;
    self.immediateDataTable.delegate = self;
    _immediateDataTable.frame = CGRectMake(_immediateDataTable.frame.origin.x, _immediateDataTable.frame.origin.y, _immediateDataTable.frame.size.width, (_immediateDataTable.frame.size.height - 57.f));
    [self.immediateDataTable reloadData];
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
    if ([cell.immediateDataLabel.text isEqualToString:@"BMI"]) {
        [self BMI];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Average Age of Patient"]){
        [self AverageAgeOfPatient];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Male vs. Female"]){
        [self MaleFemale];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Left vs. Right Renal Mass"]){
        [self LeftRightRenalMass];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Patients with Cysto/Stent"]){
        [self CytoStent];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Tumor Size"]){
        [self TumorSize];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Tumor Characteristics"]){
        [self TumorCharacteristics];
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Cases Requiring Adhesiolysis"]){
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
    }else if ([cell.immediateDataLabel.text isEqualToString:@"Cases Requiring Transfusion"]){
        [self TransfusionRequired];
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
        isNationalData = NO;
    }
    return self;
}

-(void)AverageAgeOfPatient{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    
    controller.graphToDraw = @"AverageAge";
    
    if(sumOfAges<=0)
        sumOfAges = 100;
    controller.averageAge = sumOfAges/self.selectedCases.count;
    controller.maxAge = maxAge;
    controller.minAge = minAge;
    
    if (self.isNationalData) {
        
        if(sur_sumOfAges<=0)
            sur_sumOfAges = 100;
        controller.sur_averageAge = sur_sumOfAges/self.surgeonCases.count;
        controller.sur_maxAge = sur_maxAge;
        controller.sur_minAge = sur_minAge;
        controller.isNationalData = YES;
        
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
    
    controller.malePercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_maleCount/self.surgeonCases.count)*100;
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
    
    controller.bmiPercentage = bmiCount/self.selectedCases.count;
    controller.maxBmi = maxBmi;
    controller.minBmi = minBmi;
    
    if (self.isNationalData) {
        controller.sur_bmiPercentage = sur_bmiCount/self.surgeonCases.count;
        controller.sur_maxBmi = sur_maxBmi;
        controller.sur_minBmi = sur_minBmi;
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
    
    controller.LRMPercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_LRMCount/self.surgeonCases.count)*100;
        controller.sur_LRMPercentage = percentage;
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
    
    if (self.isNationalData) {
        percentage = (sur_cytoStentCount/self.surgeonCases.count)*100;
        controller.sur_cytoStentPercentage = percentage;
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
    
    controller.tumorSizePercentage = tumorSizeCount/self.selectedCases.count;
    controller.maxTumorSize = maxTumorSize;
    controller.minTumorSize = minTumorSize;
    
    if (self.isNationalData) {
        controller.sur_tumorSizePercentage = sur_tumorSizeCount/self.surgeonCases.count;
        controller.sur_maxTumorSize = sur_maxTumorSize;
        controller.sur_minTumorSize = sur_minTumorSize;
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
-(void)TumorCharacteristics{}
-(void)AdhesiolysisRequired{

    [self reset];
    [self CalculateValues];
    float percentage=0;
    percentage = (adhesiolysisCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"Adhesiolysis";
    
    controller.requiredPercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_adhesiolysisCount/self.surgeonCases.count)*100;
        controller.sur_requiredPercentage = percentage;
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
    
    controller.anomoliesPercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_vasAnomolyCount/self.surgeonCases.count)*100;
        controller.sur_anomoliesPercentage = percentage;
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
    
    controller.iousPercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_intraOpUSCount/self.surgeonCases.count)*100;
        controller.iousPercentage = percentage;
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
    
    if (self.isNationalData) {
        percentage = (sur_positiveDMargins/self.surgeonCases.count)*100;
        controller.sur_dmPositive = percentage;
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)Margins{}
-(void)RenalSystemRepair{

    [self reset];
    [self CalculateValues];
    
    float  percentage = (renalSRCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"RenalSR";
    
    controller.renalRSPercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_renalSRCount/self.surgeonCases.count)*100;
        controller.sur_renalRSPercentage = percentage;
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
    
    controller.clampTimePercentage = clampTimeCount/self.selectedCases.count;
    controller.maxClampTime = maxClampTime;
    controller.minClampTime = minClampTime;
    
    if (self.isNationalData) {
        controller.sur_clampTimePercentage = sur_clampTimeCount/self.surgeonCases.count;
        controller.sur_maxClampTime = sur_maxClampTime;
        controller.sur_minClampTime = sur_minClampTime;
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
    
    controller.coagulantPercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_coagulantCount/self.surgeonCases.count)*100;
        controller.sur_coagulantPercentage = percentage;
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
    controller.graphToDraw = @"BloodLoss";
    
    controller.bloodLossPercentage = bloodLossCount/self.selectedCases.count;
    controller.minBloodLoss = minBloodLoss;
    controller.maxBloodLoss = maxBloodLoss;
    
    if (self.isNationalData) {
        controller.sur_bloodLossPercentage = sur_bloodLossCount/self.surgeonCases.count;
        controller.sur_minBloodLoss = sur_minBloodLoss;
        controller.sur_maxBloodLoss = sur_maxBloodLoss;
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)ConsoleTime{

    [self reset];
    [self CalculateValues];
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"ConsoleTime";
    
    controller.consolePercentage = consoleTimeCount/self.selectedCases.count;
    controller.maxConsoleTime = maxConsoleTime;
    controller.minConsoleTime = minConsoleTime;
    
    if (self.isNationalData) {
        controller.sur_consolePercentage = sur_consoleTimeCount/self.surgeonCases.count;
        controller.sur_maxConsoleTime = sur_maxConsoleTime;
        controller.sur_minConsoleTime = sur_minConsoleTime;
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
    
    controller.roomTimePercentage = roomTimeCount/self.selectedCases.count;
    controller.minRoomTime = minRoomTime;
    controller.maxRoomTime = maxRoomTime;
    
    if (self.isNationalData) {
        controller.sur_roomTimePercentage = sur_roomTimeCount/self.surgeonCases.count;
        controller.sur_minRoomTime = sur_minRoomTime;
        controller.sur_maxRoomTime = sur_maxRoomTime;
        controller.isNationalData = YES;
    }
    
    controller.NationalSize = self.totalNationalCount;
    controller.SurgeonSize = self.totalSurgeonCount;
    //controller.NationalSize = [self.selectedCases count];
    //controller.SurgeonSize = [self.surgeonCases count];
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)Complications{}
-(void)TransfusionRequired{

    [self reset];
    [self CalculateValues];
    
    float percentage = 0;
    percentage = (transfusionCount/self.selectedCases.count)*100;
    
    OKPostOpDataGraphsVC *controller = [[OKPostOpDataGraphsVC alloc] initWithNibName:@"OKPostOpDataGraphsVC" bundle:nil];
    controller.graphToDraw = @"Transfusion";
    
    controller.transfusionPercentage = percentage;
    
    if (self.isNationalData) {
        percentage = (sur_transfusionCount/self.surgeonCases.count)*100;
        controller.sur_transfusionPercentage = percentage;
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
    
    //if(!isCalculated){
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
        if(![[dic valueForKey:@"var_margin"] isEqualToString:@"No"]){
            positiveDMargins+=1;
        }
        if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
            maleCount+=1;
        }
        if([[dic valueForKey:@"var_preOp"] isEqualToString:@"Left renal mass"]){
            LRMCount+=1;
        }
        if(![[dic valueForKey:@"var_cysto"] isEqualToString:@"No"]){
            cytoStentCount+=1;
        }
        if(![[dic valueForKey:@"Adhesiolyst"] isEqualToString:@""]){
            adhesiolysisCount+=1;
        }
        if(![[dic valueForKey:@"Vascular_Anomalies"] isEqualToString:@"No"]){
            vasAnomolyCount+=1;
        }
        if(![[dic valueForKey:@"var_renalUltraSound"] isEqualToString:@"No"]){
            intraOpUSCount+=1;
        }
        if(![[dic valueForKey:@"var_RCSRepair"] isEqualToString:@"No"]){
            renalSRCount+=1;
        }
        if(![[dic valueForKey:@"var_coagulant"] isEqualToString:@"No coagulants"]){
            coagulantCount+=1;
        }
        if(![[dic valueForKey:@"var_transfusion"] isEqualToString:@"No"]){
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
        if(![[dic valueForKey:@"var_margin"] isEqualToString:@"No"]){
            sur_positiveDMargins+=1;
        }
        if([[dic valueForKey:@"var_sex"] isEqualToString:@"Male"]){
            sur_maleCount+=1;
        }
        if([[dic valueForKey:@"var_preOp"] isEqualToString:@"Left renal mass"]){
            sur_LRMCount+=1;
        }
        if(![[dic valueForKey:@"var_cysto"] isEqualToString:@"No"]){
            sur_cytoStentCount+=1;
        }
        if(![[dic valueForKey:@"Adhesiolyst"] isEqualToString:@""]){
            sur_adhesiolysisCount+=1;
        }
        if(![[dic valueForKey:@"Vascular_Anomalies"] isEqualToString:@"No"]){
            sur_vasAnomolyCount+=1;
        }
        if(![[dic valueForKey:@"var_renalUltraSound"] isEqualToString:@"No"]){
            sur_intraOpUSCount+=1;
        }
        if(![[dic valueForKey:@"var_RCSRepair"] isEqualToString:@"No"]){
            sur_renalSRCount+=1;
        }
        if(![[dic valueForKey:@"var_coagulant"] isEqualToString:@"No coagulants"]){
            sur_coagulantCount+=1;
        }
        if(![[dic valueForKey:@"var_transfusion"] isEqualToString:@"No"]){
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
