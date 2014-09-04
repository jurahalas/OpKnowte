 //
//  OKSelectFUDVariablesVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/17/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectFUDVariablesVC.h"
#import "OKSelectFUDVariablesCell.h"
#import "OKFollowUpDataCompareVC.h"
#import "OKProceduresManager.h"

@interface OKSelectFUDVariablesVC ()

@property (strong, nonatomic) IBOutlet UITableView *selectVariablesTable;
@property (strong, nonatomic) NSArray *sixMonthArray;
@property (strong, nonatomic) NSArray *twoWeeksArray;
@property (nonatomic) int tappedCell;
@property (nonatomic, assign) BOOL showNationalData;
@property (nonatomic, strong) NSString *padOrErectile;
@end

//6 month

float twoWeeks;
float sixMonths;

float bunSum;
float minBun;
float maxBun;

float creatinineSum;
float minCreatinine;
float maxCreatinine;

float xrayPositive;
float xrayNegative;

float liverNormal;
float liverAbNormal;

float herniaNO;
float herniaYES;

float metastaticDisease;
float LocalRecurrence;
float Lymphadenopathy;
float LiverMetastasis;
float BoneMetastasis;
float BrainMetastasis;

float s_twoWeeks;
float s_sixMonths;

float s_bunSum;
float s_minBun;
float s_maxBun;

float s_creatinineSum;
float s_minCreatinine;
float s_maxCreatinine;

float s_xrayPositive;
float s_xrayNegative;

float s_liverNormal;
float s_liverAbNormal;

float s_herniaNO;
float s_herniaYES;

float s_metastaticDisease;
float s_LocalRecurrence;
float s_Lymphadenopathy;
float s_LiverMetastasis;
float s_BoneMetastasis;
float s_BrainMetastasis;


//2 weeks

float twoWeeks;
float sixMonths;

float bunDiffSum;
float creatinineDiffSum;

float Tx = 0;
float T0 = 0;
float T1 = 0;
float T1a = 0;
float T1b = 0;
float T2 = 0;
float T2a = 0;
float T2b = 0;
float T3 = 0;
float T3a = 0;
float T3b = 0;
float T3c = 0;
float T4 = 0;

float N = 0;
float Nx = 0;
float N0 = 0;
float N1 = 0;

float M = 0;
float M0 = 0;
float M1 = 0;

float ClearAll = 0;
float Papillary = 0;
float Chromophobe = 0;
float Sarcomatoid = 0;
float angiomyolipoma = 0;
float oncocytoma = 0;
float other = 0;

float er_ClearAll = 0;
float er_Papillary = 0;
float er_Chromophobe = 0;
float er_Sarcomatoid = 0;
float er_angiomyolipoma = 0;
float er_oncocytoma = 0;
float er_other = 0;


float FGoneByFour = 0;
float FGtwoByFour = 0;
float FGthreeByFour = 0;
float FGfourByFour = 0;

float mPositive = 0;
float mNegative = 0;

float dmPositive = 0;
float dmNegative = 0;

float stayCount;
int minStay;
int maxStay;


float Ileus = 0;
float BowelInjury = 0;
float Infection = 0;
float UrineLeak = 0;
float DVT = 0;
float PE = 0;
float CardiacEvent = 0;
float Hernia = 0;
float Transfusion = 0;
float Death = 0;
float OtherComp = 0;

float twoWeeks;
float sixMonths;

float bunDiffSum;
float creatinineDiffSum;
// ***************
float s_Tx = 0;
float s_T0 = 0;
float s_T1 = 0;
float s_T1a = 0;
float s_T1b = 0;
float s_T2 = 0;
float s_T2a = 0;
float s_T2b = 0;
float s_T3 = 0;
float s_T3a = 0;
float s_T3b = 0;
float s_T3c = 0;
float s_T4 = 0;

float s_N = 0;
float s_Nx = 0;
float s_N0 = 0;
float s_N1 = 0;

float s_M = 0;
float s_M0 = 0;
float s_M1 = 0;

float s_ClearAll = 0;
float s_Papillary = 0;
float s_Chromophobe = 0;
float s_Sarcomatoid = 0;
float s_angiomyolipoma = 0;
float s_oncocytoma = 0;
float s_other = 0;

float s_er_ClearAll = 0;
float s_er_Papillary = 0;
float s_er_Chromophobe = 0;
float s_er_Sarcomatoid = 0;
float s_er_angiomyolipoma = 0;
float s_er_oncocytoma = 0;
float s_er_other = 0;

float s_FGoneByFour = 0;
float s_FGtwoByFour = 0;
float s_FGthreeByFour = 0;
float s_FGfourByFour = 0;

float s_mPositive = 0;
float s_mNegative = 0;

float s_dmPositive = 0;
float s_dmNegative = 0;

float s_stayCount;
int s_minStay;
int s_maxStay;


float s_Ileus = 0;
float s_BowelInjury = 0;
float s_Infection = 0;
float s_UrineLeak = 0;
float s_DVT = 0;
float s_PE = 0;
float s_CardiacEvent = 0;
float s_Hernia = 0;
float s_Transfusion = 0;
float s_Death = 0;
float s_OtherComp = 0;

float s_twoWeeks;
float s_sixMonths;

float s_bunDiffSum;
float s_creatinineDiffSum;

@implementation OKSelectFUDVariablesVC


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
    _selectVariablesTable.backgroundColor = [UIColor clearColor];
    
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        _twoWeeksArray = @[@"TN Staging",
                           @"Gleason",
                           @"Positive Margin",
                           @"Cystogram",
                           @"Length of Stay",
                           @"Complications"];
        _sixMonthArray = @[@"PSA",
                           @"Continence",
                           @"Erectile Function",
                           @"Bladder Neck Contracture",
                           @"Mortality"];
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        _sixMonthArray = @[@"Chest Xray",
                           @"Liver Enzymes",
                           @"Post Site Hernia",
                           @"CT Scan",
                           @"Bun",
                           @"Creatine"];
        _twoWeeksArray = @[@"TNM Staging",
                           @"Tumor Characteristics",
                           @"Fuhrman Grade",
                           @"Margins",
                           @"Deep Margins",
                           @"Length Stay",
                           @"Complications",
                           @"Change in BUN",
                           @"Change in Creatine"];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
            _sixMonthArray = @[@"Average time to begin cycling of device",
                               @"Occurrence of erosion",
                               @"Occurrence of infection",
                               @"Occurrence of mechanical failure"];
        _twoWeeksArray = _sixMonthArray;
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        _sixMonthArray = @[@"Stone location",
                           @"Stone size",
                           @"Number of shockwaves",
                           @"Shockwave rate",
                           @"2 minute pause",
                           @"Stone location(complications)",
                           @"Stone size(complications)",
                           @"Number of shockwaves(complications)",
                           @"Shockwave rate(complications)",
                           @"2 minute pause(complications)"];
        _twoWeeksArray = _sixMonthArray;
    }

    _selectVariablesTable.dataSource = self;
    _selectVariablesTable.delegate = self;
    [_selectVariablesTable reloadData];
    _selectVariablesTable.frame = CGRectMake(_selectVariablesTable.frame.origin.x, _selectVariablesTable.frame.origin.y, _selectVariablesTable.frame.size.width, (_selectVariablesTable.frame.size.height - 50.f));
    [self addBottomTabBar];
    [self addLeftButtonToNavbar];
    self.navigationItem.title = @"Select Variables";
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


- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_cameFromVC isEqualToString:@"weeks"]) {
        return _twoWeeksArray.count;
    } else {
        return _sixMonthArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SelectFUDVariablesCell";
    OKSelectFUDVariablesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKSelectFUDVariablesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if ([_cameFromVC isEqualToString:@"weeks"]) {
        cell.variableLabel.text = _twoWeeksArray[indexPath.row];
    } else {
        cell.variableLabel.text = _sixMonthArray[indexPath.row];
    }
    [cell setCellBGImageLight:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _showNationalData = YES;
    _tappedCell = indexPath.row;
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        if ([_cameFromVC isEqualToString:@"weeks"]) {
            switch (indexPath.row) {
                case 0:{
                    [self TMGstaging];
                    break;
                }
                case 1:{
                    [self CTScan];
                    break;
                }
                case 2:{
                    [self xray];
                    break;
                }
                case 3:{
                    [self Liver];
                    break;
                }
                case 4:{
                    [self nights];
                    break;
                }
                case 5:{
                    [self complications];
                    break;
                }
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0:{
                    [self Hernia];
                    break;
                }
                case 1:{
                    self.padOrErectile = @"pad";
                    [self tumorCh];
                    break;
                }
                case 2:{
                    self.padOrErectile = @"er";
                    [self tumorCh];
                    break;
                }
                case 3:{
                    [self xray];
                    break;
                }
                case 4:{
                    [self margins];
                    break;
                }
                default:
                    break;
            }
        }

        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        if ([_cameFromVC isEqualToString:@"weeks"]) {
            switch (indexPath.row) {
                case 0:{
                    [self TMGstaging];
                    break;
                }
                case 1:{
                    [self tumorCh];
                    break;
                }
                case 2:{
                    [self fuhrmanGrade];
                    break;
                }
                case 3:{
                    [self margins];
                    break;
                }
                case 4:{
                    [self dMargin];
                    break;
                }
                case 5:{
                    [self nights];
                    break;
                }
                case 6:{
                    [self complications];
                    break;
                }
                case 7:{
                    [self changeBUN];
                    break;
                }
                case 8:{
                    [self changeCreatinine];
                    break;
                }
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0:{
                    [self xray];
                    break;
                }
                case 1:{
                    [self Liver];
                    break;
                }
                case 2:{
                    [self Hernia];
                    break;
                }
                case 3:{
                    [self CTScan];
                    break;
                }
                case 4:{
                    [self BUN];
                    break;
                }
                case 5:{
                    [self Creatinine];
                    break;
                }
                default:
                    break;
            }
        }

    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
            switch (indexPath.row) {
                case 0:{
                    [self BUN];
                    break;
                }
                case 1:{
                    [self Creatinine];
                    break;
                }
                case 2:{
                    [self changeBUN];
                    break;
                }
                case 3:{
                    [self changeCreatinine];
                    break;
                }
                default:
                    break;
            }
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        switch (indexPath.row) {
            case 0:{
                [self complications];
                break;
            }
            case 1:{
                [self BUN];
                break;
            }
            case 2:{
                [self Creatinine];
                break;
            }
            case 3:{
                [self changeBUN];
                break;
            }
            case 4:{
                [self Hernia];
                break;
            }
            case 5:{
                [self margins];
                break;
            }
            case 6:{
                [self dMargin];
                break;
            }
            case 7:{
                [self xray];
                break;
            }
            case 8:{
                [self Liver];
                break;
            }
            case 9:{
                [self fuhrmanGrade];
                break;
            }
            default:
                break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//from old app

-(void)resetCounter{
    twoWeeks = 0;
    sixMonths = 0;
    
    bunDiffSum=0;
    creatinineDiffSum=0;
    
    Tx = 0;
    T0 = 0;
    T1 = 0;
    T1a = 0;
    T1b = 0;
    T2 = 0;
    T2a = 0;
    T2b = 0;
    T3 = 0;
    T3a = 0;
    T3b = 0;
    T3c = 0;
    T4 = 0;
    
    N = 0;
    Nx = 0;
    N0 = 0;
    N1 = 0;
    
    M = 0;
    M0 = 0;
    M1 = 0;
    
    ClearAll = 0;
    Papillary = 0;
    Chromophobe = 0;
    Sarcomatoid = 0;
    angiomyolipoma = 0;
    oncocytoma = 0;
    other = 0;
    
    er_ClearAll = 0;
    er_Papillary = 0;
    er_Chromophobe = 0;
    er_Sarcomatoid = 0;
    er_angiomyolipoma = 0;
    er_oncocytoma = 0;
    er_other = 0;
    
    FGoneByFour = 0;
    FGtwoByFour = 0;
    FGthreeByFour = 0;
    FGfourByFour = 0;
    
    mPositive = 0;
    mNegative = 0;
    
    dmPositive = 0;
    dmNegative = 0;
    
    stayCount = 0;
    minStay = 0;
    maxStay = 0;
    
    Ileus = 0;
    BowelInjury = 0;
    Infection = 0;
    UrineLeak = 0;
    DVT = 0;
    PE = 0;
    CardiacEvent = 0;
    Hernia = 0;
    Transfusion = 0;
    Death = 0;
    OtherComp = 0;
   
    
    twoWeeks = 0;
    sixMonths = 0;
    
    creatinineSum=0;
    bunSum=0;
    minCreatinine=0;
    maxCreatinine=0;
    minBun=0;
    maxBun=0;
    
    xrayPositive = 0;
    xrayNegative = 0;
    
    liverAbNormal = 0;
    liverNormal = 0;
    
    herniaYES = 0;
    herniaNO = 0;
    
    
    metastaticDisease = 0;
    LocalRecurrence = 0;
    Lymphadenopathy = 0;
    LiverMetastasis = 0;
    BoneMetastasis = 0;
    BrainMetastasis = 0;
}


-(void)resetSurgeonCounter{
    
    s_twoWeeks = 0;
    s_sixMonths = 0;
    
    s_bunDiffSum=0;
    s_creatinineDiffSum=0;
    
    s_Tx = 0;
    s_T0 = 0;
    s_T1 = 0;
    s_T1a = 0;
    s_T1b = 0;
    s_T2 = 0;
    s_T2a = 0;
    s_T2b = 0;
    s_T3 = 0;
    s_T3a = 0;
    s_T3b = 0;
    s_T3c = 0;
    s_T4 = 0;
    
    s_N = 0;
    s_Nx = 0;
    s_N0 = 0;
    s_N1 = 0;
    
    s_M = 0;
    s_M0 = 0;
    s_M1 = 0;
    
    s_ClearAll = 0;
    s_Papillary = 0;
    s_Chromophobe = 0;
    s_Sarcomatoid = 0;
    s_angiomyolipoma = 0;
    s_oncocytoma = 0;
    s_other = 0;
    
    s_er_ClearAll = 0;
    s_er_Papillary = 0;
    s_er_Chromophobe = 0;
    s_er_Sarcomatoid = 0;
    s_er_angiomyolipoma = 0;
    s_er_oncocytoma = 0;
    s_er_other = 0;
    
    s_FGoneByFour = 0;
    s_FGtwoByFour = 0;
    s_FGthreeByFour = 0;
    s_FGfourByFour = 0;
    
    s_mPositive = 0;
    s_mNegative = 0;
    
    s_dmPositive = 0;
    s_dmNegative = 0;
    
    s_stayCount = 0;
    s_minStay = 0;
    s_maxStay = 0;
    
    s_Ileus = 0;
    s_BowelInjury = 0;
    s_Infection = 0;
    s_UrineLeak = 0;
    s_DVT = 0;
    s_PE = 0;
    s_CardiacEvent = 0;
    s_Hernia = 0;
    s_Transfusion = 0;
    s_Death = 0;
    s_OtherComp = 0;
    
    ///////////////
    s_twoWeeks = 0;
    s_sixMonths = 0;
    
    s_creatinineSum=0;
    s_bunSum=0;
    s_minCreatinine=0;
    s_maxCreatinine=0;
    s_minBun=0;
    s_maxBun=0;
    
    s_xrayPositive = 0;
    s_xrayNegative = 0;
    
    s_liverAbNormal = 0;
    s_liverNormal = 0;
    
    s_herniaYES = 0;
    s_herniaNO = 0;
    
    
    s_metastaticDisease = 0;
    s_LocalRecurrence = 0;
    s_Lymphadenopathy = 0;
    s_LiverMetastasis = 0;
    s_BoneMetastasis = 0;
    s_BrainMetastasis = 0;
}


-(void)calculate{
    
    [self resetCounter];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        for (int i = 0; i < [self.performanceCases count]; i++) {
            NSDictionary *dict = [self.performanceCases objectAtIndex:i];
            
            if ([[dict objectForKey:@"timePointID"] isEqualToString:@"12"]) {
                twoWeeks++;
                
                NSString *tStage = [dict objectForKey:@"T"];
                //NSLog(@"%@", tStage);
                if (tStage.length > 0) {
                    if ([tStage isEqualToString:@"T2a"]){
                        T2a++;
                    }else if ([tStage isEqualToString:@"T2b"]){
                        T2b++;
                    }else if ([tStage isEqualToString:@"T2c"]){
                        T3++;
                    }else if ([tStage isEqualToString:@"T3a"]){
                        T3a++;
                    }else if ([tStage isEqualToString:@"T3b"]){
                        T3b++;
                    }else if ([tStage isEqualToString:@"T4"]){
                        T4++;
                    }
                }
                
                NSString *nStage = [dict objectForKey:@"N"];
                //NSLog(@"%@", nStage);
                if (nStage.length > 0) {
                    if ([nStage isEqualToString:@"NX"]){
                        Nx++;
                    }else if ([nStage isEqualToString:@"N0"]){
                        N0++;
                    }else if ([nStage isEqualToString:@"N1"]){
                        N1++;
                    }
                }
                
                NSString *ctscan = [dict objectForKey:@"gleason"];
                //NSLog(@"%@", ctscan);
                if (ctscan.length > 0) {
                    if ([ctscan isEqualToString:@"(3+3)"]) {
                        metastaticDisease++;
                    }else if ([ctscan isEqualToString:@"(3+4)"]){
                        LocalRecurrence++;
                    }else if ([ctscan isEqualToString:@"(4+3)"]){
                        Lymphadenopathy++;
                    }else if ([ctscan isEqualToString:@"(4+4)"]){
                        LiverMetastasis++;
                    }else if ([ctscan isEqualToString:@"(4+5)"]){
                        BoneMetastasis++;
                    }else if ([ctscan isEqualToString:@"(5+5)"]){
                        BrainMetastasis++;
                    }
                }
                
                NSString *xray = [dict objectForKey:@"positiveMargin"];
                //NSLog(@"%@", xray);
                if (xray.length > 0) {
                    if ([xray isEqualToString:@"YES"]) {
                        xrayPositive++;
                    }else if ([xray isEqualToString:@"NO"]){
                        xrayNegative++;
                    }
                }

                NSString *liver = [dict objectForKey:@"cystogram"];
                //NSLog(@"%@", liver);
                if (xray.length > 0) {
                    if ([liver isEqualToString:@"extravasation"]) {
                        liverNormal++;
                    }else if ([liver isEqualToString:@"no extravasation"]){
                        liverAbNormal++;
                    }
                }
                
                if([dict objectForKey:@"lengthOfStay"]){
                    NSString *nights = [dict objectForKey:@"lengthOfStay"];
                    //NSLog(@"%@", nights);
                    NSArray *ary = [nights componentsSeparatedByString:@" "];
                    float stay = [[ary objectAtIndex:0] floatValue];
                    stayCount+=stay;
                    if(twoWeeks == 1){
                        minStay = stay;
                        maxStay = stay;
                    }else{
                        if(stay>maxStay){
                            maxStay = stay;
                        }
                        if(stay<minStay){
                            minStay = stay;
                        }
                    }
                }
                
                NSString *complication = [dict objectForKey:@"complications"];
                //NSLog(@"%@", complication);
                if (complication.length > 0) {
                    if ([complication isEqualToString:@"Ileus"]) {
                        Ileus++;
                    }else if ([complication isEqualToString:@"Bowel Injury"]){
                        BowelInjury++;
                    }else if ([complication isEqualToString:@"Wound Infection"]){
                        Infection++;
                    }else if ([complication isEqualToString:@"Urine Leak"]){
                        UrineLeak++;
                    }else if ([complication isEqualToString:@"DVT"]){
                        DVT++;
                    }else if ([complication isEqualToString:@"PE"]){
                        PE++;
                    }else if ([complication isEqualToString:@"Re-admission within 30 days"]){
                        CardiacEvent++;
                    }else if ([complication isEqualToString:@"Return to the OR within 30 days"]){
                        Hernia++;
                    }else if ([complication isEqualToString:@"Transfusion"]){
                        Transfusion++;
                        NSLog(@"%f",Transfusion);
                    }else if ([complication isEqualToString:@"Death"]){
                        Death++;
                    }
                }
                
                
            }else if ([[dict objectForKey:@"timePointID"] intValue] >12 || [[dict objectForKey:@"timePointID"] isEqualToString:@"30"]){
                sixMonths++;
                NSString *hernia = [dict objectForKey:@"PSA"];
                //NSLog(@"%@", hernia);
                
                if (hernia.length > 0) {
                    if ([hernia isEqualToString:@"Undetectable"]) {
                        herniaYES++;
                    }else if ([hernia isEqualToString:@"Biochemical Rescurrence"]){
                        herniaNO++;
                    }
                }
                
                
//                NSString *FGrade = [dict objectForKey:@"continence"];
//                //NSLog(@"%@", FGrade);
//               // float frGradeFloat = [[dict objectForKey:@"continence"] floatValue];
//                if (FGrade.length > 0) {
//                    if ([FGrade isEqualToString:@"0"]) {
//                        FGoneByFour++;
//                    }else if ([FGrade isEqualToString:@"1"] || [FGrade isEqualToString:@"2"] || [FGrade isEqualToString:@"2"]){
//                        FGoneByFour++;
//                    }else {
//                        FGoneByFour++;
//                    }
//                }
                NSString *tumorCh = [dict objectForKey:@"continence"];
                
                if ([tumorCh isEqualToString:@"0 pads"]) {
                    ClearAll++;
                }else if ([tumorCh isEqualToString:@"1 pad"]){
                    Papillary++;
                }else if ([tumorCh isEqualToString:@"2 pads"]){
                    Chromophobe++;
                }else if ([tumorCh isEqualToString:@"3 pads"]){
                    Sarcomatoid++;
                }else if ([tumorCh isEqualToString:@">3 pads"]){
                    angiomyolipoma++;
                }
//                    else if ([tumorCh isEqualToString:@"oncocytoma"]){
//                        s_oncocytoma++;
//                    }else if ([tumorCh isEqualToString:@"other"]){
//                        s_other++;
//                    }
                
//                if([dict objectForKey:@"erectileFunction"]){
//                    float crt = [[dict objectForKey:@"erectileFunction"] floatValue];
//                    creatinineSum+= crt;
//                    if(sixMonths == 1){
//                        minCreatinine = crt;
//                        maxCreatinine = crt;
//                    }else{
//                        if(crt>maxCreatinine){
//                            maxCreatinine = crt;
//                        }
//                        if(crt<minCreatinine){
//                            minCreatinine = crt;
//                        }
//                    }
//                }
                NSString *er_tumorCh = [dict objectForKey:@"erectileFunction"];
                
                if ([er_tumorCh isEqualToString:@"not actively seeking recovery"]) {
                    er_ClearAll++;
                }else if ([er_tumorCh isEqualToString: @"no erections"]){
                    er_Papillary++;
                }else if ([er_tumorCh isEqualToString:@"25% erections"]){
                    er_Chromophobe++;
                }else if ([er_tumorCh isEqualToString:@"50% erections"]){
                    er_Sarcomatoid++;
                }else if ([er_tumorCh isEqualToString:@"75% erections"]){
                    er_angiomyolipoma++;
                }else if ([er_tumorCh isEqualToString:@"erections suff. with PDE-5 inh."]){
                    er_oncocytoma++;
                }else if ([er_tumorCh isEqualToString:@"erections suff. without PDE-5 inh."]){
                    er_other++;
                }

                
                NSString *xray = [dict objectForKey:@"bladderNeckContracture"];
                //NSLog(@"%@", xray);
                if (xray.length > 0) {
                    if ([xray isEqualToString:@"YES"]) {
                        xrayPositive++;
                    }else if ([xray isEqualToString:@"NO"]){
                        xrayNegative++;
                    }
                }
                
                if([dict objectForKey:@"mortality"]){
                    
                    NSString *margins = [dict objectForKey:@"mortality"];
                    //NSLog(@"%@", margins);
                    if (margins.length > 0) {
                        if ([margins isEqualToString:@"NO"])
                            mNegative++;
                        else
                            mPositive++;
                    }
                    
                }
                
            }
            
        }

    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        for (int i = 0; i < [self.performanceCases count]; i++) {
            NSDictionary *dict = [self.performanceCases objectAtIndex:i];
            NSLog(@"%@",[dict objectForKey:@"timePointID"]);
            
            if ([[dict objectForKey:@"timePointID"] isEqualToString:@"1"]) {
                twoWeeks++;
                
                NSString *tStage = [dict objectForKey:@"tStage"];
                //NSLog(@"%@", tStage);
                if (tStage.length > 0) {
                    if ([tStage isEqualToString:@"TX"]) {
                        Tx++;
                    }else if ([tStage isEqualToString:@"T0"]){
                        T0++;
                    }else if ([tStage isEqualToString:@"T1"]){
                        T1++;
                    }else if ([tStage isEqualToString:@"T1a"]){
                        T1a++;
                    }else if ([tStage isEqualToString:@"T1b"]){
                        T1b++;
                    }else if ([tStage isEqualToString:@"T2"]){
                        T2++;
                    }else if ([tStage isEqualToString:@"T2a"]){
                        T2a++;
                    }else if ([tStage isEqualToString:@"T2b"]){
                        T2b++;
                    }else if ([tStage isEqualToString:@"T3"]){
                        T3++;
                    }else if ([tStage isEqualToString:@"T3a"]){
                        T3a++;
                    }else if ([tStage isEqualToString:@"T3b"]){
                        T3b++;
                    }else if ([tStage isEqualToString:@"T3c"]){
                        T3c++;
                    }else if ([tStage isEqualToString:@"T4"]){
                        T4++;
                    }
                }
                
                if([dict objectForKey:@"preOperativeBun"] && [dict objectForKey:@"postOperativeBun"]){
                    
                    float preob = [[dict objectForKey:@"preOperativeBun"] floatValue];
                    float postob = [[dict objectForKey:@"postOperativeBun"] floatValue];
                    float result = postob - preob;
                    if(result<0)
                        result = result*(-1);
                    bunDiffSum+=result;
                }
                
                if([dict objectForKey:@"preOperativeCreatinine"] && [dict objectForKey:@"postOperativeCreatinine"]){
                    
                    float preob = [[dict objectForKey:@"preOperativeCreatinine"] floatValue];
                    float postob = [[dict objectForKey:@"postOperativeCreatinine"] floatValue];
                    float result = postob - preob;
                    if(result<0)
                        result = result*(-1);
                    creatinineDiffSum+=result;
                }
                
                NSString *nStage = [dict objectForKey:@"nStage"];
                //NSLog(@"%@", nStage);
                if (nStage.length > 0) {
                    if ([nStage isEqualToString:@"N"]) {
                        N++;
                    }else if ([nStage isEqualToString:@"NX"]){
                        Nx++;
                    }else if ([nStage isEqualToString:@"N0"]){
                        N0++;
                    }else if ([nStage isEqualToString:@"N1"]){
                        N1++;
                    }
                }
                
                NSString *mStage = [dict objectForKey:@"mStage"];
                //NSLog(@"%@", mStage);
                if (mStage.length > 0) {
                    if ([mStage isEqualToString:@"M"]) {
                        M++;
                    }else if ([mStage isEqualToString:@"M0"]){
                        M0++;
                    }else if ([mStage isEqualToString:@"M1"]){
                        M1++;
                    }
                }
                
                NSString *tumorCh = [dict objectForKey:@"tumorChar"];
                //NSLog(@"%@", tumorCh);
                if (mStage.length > 0) {
                    if ([tumorCh isEqualToString:@"Clear Cell"]) {
                        ClearAll++;
                    }else if ([tumorCh isEqualToString:@"Papillary"]){
                        Papillary++;
                    }else if ([tumorCh isEqualToString:@"Chromophobe"]){
                        Chromophobe++;
                    }else if ([tumorCh isEqualToString:@"Sarcomatoid"]){
                        Sarcomatoid++;
                    }else if ([tumorCh isEqualToString:@"angiomyolipoma"]){
                        angiomyolipoma++;
                    }else if ([tumorCh isEqualToString:@"oncocytoma"]){
                        oncocytoma++;
                    }else if ([tumorCh isEqualToString:@"other"]){
                        other++;
                    }
                }
                
                
                
                NSString *FGrade = [dict objectForKey:@"fuhrmanGrade"];
                //NSLog(@"%@", FGrade);
                if (FGrade.length > 0) {
                    if ([FGrade isEqualToString:@"1/4"]) {
                        FGoneByFour++;
                    }else if ([FGrade isEqualToString:@"2/4"]){
                        FGtwoByFour++;
                    }else if ([FGrade isEqualToString:@"3/4"]){
                        FGthreeByFour++;
                    }else if ([FGrade isEqualToString:@"4/4"]){
                        FGfourByFour++;
                    }
                }
                
                NSString *margins = [dict objectForKey:@"margins"];
                //NSLog(@"%@", margins);
                if (margins.length > 0) {
                    if ([margins isEqualToString:@"Positive"]) {
                        mPositive++;
                    }else if ([margins isEqualToString:@"Negative"]){
                        mNegative++;
                    }
                }
                
                NSString *dMargins = [dict objectForKey:@"deepMargin"];
                //NSLog(@"%@", dMargins);
                if (dMargins.length > 0) {
                    if ([dMargins isEqualToString:@"Positive"]) {
                        dmPositive++;
                    }else if ([dMargins isEqualToString:@"Negative"]){
                        dmNegative++;
                    }
                }
                
                if([dict objectForKey:@"lengthOfStay"]){
                    NSString *nights = [dict objectForKey:@"lengthOfStay"];
                    //NSLog(@"%@", nights);
                    NSArray *ary = [nights componentsSeparatedByString:@" "];
                    float stay = [[ary objectAtIndex:0] floatValue];
                    stayCount+=stay;
                    if(twoWeeks == 1){
                        minStay = stay;
                        maxStay = stay;
                    }else{
                        if(stay>maxStay){
                            maxStay = stay;
                        }
                        if(stay<minStay){
                            minStay = stay;
                        }
                    }
                }
                
                NSString *complication = [dict objectForKey:@"complications"];
                //NSLog(@"%@", complication);
                if (complication.length > 0) {
                    if ([complication isEqualToString:@"Ileus"]) {
                        Ileus++;
                    }else if ([complication isEqualToString:@"Bowel injury"]){
                        BowelInjury++;
                    }else if ([complication isEqualToString:@"Infection"]){
                        Infection++;
                    }else if ([complication isEqualToString:@"Urine leak"]){
                        UrineLeak++;
                    }else if ([complication isEqualToString:@"DVT"]){
                        DVT++;
                    }else if ([complication isEqualToString:@"PE"]){
                        PE++;
                    }else if ([complication isEqualToString:@"Cardiac event"]){
                        CardiacEvent++;
                    }else if ([complication isEqualToString:@"Hernia"]){
                        Hernia++;
                    }else if ([complication isEqualToString:@"Transfusion"]){
                        Transfusion++;
                        NSLog(@"%f",Transfusion);
                    }else if ([complication isEqualToString:@"Death"]){
                        Death++;
                    }else if ([complication isEqualToString:@"Other"]){
                        OtherComp++;
                    }
                }
                
                
            }else if ([[dict objectForKey:@"timePointID"] intValue] >1 && [[dict objectForKey:@"timePointID"] intValue] <12 && [[dict objectForKey:@"timePointID"] intValue] == self.timepointID){
                sixMonths++;
                
                NSString *xray = [dict objectForKey:@"chestXray"];
                //NSLog(@"%@", xray);
                if (xray.length > 0) {
                    if ([xray isEqualToString:@"Positive"]) {
                        xrayPositive++;
                    }else if ([xray isEqualToString:@"Negative"]){
                        xrayNegative++;
                    }
                }
                
                if([dict objectForKey:@"Bun"]){
                    float bun = [[dict objectForKey:@"Bun"] floatValue];
                    bunSum+=bun;
                    if(sixMonths == 1){
                        minBun = bun;
                        maxBun = bun;
                    }else{
                        if(bun>maxBun){
                            maxBun = bun;
                        }
                        if(bun<minBun){
                            minBun = bun;
                        }
                    }
                }
                
                if([dict objectForKey:@"Creatinine"]){
                    float crt = [[dict objectForKey:@"Creatinine"] floatValue];
                    creatinineSum+= crt;
                    if(sixMonths == 1){
                        minCreatinine = crt;
                        maxCreatinine = crt;
                    }else{
                        if(crt>maxCreatinine){
                            maxCreatinine = crt;
                        }
                        if(crt<minCreatinine){
                            minCreatinine = crt;
                        }
                    }
                }
                
                NSString *liver = [dict objectForKey:@"liverEnzymes"];
                //NSLog(@"%@", liver);
                if (xray.length > 0) {
                    if ([liver isEqualToString:@"Normal"]) {
                        liverNormal++;
                    }else if ([liver isEqualToString:@"Abnormal"]){
                        liverAbNormal++;
                    }
                }
                
                NSString *hernia = [dict objectForKey:@"portSiteHemia"];
                //NSLog(@"%@", hernia);
                if (hernia.length > 0) {
                    if ([hernia isEqualToString:@"Yes"]) {
                        herniaYES++;
                    }else if ([hernia isEqualToString:@"No"]){
                        herniaNO++;
                    }
                }
                
                
                NSString *ctscan = [dict objectForKey:@"CtScan"];
                //NSLog(@"%@", ctscan);
                if (ctscan.length > 0) {
                    if ([ctscan isEqualToString:@"No evidence of metastatic disease"]) {
                        metastaticDisease++;
                    }else if ([ctscan isEqualToString:@"Local recurrence"]){
                        LocalRecurrence++;
                    }else if ([ctscan isEqualToString:@"Lymphadenopathy"]){
                        Lymphadenopathy++;
                    }else if ([ctscan isEqualToString:@"Liver metastasis"]){
                        LiverMetastasis++;
                    }else if ([ctscan isEqualToString:@"Bone metastasis"]){
                        BoneMetastasis++;
                    }else if ([ctscan isEqualToString:@"Brain metastasis"]){
                        BrainMetastasis++;
                    }
                }
                
            }
            
        }
    
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
        for (int i = 0; i < [self.performanceCases count]; i++) {
            NSDictionary *dict = [self.performanceCases objectAtIndex:i];
            sixMonths++;
            
            
            if([dict objectForKey:@"averageCyclingTime"]){
                float bun = [[dict objectForKey:@"averageCyclingTime"] floatValue];
                bunSum+=bun;
                if(sixMonths == 1){
                    minBun = bun;
                    maxBun = bun;
                }else{
                    if(bun>maxBun){
                        maxBun = bun;
                    }
                    if(bun<minBun){
                        minBun = bun;
                    }
                }
            }
            
            if([dict objectForKey:@"percentOfErosion"]){
                float crt = [[dict objectForKey:@"percentOfErosion"] floatValue];
                creatinineSum+= crt;
                if(sixMonths == 1){
                    minCreatinine = crt;
                    maxCreatinine = crt;
                }else{
                    if(crt>maxCreatinine){
                        maxCreatinine = crt;
                    }
                    if(crt<minCreatinine){
                        minCreatinine = crt;
                    }
                }
            }

            if([dict objectForKey:@"percentOfInfection"]){
                float preob = [[dict objectForKey:@"percentOfInfection"] floatValue];
                    bunDiffSum+=preob;
            }
                
            
            if([dict objectForKey:@"percentOfMechnicalFailure"]){
                    
                    float preob = [[dict objectForKey:@"percentOfMechnicalFailure"] floatValue];
                        creatinineDiffSum+=preob;
                }
                
            
            
        }
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        for (int i = 0; i < [self.performanceCases count]; i++) {
            NSDictionary *dict = [self.performanceCases objectAtIndex:i];
            sixMonths++;
            
            NSString *complication = [dict objectForKey:@"stoneLocation"];
            //NSLog(@"%@", complication);
            if (complication.length > 0) {
                if ([complication isEqualToString:@"Upper pole, renal"]) {
                    Ileus++;
                }else if ([complication isEqualToString:@"Mid-renal"]){
                    BowelInjury++;
                }else if ([complication isEqualToString:@"Lower pole, renal"]){
                    Infection++;
                }else if ([complication isEqualToString:@"Renal pelvis"]){
                    UrineLeak++;
                }else if ([complication isEqualToString:@"Ureteropelvic Junction"]){
                    DVT++;
                }else if ([complication isEqualToString:@"Proximal ureter"]){
                    PE++;
                }else if ([complication isEqualToString:@"Mid ureter"]){
                    CardiacEvent++;
                }else if ([complication isEqualToString:@"Distal ureter"]){
                    Hernia++;
                }
            }
            
            if([dict objectForKey:@"stoneSize"]){
                float bun = [[dict objectForKey:@"stoneSize"] floatValue];
                bunSum+=bun;
                if(sixMonths == 1){
                    minBun = bun;
                    maxBun = bun;
                }else{
                    if(bun>maxBun){
                        maxBun = bun;
                    }
                    if(bun<minBun){
                        minBun = bun;
                    }
                }
            }
            
            if([dict objectForKey:@"numberOfShockwaves"]){
                float crt = [[dict objectForKey:@"numberOfShockwaves"] floatValue];
                creatinineSum+= crt;
                if(sixMonths == 1){
                    minCreatinine = crt;
                    maxCreatinine = crt;
                }else{
                    if(crt>maxCreatinine){
                        maxCreatinine = crt;
                    }
                    if(crt<minCreatinine){
                        minCreatinine = crt;
                    }
                }
            }
            
            
            if([dict objectForKey:@"shockwaveRate"]){
                float bun = [[dict objectForKey:@"shockwaveRate"] floatValue];
                bunSum+=bun;
                if(sixMonths == 1){
                    minBun = bun;
                    maxBun = bun;
                }else{
                    if(bun>maxBun){
                        maxBun = bun;
                    }
                    if(bun<minBun){
                        minBun = bun;
                    }
                }
            }

            NSString *hernia = [dict objectForKey:@"twoMinutePause"];
            //NSLog(@"%@", hernia);
            if (hernia.length > 0) {
                if ([hernia isEqualToString:@"YES"]) {
                    herniaYES++;
                }else if ([hernia isEqualToString:@"NO"]){
                    herniaNO++;
                }
            }
            
            NSString *margins = [dict objectForKey:@"stoneLocationComplications"];
            //NSLog(@"%@", margins);
            if (margins.length > 0) {
                if ([margins isEqualToString:@"NO"]) {
                    mNegative++;
                }else{
                    mPositive++;
                }
            }
            
            NSString *dMargins = [dict objectForKey:@"stoneSizeComplications"];
            //NSLog(@"%@", dMargins);
            if (dMargins.length > 0) {
                if ([dMargins isEqualToString:@"NO"]) {
                    dmNegative++;
                }else{
                    dmPositive++;
                }
            }
            
            NSString *xray = [dict objectForKey:@"numberOfShockwavesComplications"];
            //NSLog(@"%@", xray);
            if (xray.length > 0) {
                if ([xray isEqualToString:@"NO"]) {
                    xrayNegative++;
                }else{
                    xrayPositive++;
                }
            }
            
            
            NSString *liver = [dict objectForKey:@"shockwaveRateComplications"];
            //NSLog(@"%@", liver);
            if (xray.length > 0) {
                if ([liver isEqualToString:@"NO"]) {
                    liverAbNormal++;
                }else{
                    liverNormal++;
                }
            }
            
            NSString *FGrade = [dict objectForKey:@"twoMinutePauseComplications"];
            //NSLog(@"%@", FGrade);
            if (FGrade.length > 0) {
                if ([FGrade isEqualToString:@"NO"]) {
                    FGoneByFour++;
                }else{
                    FGtwoByFour++;
                }
            }
            
            
            
        }
    }
}


-(void)calculateSurgeonData{
    
    [self resetSurgeonCounter];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        for (int i = 0; i < [self.surgeonCases count]; i++) {
            NSDictionary *dict = [self.surgeonCases objectAtIndex:i];
            NSLog(@"%@",[dict objectForKey:@"timePointID"]);
            
            if ([[dict objectForKey:@"timePointID"] isEqualToString:@"12"]) {
                s_twoWeeks++;
                
                NSString *tStage = [dict objectForKey:@"T"];
                //NSLog(@"%@", tStage);
                if (tStage.length > 0) {
                    if ([tStage isEqualToString:@"T2a"]){
                        s_T2a++;
                    }else if ([tStage isEqualToString:@"T2b"]){
                        s_T2b++;
                    }else if ([tStage isEqualToString:@"T2c"]){
                        s_T3++;
                    }else if ([tStage isEqualToString:@"T3a"]){
                        s_T3a++;
                    }else if ([tStage isEqualToString:@"T3b"]){
                        s_T3b++;
                    }else if ([tStage isEqualToString:@"T4"]){
                        s_T4++;
                    }
                }
                
                NSString *nStage = [dict objectForKey:@"N"];
                //NSLog(@"%@", nStage);
                if (nStage.length > 0) {
                    if ([nStage isEqualToString:@"NX"]){
                        s_Nx++;
                    }else if ([nStage isEqualToString:@"N0"]){
                        s_N0++;
                    }else if ([nStage isEqualToString:@"N1"]){
                        s_N1++;
                    }
                }
                
                NSString *ctscan = [dict objectForKey:@"gleason"];
                NSLog(@"%@", ctscan);
                if (ctscan.length > 0) {
                    if ([ctscan isEqualToString:@"(3+3)"]) {
                        s_metastaticDisease++;
                    }else if ([ctscan isEqualToString:@"(3+4)"]){
                        s_LocalRecurrence++;
                    }else if ([ctscan isEqualToString:@"(4+3)"]){
                        s_Lymphadenopathy++;
                    }else if ([ctscan isEqualToString:@"(4+4)"]){
                        s_LiverMetastasis++;
                    }else if ([ctscan isEqualToString:@"(4+5)"]){
                        s_BoneMetastasis++;
                    }else if ([ctscan isEqualToString:@"(5+5)"]){
                        s_BrainMetastasis++;
                    }
                }
                
                NSString *xray = [dict objectForKey:@"positiveMargin"];
                //NSLog(@"%@", xray);
                if (xray.length > 0) {
                    if ([xray isEqualToString:@"YES"]) {
                        s_xrayPositive++;
                    }else if ([xray isEqualToString:@"NO"]){
                        s_xrayNegative++;
                    }
                }
                
                NSString *liver = [dict objectForKey:@"cystogram"];
                //NSLog(@"%@", liver);
                if (xray.length > 0) {
                    if ([liver isEqualToString:@"extravasation"]) {
                        s_liverNormal++;
                    }else if ([liver isEqualToString:@"no extravasation"]){
                        s_liverAbNormal++;
                    }
                }
                
                if([dict objectForKey:@"lengthOfStay"]){
                    NSString *nights = [dict objectForKey:@"lengthOfStay"];
                    //NSLog(@"%@", nights);
                    NSArray *ary = [nights componentsSeparatedByString:@" "];
                    float stay = [[ary objectAtIndex:0] floatValue];
                    s_stayCount+=stay;
                    if(s_twoWeeks == 1){
                        s_minStay = stay;
                        s_maxStay = stay;
                    }else{
                        if(stay>s_maxStay){
                            s_maxStay = stay;
                        }
                        if(stay<s_minStay){
                            s_minStay = stay;
                        }
                    }
                }
                
                NSString *complication = [dict objectForKey:@"complications"];
                //NSLog(@"%@", complication);
                if (complication.length > 0) {
                    if ([complication isEqualToString:@"Ileus"]) {
                        s_Ileus++;
                    }else if ([complication isEqualToString:@"Bowel Injury"]){
                        s_BowelInjury++;
                    }else if ([complication isEqualToString:@"Wound Infection"]){
                        s_Infection++;
                    }else if ([complication isEqualToString:@"Urine Leak"]){
                        s_UrineLeak++;
                    }else if ([complication isEqualToString:@"DVT"]){
                        s_DVT++;
                    }else if ([complication isEqualToString:@"PE"]){
                        s_PE++;
                    }else if ([complication isEqualToString:@"Re-admission within 30 days"]){
                        s_CardiacEvent++;
                    }else if ([complication isEqualToString:@"Return to the OR within 30 days"]){
                        s_Hernia++;
                    }else if ([complication isEqualToString:@"Transfusion"]){
                        s_Transfusion++;
                        NSLog(@"%f",Transfusion);
                    }else if ([complication isEqualToString:@"Death"]){
                        s_Death++;
                    }
                }
                
                
            }else if ([[dict objectForKey:@"timePointID"] intValue] >12 && [[dict objectForKey:@"timePointID"] intValue] <31){
                s_sixMonths++;
                
                NSString *hernia = [dict objectForKey:@"PSA"];
                //NSLog(@"%@", hernia);
                if (hernia.length > 0) {
                    if ([hernia isEqualToString:@"Undetectable"]) {
                        s_herniaYES++;
                    }else if ([hernia isEqualToString:@"Biochemical Rescurrence"]){
                        s_herniaNO++;
                    }
                }
                
                
//                NSString *FGrade = [dict objectForKey:@"continence"];
//                //NSLog(@"%@", FGrade);
//               // float frGradeFloat = [dict objectForKey:@"continence"];
//                if (FGrade.length > 0) {
//                    if ([FGrade isEqualToString:@"0"]) {
//                        s_FGoneByFour++;
//                    }else if ([FGrade isEqualToString:@"1"] || [FGrade isEqualToString:@"2"] || [FGrade isEqualToString:@"2"]){
//                        s_FGtwoByFour++;
//                    }else {
//                        s_FGthreeByFour++;
//                    }
//                }
                NSString *tumorCh = [dict objectForKey:@"continence"];
                
                if ([tumorCh isEqualToString:@"0 pads"]) {
                    s_ClearAll++;
                }else if ([tumorCh isEqualToString:@"1 pad"]){
                    s_Papillary++;
                }else if ([tumorCh isEqualToString:@"2 pads"]){
                    s_Chromophobe++;
                }else if ([tumorCh isEqualToString:@"3 pads"]){
                    s_Sarcomatoid++;
                }else if ([tumorCh isEqualToString:@">3 pads"]){
                    s_angiomyolipoma++;
                }
                
                
//                if([dict objectForKey:@"erectileFunction"]){
//                    float crt = [[dict objectForKey:@"erectileFunction"] floatValue];
//                    s_creatinineSum+= crt;
//                    if(s_sixMonths == 1){
//                        s_minCreatinine = crt;
//                        s_maxCreatinine = crt;
//                    }else{
//                        if(crt>s_maxCreatinine){
//                            s_maxCreatinine = crt;
//                        }
//                        if(crt<s_minCreatinine){
//                            s_minCreatinine = crt;
//                        }
//                    }
//                }
                NSString *s_er_tumorCh = [dict objectForKey:@"erectileFunction"];
                
                if ([s_er_tumorCh isEqualToString:@"not actively seeking recovery"]) {
                    s_er_ClearAll++;
                }else if ([s_er_tumorCh isEqualToString: @"no erections"]){
                    s_er_Papillary++;
                }else if ([s_er_tumorCh isEqualToString:@"25% erections"]){
                    s_er_Chromophobe++;
                }else if ([s_er_tumorCh isEqualToString:@"50% erections"]){
                    s_er_Sarcomatoid++;
                }else if ([s_er_tumorCh isEqualToString:@"75% erections"]){
                    s_er_angiomyolipoma++;
                }else if ([s_er_tumorCh isEqualToString:@"erections suff. with PDE-5 inh."]){
                    s_er_oncocytoma++;
                }else if ([s_er_tumorCh isEqualToString:@"erections suff. without PDE-5 inh."]){
                    s_er_other++;
                }
                
                NSString *xray = [dict objectForKey:@"bladderNeckContracture"];
                //NSLog(@"%@", xray);
                if (xray.length > 0) {
                    if ([xray isEqualToString:@"YES"]) {
                        s_xrayPositive++;
                    }else if ([xray isEqualToString:@"NO"]){
                        s_xrayNegative++;
                    }
                }
                
                if([dict objectForKey:@"mortality"]){
                    NSString *margins = [dict objectForKey:@"mortality"];
                    //NSLog(@"%@", margins);
                    if (margins.length > 0) {
                        if ([margins isEqualToString:@"NO"]){
                            s_mNegative++;
                        }else{
                            s_mPositive++;
                        }
                    }
                }
            }
        }
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
    
        for (int i = 0; i < [self.surgeonCases count]; i++) {
            NSDictionary *dict = [self.surgeonCases objectAtIndex:i];
            NSLog(@"%@",[dict objectForKey:@"timePointID"]);
            
            if ([[dict objectForKey:@"timePointID"] isEqualToString:@"1"]) {
                s_twoWeeks++;
                
                NSString *tStage = [dict objectForKey:@"tStage"];
                //NSLog(@"%@", tStage);
                if (tStage.length > 0) {
                    if ([tStage isEqualToString:@"TX"]) {
                        s_Tx++;
                    }else if ([tStage isEqualToString:@"T0"]){
                        s_T0++;
                    }else if ([tStage isEqualToString:@"T1"]){
                        s_T1++;
                    }else if ([tStage isEqualToString:@"T1a"]){
                        s_T1a++;
                    }else if ([tStage isEqualToString:@"T1b"]){
                        s_T1b++;
                    }else if ([tStage isEqualToString:@"T2"]){
                        s_T2++;
                    }else if ([tStage isEqualToString:@"T2a"]){
                        s_T2a++;
                    }else if ([tStage isEqualToString:@"T2b"]){
                        s_T2b++;
                    }else if ([tStage isEqualToString:@"T3"]){
                        s_T3++;
                    }else if ([tStage isEqualToString:@"T3a"]){
                        s_T3a++;
                    }else if ([tStage isEqualToString:@"T3b"]){
                        s_T3b++;
                    }else if ([tStage isEqualToString:@"T3c"]){
                        s_T3c++;
                    }else if ([tStage isEqualToString:@"T4"]){
                        s_T4++;
                    }
                }
                
                if([dict objectForKey:@"preOperativeBun"] && [dict objectForKey:@"postOperativeBun"]){
                    
                    float preob = [[dict objectForKey:@"preOperativeBun"] floatValue];
                    float postob = [[dict objectForKey:@"postOperativeBun"] floatValue];
                    float result = postob - preob;
                    if(result<0)
                        result = result*(-1);
                    s_bunDiffSum+=result;
                }
                
                if([dict objectForKey:@"preOperativeCreatinine"] && [dict objectForKey:@"postOperativeCreatinine"]){
                    
                    float preob = [[dict objectForKey:@"preOperativeCreatinine"] floatValue];
                    float postob = [[dict objectForKey:@"postOperativeCreatinine"] floatValue];
                    float result = postob - preob;
                    if(result<0)
                        result = result*(-1);
                    s_creatinineDiffSum+=result;
                }
                
                NSString *nStage = [dict objectForKey:@"nStage"];
                //NSLog(@"%@", nStage);
                if (nStage.length > 0) {
                    if ([nStage isEqualToString:@"N"]) {
                        s_N++;
                    }else if ([nStage isEqualToString:@"NX"]){
                        s_Nx++;
                    }else if ([nStage isEqualToString:@"N0"]){
                        s_N0++;
                    }else if ([nStage isEqualToString:@"N1"]){
                        s_N1++;
                    }
                }
                
                NSString *mStage = [dict objectForKey:@"mStage"];
                //NSLog(@"%@", mStage);
                if (mStage.length > 0) {
                    if ([mStage isEqualToString:@"M"]) {
                        s_M++;
                    }else if ([mStage isEqualToString:@"M0"]){
                        s_M0++;
                    }else if ([mStage isEqualToString:@"M1"]){
                        s_M1++;
                    }
                }
                
                NSString *tumorCh = [dict objectForKey:@"tumorChar"];
                //NSLog(@"%@", tumorCh);
                if (mStage.length > 0) {
                    if ([tumorCh isEqualToString:@"Clear Cell"]) {
                        s_ClearAll++;
                    }else if ([tumorCh isEqualToString:@"Papillary"]){
                        s_Papillary++;
                    }else if ([tumorCh isEqualToString:@"Chromophobe"]){
                        s_Chromophobe++;
                    }else if ([tumorCh isEqualToString:@"Sarcomatoid"]){
                        s_Sarcomatoid++;
                    }else if ([tumorCh isEqualToString:@"angiomyolipoma"]){
                        s_angiomyolipoma++;
                    }else if ([tumorCh isEqualToString:@"oncocytoma"]){
                        s_oncocytoma++;
                    }else if ([tumorCh isEqualToString:@"other"]){
                        s_other++;
                    }
                }
                
                
                
                NSString *FGrade = [dict objectForKey:@"fuhrmanGrade"];
                //NSLog(@"%@", FGrade);
                if (FGrade.length > 0) {
                    if ([FGrade isEqualToString:@"1/4"]) {
                        s_FGoneByFour++;
                    }else if ([FGrade isEqualToString:@"2/4"]){
                        s_FGtwoByFour++;
                    }else if ([FGrade isEqualToString:@"3/4"]){
                        s_FGthreeByFour++;
                    }else if ([FGrade isEqualToString:@"4/4"]){
                        s_FGfourByFour++;
                    }
                }
                
                NSString *margins = [dict objectForKey:@"margins"];
                //NSLog(@"%@", margins);
                if (margins.length > 0) {
                    if ([margins isEqualToString:@"Positive"]) {
                        s_mPositive++;
                    }else if ([margins isEqualToString:@"Negative"]){
                        s_mNegative++;
                    }
                }
                
                
                NSString *dMargins = [dict objectForKey:@"deepMargin"];
                //NSLog(@"%@", dMargins);
                if (dMargins.length > 0) {
                    if ([dMargins isEqualToString:@"Positive"]) {
                        s_dmPositive++;
                    }else if ([dMargins isEqualToString:@"Negative"]){
                        s_dmNegative++;
                    }
                }
                
                if([dict objectForKey:@"lengthOfStay"]){
                    NSString *nights = [dict objectForKey:@"lengthOfStay"];
                    //NSLog(@"%@", nights);
                    NSArray *ary = [nights componentsSeparatedByString:@" "];
                    float stay = [[ary objectAtIndex:0] floatValue];
                    s_stayCount+=stay;
                    if(s_twoWeeks == 1){
                        s_minStay = stay;
                        s_maxStay = stay;
                    }else{
                        if(stay>s_maxStay){
                            s_maxStay = stay;
                        }
                        if(stay<s_minStay){
                            s_minStay = stay;
                        }
                    }
                }
                
                NSString *complication = [dict objectForKey:@"complications"];
                //NSLog(@"%@", complication);
                if (complication.length > 0) {
                    if ([complication isEqualToString:@"Ileus"]) {
                        s_Ileus++;
                    }else if ([complication isEqualToString:@"Bowel injury"]){
                        s_BowelInjury++;
                    }else if ([complication isEqualToString:@"Infection"]){
                        s_Infection++;
                    }else if ([complication isEqualToString:@"Urine leak"]){
                        s_UrineLeak++;
                    }else if ([complication isEqualToString:@"DVT"]){
                        s_DVT++;
                    }else if ([complication isEqualToString:@"PE"]){
                        s_PE++;
                    }else if ([complication isEqualToString:@"Cardiac event"]){
                        s_CardiacEvent++;
                    }else if ([complication isEqualToString:@"Hernia"]){
                        s_Hernia++;
                    }else if ([complication isEqualToString:@"Transfusion"]){
                        s_Transfusion++;
                        NSLog(@"%f",Transfusion);
                    }else if ([complication isEqualToString:@"Death"]){
                        s_Death++;
                    }else if ([complication isEqualToString:@"Other"]){
                        s_OtherComp++;
                    }
                }
                

                
            }else if ([[dict objectForKey:@"timePointID"] intValue] >1 && [[dict objectForKey:@"timePointID"] intValue] <12 && [[dict objectForKey:@"timePointID"] intValue] == self.timepointID){
                s_sixMonths++;
                
                NSString *xray = [dict objectForKey:@"chestXray"];
                NSLog(@"%@", xray);
                if (xray.length > 0) {
                    if ([xray isEqualToString:@"Positive"]) {
                        s_xrayPositive++;
                    }else if ([xray isEqualToString:@"Negative"]){
                        s_xrayNegative++;
                    }
                }
                
                if([dict objectForKey:@"Bun"]){
                    float bun = [[dict objectForKey:@"Bun"] floatValue];
                    s_bunSum+=bun;
                    if(s_sixMonths == 1){
                        s_minBun = bun;
                        s_maxBun = bun;
                    }else{
                        if(bun>s_maxBun){
                            s_maxBun = bun;
                        }
                        if(bun<s_minBun){
                            s_minBun = bun;
                        }
                    }
                }
                
                if([dict objectForKey:@"Creatinine"]){
                    float crt = [[dict objectForKey:@"Creatinine"] floatValue];
                    s_creatinineSum+= crt;
                    if(s_sixMonths == 1){
                        s_minCreatinine = crt;
                        s_maxCreatinine = crt;
                    }else{
                        if(crt>s_maxCreatinine){
                            s_maxCreatinine = crt;
                        }
                        if(crt<s_minCreatinine){
                            s_minCreatinine = crt;
                        }
                    }
                }
                
                NSString *liver = [dict objectForKey:@"liverEnzymes"];
                NSLog(@"%@", liver);
                if (xray.length > 0) {
                    if ([liver isEqualToString:@"Normal"]) {
                        s_liverNormal++;
                    }else if ([liver isEqualToString:@"Abnormal"]){
                        s_liverAbNormal++;
                    }
                }
                
                NSString *hernia = [dict objectForKey:@"portSiteHemia"];
                NSLog(@"%@", hernia);
                if (hernia.length > 0) {
                    if ([hernia isEqualToString:@"Yes"]) {
                        s_herniaYES++;
                    }else if ([hernia isEqualToString:@"No"]){
                        s_herniaNO++;
                    }
                }
                
                
                NSString *ctscan = [dict objectForKey:@"CtScan"];
                NSLog(@"%@", ctscan);
                if (ctscan.length > 0) {
                    if ([ctscan isEqualToString:@"No evidence of metastatic disease"]) {
                        s_metastaticDisease++;
                    }else if ([ctscan isEqualToString:@"Local recurrence"]){
                        s_LocalRecurrence++;
                    }else if ([ctscan isEqualToString:@"Lymphadenopathy"]){
                        s_Lymphadenopathy++;
                    }else if ([ctscan isEqualToString:@"Liver metastasis"]){
                        s_LiverMetastasis++;
                    }else if ([ctscan isEqualToString:@"Bone metastasis"]){
                        s_BoneMetastasis++;
                    }else if ([ctscan isEqualToString:@"Brain metastasis"]){
                        s_BrainMetastasis++;
                    }
                }
                
            }
            
        }
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
        for (int i = 0; i < [self.surgeonCases count]; i++) {
            NSDictionary *dict = [self.surgeonCases objectAtIndex:i];
            s_sixMonths++;
            
            
            if([dict objectForKey:@"averageCyclingTime"]){
                float bun = [[dict objectForKey:@"averageCyclingTime"] floatValue];
                s_bunSum+=bun;
                if(s_sixMonths == 1){
                    s_minBun = bun;
                    s_maxBun = bun;
                }else{
                    if(bun>s_maxBun){
                        s_maxBun = bun;
                    }
                    if(bun<minBun){
                        s_minBun = bun;
                    }
                }
            }
            
            if([dict objectForKey:@"percentOfErosion"]){
                float crt = [[dict objectForKey:@"percentOfErosion"] floatValue];
                s_creatinineSum+= crt;
                if(sixMonths == 1){
                    s_minCreatinine = crt;
                    s_maxCreatinine = crt;
                }else{
                    if(crt>s_maxCreatinine){
                        s_maxCreatinine = crt;
                    }
                    if(crt<s_minCreatinine){
                        s_minCreatinine = crt;
                    }
                }
            }
            
            if([dict objectForKey:@"percentOfInfection"]){
                float preob = [[dict objectForKey:@"percentOfInfection"] floatValue];
                s_bunDiffSum+=preob;
            }
            
            
            if([dict objectForKey:@"percentOfMechnicalFailure"]){
                
                float preob = [[dict objectForKey:@"percentOfMechnicalFailure"] floatValue];
                s_creatinineDiffSum+=preob;
            }
            
            
            
        }
    
    
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        for (int i = 0; i < [self.surgeonCases count]; i++) {
            NSDictionary *dict = [self.surgeonCases objectAtIndex:i];
            s_sixMonths++;
            
            NSString *complication = [dict objectForKey:@"stoneLocation"];
            //NSLog(@"%@", complication);
            if (complication.length > 0) {
                if ([complication isEqualToString:@"Upper pole, renal"]) {
                    s_Ileus++;
                }else if ([complication isEqualToString:@"Mid-renal"]){
                    s_BowelInjury++;
                }else if ([complication isEqualToString:@"Lower pole, renal"]){
                    s_Infection++;
                }else if ([complication isEqualToString:@"Renal pelvis"]){
                    s_UrineLeak++;
                }else if ([complication isEqualToString:@"Ureteropelvic Junction"]){
                    s_DVT++;
                }else if ([complication isEqualToString:@"Proximal ureter"]){
                    s_PE++;
                }else if ([complication isEqualToString:@"Mid ureter"]){
                    s_CardiacEvent++;
                }else if ([complication isEqualToString:@"Distal ureter"]){
                    s_Hernia++;
                }
            }
            
            if([dict objectForKey:@"stoneSize"]){
                float bun = [[dict objectForKey:@"stoneSize"] floatValue];
                s_bunSum+=bun;
                if(s_sixMonths == 1){
                    s_minBun = bun;
                    s_maxBun = bun;
                }else{
                    if(bun>s_maxBun){
                        s_maxBun = bun;
                    }
                    if(bun<s_minBun){
                        s_minBun = bun;
                    }
                }
            }
            
            if([dict objectForKey:@"numberOfShockwaves"]){
                float crt = [[dict objectForKey:@"numberOfShockwaves"] floatValue];
                s_creatinineSum+= crt;
                if(s_sixMonths == 1){
                    s_minCreatinine = crt;
                    s_maxCreatinine = crt;
                }else{
                    if(crt>s_maxCreatinine){
                        s_maxCreatinine = crt;
                    }
                    if(crt<s_minCreatinine){
                        s_minCreatinine = crt;
                    }
                }
            }
            
            
            if([dict objectForKey:@"shockwaveRate"]){
                float preob = [[dict objectForKey:@"shockwaveRate"] floatValue];
                s_bunDiffSum+=preob;
            }
            
            NSString *hernia = [dict objectForKey:@"twoMinutePause"];
            //NSLog(@"%@", hernia);
            if (hernia.length > 0) {
                if ([hernia isEqualToString:@"YES"]) {
                    s_herniaYES++;
                }else if ([hernia isEqualToString:@"NO"]){
                    s_herniaNO++;
                }
            }
          
            
            
            NSString *margins = [dict objectForKey:@"stoneLocationComplications"];
            //NSLog(@"%@", margins);
            if (margins.length > 0) {
                if ([margins isEqualToString:@"NO"]) {
                    s_mNegative++;
                }else{
                    s_mPositive++;
                }
            }
            
            NSString *dMargins = [dict objectForKey:@"stoneSizeComplications"];
            //NSLog(@"%@", dMargins);
            if (dMargins.length > 0) {
                if ([dMargins isEqualToString:@"NO"]) {
                    s_dmNegative++;
                }else{
                    s_dmPositive++;
                }
            }
            
            NSString *xray = [dict objectForKey:@"numberOfShockwavesComplications"];
            //NSLog(@"%@", xray);
            if (xray.length > 0) {
                if ([xray isEqualToString:@"NO"]) {
                    s_xrayNegative++;
                }else{
                    s_xrayPositive++;
                }
            }
            
            
            NSString *liver = [dict objectForKey:@"shockwaveRateComplications"];
            //NSLog(@"%@", liver);
            if (xray.length > 0) {
                if ([liver isEqualToString:@"NO"]) {
                    s_liverAbNormal++;
                }else{
                    s_liverNormal++;
                }
            }
            
            NSString *FGrade = [dict objectForKey:@"twoMinutePauseComplications"];
            //NSLog(@"%@", FGrade);
            if (FGrade.length > 0) {
                if ([FGrade isEqualToString:@"NO"]) {
                    s_FGoneByFour++;
                }else{
                    s_FGtwoByFour++;
                }
            }
              
            
        }
    }
}


// 2 weeks methods
-(void)TMGstaging{
        [self calculate];
        [self calculateSurgeonData];
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(twoWeeks>0){
            controller.TxAge = (Tx/twoWeeks)*100;
            controller.T0Age = (T0/twoWeeks)*100;
            controller.T1Age = (T1/twoWeeks)*100;
            controller.T1aAge = (T1a/twoWeeks)*100;
            controller.T1bAge = (T1b/twoWeeks)*100;
            controller.T2Age = (T2/twoWeeks)*100;
            controller.T2aAge = (T2a/twoWeeks)*100;
            controller.T2bAge = (T2b/twoWeeks)*100;
            controller.T3Age = (T3/twoWeeks)*100;
            controller.T3aAge = (T3/twoWeeks)*100;
            controller.T3bAge = (T3/twoWeeks)*100;
            controller.T3cAge = (T3/twoWeeks)*100;
            controller.T4Age = (T4/twoWeeks)*100;
            controller.NAge = (N/twoWeeks)*100;
            controller.NxAge = (Nx/twoWeeks)*100;
            controller.N0Age = (N0/twoWeeks)*100;
            controller.N1Age = (N1/twoWeeks)*100;
            controller.MAge = (N/twoWeeks)*100;
            controller.M0Age = (M0/twoWeeks)*100;
            controller.M1Age = (M1/twoWeeks)*100;
        }else{
            controller.TxAge = 0;
            controller.T0Age = 0;
            controller.T1Age = 0;
            controller.T1aAge = 0;
            controller.T1bAge = 0;
            controller.T2Age = 0;
            controller.T2aAge = 0;
            controller.T2bAge = 0;
            controller.T3Age = 0;
            controller.T3aAge = 0;
            controller.T3bAge = 0;
            controller.T3cAge = 0;
            controller.T4Age = 0;
            controller.NAge = 0;
            controller.NxAge = 0;
            controller.N0Age = 0;
            controller.N1Age = 0;
            controller.MAge = 0;
            controller.M0Age = 0;
            controller.M1Age = 0;
        }
        if(s_twoWeeks>0){
            controller.s_TxAge = (s_Tx/s_twoWeeks)*100;
            controller.T0Age = (s_T0/s_twoWeeks)*100;
            controller.s_T1Age = (s_T1/s_twoWeeks)*100;
            controller.s_T1aAge = (s_T1a/s_twoWeeks)*100;
            controller.s_T1bAge = (s_T1b/s_twoWeeks)*100;
            controller.s_T2Age = (s_T2/s_twoWeeks)*100;
            controller.s_T2aAge = (s_T2a/s_twoWeeks)*100;
            controller.s_T2bAge = (s_T2b/s_twoWeeks)*100;
            controller.s_T3Age = (s_T3/s_twoWeeks)*100;
            controller.s_T3aAge = (s_T3/s_twoWeeks)*100;
            controller.s_T3bAge = (s_T3/s_twoWeeks)*100;
            controller.s_T3cAge = (s_T3/s_twoWeeks)*100;
            controller.s_T4Age = (s_T4/s_twoWeeks)*100;
            controller.s_NAge = (s_N/s_twoWeeks)*100;
            controller.s_NxAge = (s_Nx/s_twoWeeks)*100;
            controller.s_N0Age = (s_N0/s_twoWeeks)*100;
            controller.s_N1Age = (s_N1/s_twoWeeks)*100;
            controller.s_MAge = (s_N/s_twoWeeks)*100;
            controller.s_M0Age = (s_M0/s_twoWeeks)*100;
            controller.s_M1Age = (s_M1/s_twoWeeks)*100;
        }else{
            controller.s_TxAge = 0;
            controller.s_T0Age = 0;
            controller.s_T1Age = 0;
            controller.s_T1aAge = 0;
            controller.s_T1bAge = 0;
            controller.s_T2Age = 0;
            controller.s_T2aAge = 0;
            controller.s_T2bAge = 0;
            controller.s_T3Age = 0;
            controller.s_T3aAge = 0;
            controller.s_T3bAge = 0;
            controller.s_T3cAge = 0;
            controller.s_T4Age = 0;
            controller.s_NAge = 0;
            controller.s_NxAge = 0;
            controller.s_N0Age = 0;
            controller.s_N1Age = 0;
            controller.s_MAge = 0;
            controller.s_M0Age = 0;
            controller.s_M1Age = 0;
        }
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.graphView = @"TNM";
    controller.showNationalData = _showNationalData;
        [self.navigationController pushViewController:controller animated:YES];
    
}


-(void)tumorCh{
        [self calculate];
        [self calculateSurgeonData];
    
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.ClearAll = (ClearAll/sixMonths)*100;
            controller.Papillary = (Papillary/sixMonths)*100;
            controller.Chromophobe = (Chromophobe/sixMonths)*100;
            controller.Sarcomatoid = (Sarcomatoid/sixMonths)*100;
            controller.oncocytoma = (oncocytoma/sixMonths)*100;
            controller.other = (other/sixMonths)*100;
            controller.angiomyolipoma = (angiomyolipoma/sixMonths)*100;
        }else{
            controller.ClearAll = 0;
            controller.Papillary = 0;
            controller.Chromophobe = 0;
            controller.Sarcomatoid = 0;
            controller.oncocytoma = 0;
            controller.other = 0;
            controller.angiomyolipoma = 0;
        }
        if(s_sixMonths>0){
            controller.s_ClearAll = (s_ClearAll/s_sixMonths)*100;
            controller.s_Papillary = (s_Papillary/s_sixMonths)*100;
            controller.s_Chromophobe = (s_Chromophobe/s_sixMonths)*100;
            controller.s_Sarcomatoid = (s_Sarcomatoid/s_sixMonths)*100;
            controller.s_oncocytoma = (s_oncocytoma/s_sixMonths)*100;
            controller.s_other = (s_other/s_sixMonths)*100;
            controller.s_angiomyolipoma = (s_angiomyolipoma/s_sixMonths)*100;
        }else{
            controller.s_ClearAll = 0;
            controller.s_Papillary = 0;
            controller.s_Chromophobe = 0;
            controller.s_Sarcomatoid = 0;
            controller.s_oncocytoma = 0;
            controller.s_other = 0;
            controller.s_angiomyolipoma = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"tumorCh";
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
   
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1){
        if ([self.padOrErectile isEqualToString:@"pad"]) {
            OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
            if(sixMonths>0){
                controller.ClearAll = (ClearAll/sixMonths)*100;
                controller.Papillary = (Papillary/sixMonths)*100;
                controller.Chromophobe = (Chromophobe/sixMonths)*100;
                controller.Sarcomatoid = (Sarcomatoid/sixMonths)*100;
                controller.oncocytoma = (oncocytoma/sixMonths)*100;
                controller.other = (other/sixMonths)*100;
                controller.angiomyolipoma = (angiomyolipoma/sixMonths)*100;
            }else{
                controller.ClearAll = 0;
                controller.Papillary = 0;
                controller.Chromophobe = 0;
                controller.Sarcomatoid = 0;
                controller.oncocytoma = 0;
                controller.other = 0;
                controller.angiomyolipoma = 0;
            }
            if(s_sixMonths>0){
                controller.s_ClearAll = (s_ClearAll/s_sixMonths)*100;
                controller.s_Papillary = (s_Papillary/s_sixMonths)*100;
                controller.s_Chromophobe = (s_Chromophobe/s_sixMonths)*100;
                controller.s_Sarcomatoid = (s_Sarcomatoid/s_sixMonths)*100;
                controller.s_oncocytoma = (s_oncocytoma/s_sixMonths)*100;
                controller.s_other = (s_other/s_sixMonths)*100;
                controller.s_angiomyolipoma = (s_angiomyolipoma/s_sixMonths)*100;
            }else{
                controller.s_ClearAll = 0;
                controller.s_Papillary = 0;
                controller.s_Chromophobe = 0;
                controller.s_Sarcomatoid = 0;
                controller.s_oncocytoma = 0;
                controller.s_other = 0;
                controller.s_angiomyolipoma = 0;
            }
            
            controller.NationalSize = sixMonths;
            controller.SurgeonSize = s_sixMonths;
            controller.graphView = @"tumorCh";
            controller.showNationalData = _showNationalData;
            
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
            if(sixMonths>0){
                controller.er_ClearAll = (er_ClearAll/sixMonths)*100;
                controller.er_Papillary = (er_Papillary/sixMonths)*100;
                controller.er_Chromophobe = (er_Chromophobe/sixMonths)*100;
                controller.er_Sarcomatoid = (er_Sarcomatoid/sixMonths)*100;
                controller.er_oncocytoma = (er_oncocytoma/sixMonths)*100;
                controller.er_other = (er_other/sixMonths)*100;
                controller.er_angiomyolipoma = (er_angiomyolipoma/sixMonths)*100;
            }else{
                controller.er_ClearAll = 0;
                controller.er_Papillary = 0;
                controller.er_Chromophobe = 0;
                controller.er_Sarcomatoid = 0;
                controller.er_oncocytoma = 0;
                controller.er_other = 0;
                controller.er_angiomyolipoma = 0;
            }
            if(s_sixMonths>0){
                controller.s_er_ClearAll = (s_er_ClearAll/s_sixMonths)*100;
                controller.s_er_Papillary = (s_er_Papillary/s_sixMonths)*100;
                controller.s_er_Chromophobe = (s_er_Chromophobe/s_sixMonths)*100;
                controller.s_er_Sarcomatoid = (s_er_Sarcomatoid/s_sixMonths)*100;
                controller.s_er_oncocytoma = (s_er_oncocytoma/s_sixMonths)*100;
                controller.s_er_other = (s_er_other/s_sixMonths)*100;
                controller.s_er_angiomyolipoma = (s_er_angiomyolipoma/s_sixMonths)*100;
            }else{
                controller.s_er_ClearAll = 0;
                controller.s_er_Papillary = 0;
                controller.s_er_Chromophobe = 0;
                controller.s_er_Sarcomatoid = 0;
                controller.s_er_oncocytoma = 0;
                controller.s_er_other = 0;
                controller.s_er_angiomyolipoma = 0;
            }
            
            controller.NationalSize = sixMonths;
            controller.SurgeonSize = s_sixMonths;
            controller.graphView = @"er_tumorCh";
            controller.showNationalData = _showNationalData;
            
            [self.navigationController pushViewController:controller animated:YES];
        }
       
        
    }else{
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(twoWeeks>0){
            controller.ClearAll = (ClearAll/twoWeeks)*100;
            controller.Papillary = (Papillary/twoWeeks)*100;
            controller.Chromophobe = (Chromophobe/twoWeeks)*100;
            controller.Sarcomatoid = (Sarcomatoid/twoWeeks)*100;
            controller.oncocytoma = (oncocytoma/twoWeeks)*100;
            controller.other = (other/twoWeeks)*100;
            controller.angiomyolipoma = (angiomyolipoma/twoWeeks)*100;
        }else{
            controller.ClearAll = 0;
            controller.Papillary = 0;
            controller.Chromophobe = 0;
            controller.Sarcomatoid = 0;
            controller.oncocytoma = 0;
            controller.other = 0;
            controller.angiomyolipoma = 0;
        }
        if(s_twoWeeks>0){
            controller.s_ClearAll = (s_ClearAll/s_twoWeeks)*100;
            controller.s_Papillary = (s_Papillary/s_twoWeeks)*100;
            controller.s_Chromophobe = (s_Chromophobe/s_twoWeeks)*100;
            controller.s_Sarcomatoid = (s_Sarcomatoid/s_twoWeeks)*100;
            controller.s_oncocytoma = (s_oncocytoma/s_twoWeeks)*100;
            controller.s_other = (s_other/s_twoWeeks)*100;
            controller.s_angiomyolipoma = (s_angiomyolipoma/s_twoWeeks)*100;
        }else{
            controller.s_ClearAll = 0;
            controller.s_Papillary = 0;
            controller.s_Chromophobe = 0;
            controller.s_Sarcomatoid = 0;
            controller.s_oncocytoma = 0;
            controller.s_other = 0;
            controller.s_angiomyolipoma = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.graphView = @"tumorCh";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    }

}


-(void)fuhrmanGrade{
        [self calculate];
        [self calculateSurgeonData];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.FGoneByFour = (FGoneByFour/sixMonths)*100;
            controller.FGtwoByFour = (FGtwoByFour/sixMonths)*100;
            controller.FGthreeByFour = (FGthreeByFour/sixMonths)*100;
            controller.FGfourByFour = (FGfourByFour/sixMonths)*100;
        }else{
            controller.FGoneByFour = 0;
            controller.FGtwoByFour = 0;
            controller.FGthreeByFour = 0;
            controller.FGfourByFour = 0;
        }
        if(s_sixMonths>0){
            controller.s_FGoneByFour = (s_FGoneByFour/s_sixMonths)*100;
            controller.s_FGtwoByFour = (s_FGtwoByFour/s_sixMonths)*100;
            controller.s_FGthreeByFour = (s_FGthreeByFour/s_sixMonths)*100;
            controller.s_FGfourByFour = (s_FGfourByFour/s_sixMonths)*100;
        }else{
            controller.s_FGoneByFour = 0;
            controller.s_FGtwoByFour = 0;
            controller.s_FGthreeByFour = 0;
            controller.s_FGfourByFour = 0;
        }
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"FGrade";
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2) {
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(twoWeeks>0){
            controller.FGoneByFour = (FGoneByFour/twoWeeks)*100;
            controller.FGtwoByFour = (FGtwoByFour/twoWeeks)*100;
            controller.FGthreeByFour = (FGthreeByFour/twoWeeks)*100;
            controller.FGfourByFour = (FGfourByFour/twoWeeks)*100;
        }else{
            controller.FGoneByFour = 0;
            controller.FGtwoByFour = 0;
            controller.FGthreeByFour = 0;
            controller.FGfourByFour = 0;
        }
        if(s_twoWeeks>0){
            controller.s_FGoneByFour = (s_FGoneByFour/s_twoWeeks)*100;
            controller.s_FGtwoByFour = (s_FGtwoByFour/s_twoWeeks)*100;
            controller.s_FGthreeByFour = (s_FGthreeByFour/s_twoWeeks)*100;
            controller.s_FGfourByFour = (s_FGfourByFour/s_twoWeeks)*100;
        }else{
            controller.s_FGoneByFour = 0;
            controller.s_FGtwoByFour = 0;
            controller.s_FGthreeByFour = 0;
            controller.s_FGfourByFour = 0;
        }
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.graphView = @"FGrade";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    
    
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10) {
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.FGoneByFour = (FGoneByFour/sixMonths)*100;
            controller.FGtwoByFour = (FGtwoByFour/sixMonths)*100;
            controller.FGthreeByFour = (FGthreeByFour/sixMonths)*100;
            controller.FGfourByFour = (FGfourByFour/sixMonths)*100;
        }else{
            controller.FGoneByFour = 0;
            controller.FGtwoByFour = 0;
            controller.FGthreeByFour = 0;
            controller.FGfourByFour = 0;
        }
        if(s_sixMonths>0){
            controller.s_FGoneByFour = (s_FGoneByFour/s_sixMonths)*100;
            controller.s_FGtwoByFour = (s_FGtwoByFour/s_sixMonths)*100;
            controller.s_FGthreeByFour = (s_FGthreeByFour/s_sixMonths)*100;
            controller.s_FGfourByFour = (s_FGfourByFour/s_sixMonths)*100;
        }else{
            controller.s_FGoneByFour = 0;
            controller.s_FGtwoByFour = 0;
            controller.s_FGthreeByFour = 0;
            controller.s_FGfourByFour = 0;
        }
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"FGrade";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}


-(void)margins{
        [self calculate];
        [self calculateSurgeonData];
    
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10 || [[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
    
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.mPositive = (mPositive/sixMonths)*100;
            controller.mNegative = (mNegative/sixMonths)*100;
        }else{
            controller.mPositive = 0;
            controller.mNegative = 0;
        }
        if(s_sixMonths>0){
            controller.s_mPositive = (s_mPositive/s_sixMonths)*100;
            controller.s_mNegative = (s_mNegative/s_sixMonths)*100;
        }else{
            controller.s_mPositive = 0;
            controller.s_mNegative = 0;
        }
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"margins";
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
   
    
    }else{
        
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(twoWeeks>0){
            controller.mPositive = (mPositive/twoWeeks)*100;
            controller.mNegative = (mNegative/twoWeeks)*100;
        }else{
            controller.mPositive = 0;
            controller.mNegative = 0;
        }
        if(s_twoWeeks>0){
            controller.s_mPositive = (s_mPositive/s_twoWeeks)*100;
            controller.s_mNegative = (s_mNegative/s_twoWeeks)*100;
        }else{
            controller.s_mPositive = 0;
            controller.s_mNegative = 0;
        }
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.graphView = @"margins";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];

    }
}


-(void)dMargin{
        [self calculate];
        [self calculateSurgeonData];
    
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10) {

    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.dmPositive = (dmPositive/sixMonths)*100;
            controller.dmNegative = (dmNegative/sixMonths)*100;
        }else{
            controller.dmPositive = 0;
            controller.dmNegative = 0;
        }
        if(s_sixMonths>0){
            controller.s_dmPositive = (s_dmPositive/s_sixMonths)*100;
            controller.s_dmNegative = (s_dmNegative/s_sixMonths)*100;
        }else{
            controller.s_dmPositive = 0;
            controller.s_dmNegative = 0;
        }
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"dMargin";
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
        
        
    }else{
    
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(twoWeeks>0){
            controller.dmPositive = (dmPositive/twoWeeks)*100;
            controller.dmNegative = (dmNegative/twoWeeks)*100;
        }else{
            controller.dmPositive = 0;
            controller.dmNegative = 0;
        }
        if(s_twoWeeks>0){
            controller.s_dmPositive = (s_dmPositive/s_twoWeeks)*100;
            controller.s_dmNegative = (s_dmNegative/s_twoWeeks)*100;
        }else{
            controller.s_dmPositive = 0;
            controller.s_dmNegative = 0;
        }
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.graphView = @"dMargin";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];

    
    
    
    }
}


-(void)nights{
        [self calculate];
        [self calculateSurgeonData];
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
    
        NSLog(@"*** LENGTH OF STAY  ::  %f",stayCount/twoWeeks);
        controller.graphView = @"nights";
        if(twoWeeks>0){
            controller.averageStay = stayCount/twoWeeks;
            controller.minStay = minStay;
            controller.maxStay = maxStay;
        }else{
            controller.averageStay = 0;
            controller.minStay = 0;
            controller.maxStay = 0;
        }
        if(s_twoWeeks>0){
            controller.s_averageStay = s_stayCount/s_twoWeeks;
            controller.s_minStay = s_minStay;
            controller.s_maxStay = s_maxStay;
        }else{
            controller.s_averageStay = 0;
            controller.s_minStay = 0;
            controller.s_maxStay = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
}


-(void)complications{
        [self calculate];
        [self calculateSurgeonData];
    
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10) {
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.Ileus = (Ileus/sixMonths)*100;
            controller.BowelInjury = (BowelInjury/sixMonths)*100;
            controller.Infection = (Infection/sixMonths)*100;
            controller.UrineLeak = (UrineLeak/sixMonths)*100;
            controller.DVT = (DVT/sixMonths)*100;
            controller.PE = (PE/sixMonths)*100;
            controller.CardiacEvent = (CardiacEvent/sixMonths)*100;
            controller.Hernia = (Hernia/sixMonths)*100;
        }else{
            controller.Ileus = 0;
            controller.BowelInjury = 0;
            controller.Infection = 0;
            controller.UrineLeak = 0;
            controller.DVT = 0;
            controller.PE = 0;
            controller.CardiacEvent = 0;
            controller.Hernia = 0;
        }
        
        if(s_sixMonths>0){
            controller.s_Ileus = (s_Ileus/s_sixMonths)*100;
            controller.s_BowelInjury = (s_BowelInjury/s_sixMonths)*100;
            controller.s_Infection = (s_Infection/s_sixMonths)*100;
            controller.s_UrineLeak = (s_UrineLeak/s_sixMonths)*100;
            controller.s_DVT = (s_DVT/s_sixMonths)*100;
            controller.s_PE = (s_PE/s_sixMonths)*100;
            controller.s_CardiacEvent = (s_CardiacEvent/s_sixMonths)*100;
            controller.s_Hernia = (s_Hernia/s_sixMonths)*100;
        }else{
            controller.s_Ileus = 0;
            controller.s_BowelInjury = 0;
            controller.s_Infection = 0;
            controller.s_UrineLeak = 0;
            controller.s_DVT = 0;
            controller.s_PE = 0;
            controller.s_CardiacEvent = 0;
            controller.s_Hernia = 0;
           }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"complications";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    
    }else{
    
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
            if(twoWeeks>0){
                controller.Ileus = (Ileus/twoWeeks)*100;
                controller.BowelInjury = (BowelInjury/twoWeeks)*100;
                controller.Infection = (Infection/twoWeeks)*100;
                controller.UrineLeak = (UrineLeak/twoWeeks)*100;
                controller.DVT = (DVT/twoWeeks)*100;
                controller.PE = (PE/twoWeeks)*100;
                controller.CardiacEvent = (CardiacEvent/twoWeeks)*100;
                controller.Hernia = (Hernia/twoWeeks)*100;
                controller.Transfusion = (Transfusion/twoWeeks)*100;
                controller.Death = (Death/twoWeeks)*100;
                controller.OtherComp = (OtherComp/twoWeeks)*100;
            }else{
                controller.Ileus = 0;
                controller.BowelInjury = 0;
                controller.Infection = 0;
                controller.UrineLeak = 0;
                controller.DVT = 0;
                controller.PE = 0;
                controller.CardiacEvent = 0;
                controller.Hernia = 0;
                controller.Transfusion = 0;
                controller.Death = 0;
                controller.OtherComp = 0;
            }
            
            if(s_twoWeeks>0){
                controller.s_Ileus = (s_Ileus/s_twoWeeks)*100;
                controller.s_BowelInjury = (s_BowelInjury/s_twoWeeks)*100;
                controller.s_Infection = (s_Infection/s_twoWeeks)*100;
                controller.s_UrineLeak = (s_UrineLeak/s_twoWeeks)*100;
                controller.s_DVT = (s_DVT/s_twoWeeks)*100;
                controller.s_PE = (s_PE/s_twoWeeks)*100;
                controller.s_CardiacEvent = (s_CardiacEvent/s_twoWeeks)*100;
                controller.s_Hernia = (s_Hernia/s_twoWeeks)*100;
                controller.s_Transfusion = (s_Transfusion/s_twoWeeks)*100;
                controller.s_Death = (s_Death/s_twoWeeks)*100;
                controller.s_OtherComp = (s_OtherComp/s_twoWeeks)*100;
            }else{
                controller.s_Ileus = 0;
                controller.s_BowelInjury = 0;
                controller.s_Infection = 0;
                controller.s_UrineLeak = 0;
                controller.s_DVT = 0;
                controller.s_PE = 0;
                controller.s_CardiacEvent = 0;
                controller.s_Hernia = 0;
                controller.s_Transfusion = 0;
                controller.s_Death = 0;
                controller.s_OtherComp = 0;
            }
            
            controller.NationalSize = twoWeeks;
            controller.SurgeonSize = s_twoWeeks;
            controller.graphView = @"complications";
            controller.showNationalData = _showNationalData;

            [self.navigationController pushViewController:controller animated:YES];
    }
}


-(void)changeBUN{
        [self calculate];
        [self calculateSurgeonData];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {

        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunDiffSum);
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"BUN";
        if(sixMonths>0){
            controller.bunSum = bunDiffSum/sixMonths;
        }else{
            controller.bunSum = 0;
        }
        if(s_sixMonths>0){
            controller.s_bunSum = s_bunDiffSum/s_sixMonths;
        }else{
            controller.s_bunSum = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
   
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2) {
        
        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunDiffSum);
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"BUN";
        if(twoWeeks>0){
            controller.bunSum = bunDiffSum/twoWeeks;
        }else{
            controller.bunSum = 0;
        }
        if(s_twoWeeks>0){
            controller.s_bunSum = s_bunDiffSum/s_twoWeeks;
        }else{
            controller.s_bunSum = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9) {
        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunDiffSum);
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"BUN";
        if(sixMonths>0){
            controller.bunSum = bunDiffSum/sixMonths;
        }else{
            controller.bunSum = 0;
        }
        if(s_sixMonths>0){
            controller.s_bunSum = s_bunDiffSum/s_sixMonths;
        }else{
            controller.s_bunSum = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10) {
        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunDiffSum);
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"BUN";
        if(sixMonths>0){
            controller.bunSum = bunDiffSum/sixMonths;
        }else{
            controller.bunSum = 0;
        }
        if(s_sixMonths>0){
            controller.s_bunSum = s_bunDiffSum/s_sixMonths;
        }else{
            controller.s_bunSum = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    }

}


-(void)changeCreatinine{
        [self calculate];
        [self calculateSurgeonData];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9) {
        NSLog(@" ^^^^^^ SUM OF Creatinine  : %f",creatinineDiffSum);
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"Creatinine";
        if(sixMonths>0){
            controller.creatinineSum = creatinineDiffSum/sixMonths;
        }else{
            controller.creatinineSum = 0;
        }
        if(s_sixMonths>0){
            controller.s_creatinineSum = s_creatinineDiffSum/s_sixMonths;
        }else{
            controller.s_creatinineSum = 0;
        }
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
    NSLog(@" ^^^^^^ SUM OF Creatinine  : %f",creatinineDiffSum);
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"Creatinine";
        if(twoWeeks>0){
            controller.creatinineSum = creatinineDiffSum/twoWeeks;
        }else{
            controller.creatinineSum = 0;
        }
        if(s_twoWeeks>0){
            controller.s_creatinineSum = s_creatinineDiffSum/s_twoWeeks;
        }else{
            controller.s_creatinineSum = 0;
        }
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.showNationalData = _showNationalData;
        [self.navigationController pushViewController:controller animated:YES];
    }

}

// 6 month variables

-(void)xray{
    
        [self calculate];
        [self calculateSurgeonData];
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        if ([_cameFromVC isEqualToString:@"weeks"]) {
            if(twoWeeks>0)
                {
                    controller.xrayPositive = (xrayPositive/twoWeeks)*100;
                    controller.xrayNegative = (xrayNegative/twoWeeks)*100;
                }
                if(s_twoWeeks>0)
                {
                    controller.s_xrayPositive = (s_xrayPositive/s_twoWeeks)*100;
                    controller.s_xrayNegative = (s_xrayNegative/s_twoWeeks)*100;
                }
                
                controller.NationalSize = twoWeeks;
                controller.SurgeonSize = s_twoWeeks;
                controller.graphView = @"xray2";
                controller.showNationalData = _showNationalData;
        }else{
            if(sixMonths>0)
            {
                controller.xrayPositive = (xrayPositive/sixMonths)*100;
                controller.xrayNegative = (xrayNegative/sixMonths)*100;
            }
            if(s_sixMonths>0)
            {
                controller.s_xrayPositive = (s_xrayPositive/s_sixMonths)*100;
                controller.s_xrayNegative = (s_xrayNegative/s_sixMonths)*100;
            }
            
            controller.NationalSize = sixMonths;
            controller.SurgeonSize = s_sixMonths;
            controller.graphView = @"xray";
            controller.showNationalData = _showNationalData;
        }
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        
        if(sixMonths>0)
        {
            controller.xrayPositive = (xrayPositive/sixMonths)*100;
            controller.xrayNegative = (xrayNegative/sixMonths)*100;
        }
        if(s_sixMonths>0)
        {
            controller.s_xrayPositive = (s_xrayPositive/s_sixMonths)*100;
            controller.s_xrayNegative = (s_xrayNegative/s_sixMonths)*100;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"xray";
        controller.showNationalData = _showNationalData;
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        
        if(sixMonths>0)
        {
            controller.xrayPositive = (xrayPositive/sixMonths)*100;
            controller.xrayNegative = (xrayNegative/sixMonths)*100;
        }
        if(s_sixMonths>0)
        {
            controller.s_xrayPositive = (s_xrayPositive/s_sixMonths)*100;
            controller.s_xrayNegative = (s_xrayNegative/s_sixMonths)*100;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.graphView = @"xray";
        controller.showNationalData = _showNationalData;
    }
    
    
    [self.navigationController pushViewController:controller animated:YES];
        
}


-(void)Liver{
        [self calculate];
        [self calculateSurgeonData];
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {

        if(twoWeeks>0){
            controller.liverNormal = (liverNormal/twoWeeks)*100;
            controller.liverAbNormal = (liverAbNormal/twoWeeks)*100;
        }else{
            controller.liverNormal = 0;
            controller.liverAbNormal = 0;
        }
        if(s_twoWeeks>0){
            controller.s_liverNormal = (s_liverNormal/s_twoWeeks)*100;
            controller.s_liverAbNormal = (s_liverAbNormal/s_twoWeeks)*100;
        }else{
            controller.s_liverNormal = 0;
            controller.s_liverAbNormal = 0;
        }
        controller.graphView = @"liver";
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        controller.showNationalData = _showNationalData;
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        if(sixMonths>0){
            controller.liverNormal = (liverNormal/sixMonths)*100;
            controller.liverAbNormal = (liverAbNormal/sixMonths)*100;
        }else{
            controller.liverNormal = 0;
            controller.liverAbNormal = 0;
        }
        if(s_sixMonths>0){
            controller.s_liverNormal = (s_liverNormal/s_sixMonths)*100;
            controller.s_liverAbNormal = (s_liverAbNormal/s_sixMonths)*100;
        }else{
            controller.s_liverNormal = 0;
            controller.s_liverAbNormal = 0;
        }
        controller.graphView = @"liver";
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        if(sixMonths>0){
            controller.liverNormal = (liverNormal/sixMonths)*100;
            controller.liverAbNormal = (liverAbNormal/sixMonths)*100;
        }else{
            controller.liverNormal = 0;
            controller.liverAbNormal = 0;
        }
        if(s_sixMonths>0){
            controller.s_liverNormal = (s_liverNormal/s_sixMonths)*100;
            controller.s_liverAbNormal = (s_liverAbNormal/s_sixMonths)*100;
        }else{
            controller.s_liverNormal = 0;
            controller.s_liverAbNormal = 0;
        }
        controller.graphView = @"liver";
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;
    }

    
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)Hernia{
        [self calculate];
        [self calculateSurgeonData];
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.herniaYES = (herniaYES/sixMonths)*100;
            controller.herniaNO = (herniaNO/sixMonths)*100;
        }else{
            controller.herniaYES = 0;
            controller.herniaNO = 0;
        }
        if(s_sixMonths>0){
            controller.s_herniaYES = (s_herniaYES/s_sixMonths)*100;
            controller.s_herniaNO = (s_herniaNO/s_sixMonths)*100;
        }else{
            controller.s_herniaYES = 0;
            controller.s_herniaNO = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
        controller.graphView = @"hernia";
        controller.showNationalData = _showNationalData;
    
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)CTScan{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        [self calculate];
        [self calculateSurgeonData];
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(twoWeeks>0){
            controller.metastaticDisease = (metastaticDisease/twoWeeks)*100;
            controller.LocalRecurrence = (LocalRecurrence/twoWeeks)*100;
            controller.Lymphadenopathy = (Lymphadenopathy/twoWeeks)*100;
            controller.LiverMetastasis = (LiverMetastasis/twoWeeks)*100;
            controller.BoneMetastasis = (BoneMetastasis/twoWeeks)*100;
            controller.BrainMetastasis = (BrainMetastasis/twoWeeks)*100;
        }else{
            controller.metastaticDisease = 0;
            controller.LocalRecurrence = 0;
            controller.Lymphadenopathy = 0;
            controller.LiverMetastasis = 0;
            controller.BoneMetastasis = 0;
            controller.BrainMetastasis = 0;
        }
        if(s_twoWeeks>0){
            controller.s_metastaticDisease = (s_metastaticDisease/s_twoWeeks)*100;
            controller.s_LocalRecurrence = (s_LocalRecurrence/s_twoWeeks)*100;
            controller.s_Lymphadenopathy = (s_Lymphadenopathy/s_twoWeeks)*100;
            controller.s_LiverMetastasis = (s_LiverMetastasis/s_twoWeeks)*100;
            controller.s_BoneMetastasis = (s_BoneMetastasis/s_twoWeeks)*100;
            controller.s_BrainMetastasis = (s_BrainMetastasis/s_twoWeeks)*100;
        }else{
            controller.s_metastaticDisease = 0;
            controller.s_LocalRecurrence = 0;
            controller.s_Lymphadenopathy = 0;
            controller.s_LiverMetastasis = 0;
            controller.s_BoneMetastasis = 0;
            controller.s_BrainMetastasis = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        controller.graphView = @"CTScan";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
    
        [self calculate];
        [self calculateSurgeonData];
        OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        if(sixMonths>0){
            controller.metastaticDisease = (metastaticDisease/sixMonths)*100;
            controller.LocalRecurrence = (LocalRecurrence/sixMonths)*100;
            controller.Lymphadenopathy = (Lymphadenopathy/sixMonths)*100;
            controller.LiverMetastasis = (LiverMetastasis/sixMonths)*100;
            controller.BoneMetastasis = (BoneMetastasis/sixMonths)*100;
            controller.BrainMetastasis = (BrainMetastasis/sixMonths)*100;
        }else{
            controller.metastaticDisease = 0;
            controller.LocalRecurrence = 0;
            controller.Lymphadenopathy = 0;
            controller.LiverMetastasis = 0;
            controller.BoneMetastasis = 0;
            controller.BrainMetastasis = 0;
        }
        if(s_sixMonths>0){
            controller.s_metastaticDisease = (s_metastaticDisease/s_sixMonths)*100;
            controller.s_LocalRecurrence = (s_LocalRecurrence/s_sixMonths)*100;
            controller.s_Lymphadenopathy = (s_Lymphadenopathy/s_sixMonths)*100;
            controller.s_LiverMetastasis = (s_LiverMetastasis/s_sixMonths)*100;
            controller.s_BoneMetastasis = (s_BoneMetastasis/s_sixMonths)*100;
            controller.s_BrainMetastasis = (s_BrainMetastasis/s_sixMonths)*100;
        }else{
            controller.s_metastaticDisease = 0;
            controller.s_LocalRecurrence = 0;
            controller.s_Lymphadenopathy = 0;
            controller.s_LiverMetastasis = 0;
            controller.s_BoneMetastasis = 0;
            controller.s_BrainMetastasis = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
        controller.graphView = @"CTScan";
        controller.showNationalData = _showNationalData;
        
        [self.navigationController pushViewController:controller animated:YES];
    
    }
    
}


-(void)BUN{
        [self calculate];
        [self calculateSurgeonData];

    NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunSum);
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"AverageBUN";
        if(sixMonths>0){
            controller.averageBun = bunSum/sixMonths;
            
        }else{
            controller.averageBun = 0;
            
        }
        if(s_sixMonths>0){
            controller.s_averageBun = s_bunSum/s_sixMonths;
            
        }else{
            controller.s_averageBun = 0;
            
        }
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
}


-(void)Creatinine{
        [self calculate];
        [self calculateSurgeonData];
        NSLog(@" ^^^^^^ SUM OF Creatinine  : %f",creatinineSum);
    OKFollowUpDataCompareVC *controller = [[OKFollowUpDataCompareVC alloc] initWithNibName:@"OKFollowUpDataCompareVC" bundle:nil];
        controller.graphView = @"AverageCreatinine";
        if(sixMonths>0){
            controller.averageCreatinine = creatinineSum/sixMonths;
        }else{
            controller.averageCreatinine = 0;
        }
        if(s_sixMonths>0){
            controller.s_averageCreatinine = s_creatinineSum/s_sixMonths;
        }else{
            controller.s_averageCreatinine = 0;
        }
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        controller.showNationalData = _showNationalData;

        [self.navigationController pushViewController:controller animated:YES];
}

@end
