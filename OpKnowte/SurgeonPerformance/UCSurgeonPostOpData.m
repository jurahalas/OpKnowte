//
//  UCSurgeonPostOpData.m
//  MZUroCapture
//
//  Created by Omer on 6/28/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSurgeonPostOpData.h"
#import "UCPostOpDataGraphs.h"
#import "UCAdvancedOptions.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
@interface UCSurgeonPostOpData ()

@end

@implementation UCSurgeonPostOpData

@synthesize selectedCases, sumOfAges, isCalculated, positiveDMargins,maleCount,LRMCount, cytoStentCount,adhesiolysisCount,vasAnomolyCount,intraOpUSCount,renalSRCount,coagulantCount,transfusionCount,consoleTimeCount,roomTimeCount,clampTimeCount,bloodLossCount,tumorSizeCount,bmiCount,maxAge,minAge,minBmi,maxBmi,minClampTime,maxClampTime,minConsoleTime,maxConsoleTime,minRoomTime,maxRoomTime,minBloodLoss,maxBloodLoss,minTumorSize,maxTumorSize;

@synthesize surgeonCases, isNationalData, totalSurgeonCount, totalNationalCount;

@synthesize sur_adhesiolysisCount, sur_bloodLossCount, sur_bmiCount, sur_clampTimeCount, sur_coagulantCount, sur_consoleTimeCount, sur_cytoStentCount, sur_intraOpUSCount, sur_LRMCount, sur_maleCount, sur_maxAge, sur_maxBloodLoss, sur_maxBmi, sur_maxClampTime, sur_maxConsoleTime, sur_maxRoomTime, sur_maxTumorSize, sur_minAge, sur_minBloodLoss, sur_minBmi, sur_minClampTime, sur_minConsoleTime, sur_minRoomTime, sur_minTumorSize, sur_positiveDMargins, sur_renalSRCount, sur_roomTimeCount, sur_sumOfAges, sur_transfusionCount, sur_tumorSizeCount, sur_vasAnomolyCount;


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)AverageAgeOfPatient:(id)sender{

    [self reset];
    [self CalculateValues];
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
    
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
-(IBAction)MaleFemale:(id)sender{
    
    [self reset];
    [self CalculateValues];
    
    float percentage = (maleCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)BMI:(id)sender{
    
    [self reset];
    [self CalculateValues];
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)LeftRightRenalMass:(id)sender{

    [self reset];
    [self CalculateValues];
    
    float percentage = (LRMCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)CytoStent:(id)sender{

    [self reset];
    [self CalculateValues];
    
    float percentage = (cytoStentCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)TumorSize:(id)sender{

    [self reset];
    [self CalculateValues];
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)TumorCharacteristics:(id)sender{}
-(IBAction)AdhesiolysisRequired:(id)sender{

    [self reset];
    [self CalculateValues];
    float percentage=0;
    percentage = (adhesiolysisCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)VascularAnomoly:(id)sender{

    [self reset];
    [self CalculateValues];
    
    float percentage=0;
    percentage = (vasAnomolyCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)IntraOpUltraSound:(id)sender{

    [self reset];
    [self CalculateValues];
    
    float percentage=0;
    percentage = (intraOpUSCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)DeepMargins:(id)sender{
    
    [self reset];
    [self CalculateValues];
    
    float percentage=0;
    percentage = (positiveDMargins/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)Margins:(id)sender{}
-(IBAction)RenalSystemRepair:(id)sender{

    [self reset];
    [self CalculateValues];

    float  percentage = (renalSRCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)AverageClampTime:(id)sender{

    [self reset];
    [self CalculateValues];
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)Coagulants:(id)sender{

    [self reset];
    [self CalculateValues];
    
    float percentage = (coagulantCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)BloodLoss:(id)sender{

    [self reset];
    [self CalculateValues];
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)ConsoleTime:(id)sender{

    [self reset];
    [self CalculateValues];
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)RoomTime:(id)sender{

    [self reset];
    [self CalculateValues];
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
-(IBAction)Complications:(id)sender{}
-(IBAction)TransfusionRequired:(id)sender{

    [self reset];
    [self CalculateValues];
    
    float percentage = 0;
    percentage = (transfusionCount/self.selectedCases.count)*100;
    
    UCPostOpDataGraphs *controller = [[UCPostOpDataGraphs alloc] initWithNibName:@"UCPostOpDataGraphs" bundle:nil];
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
            NSString *dob = [dic objectForKey:@"Patient_Dob"];
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
            if(![[dic objectForKey:@"Deep_Margin"] isEqualToString:@"No"]){
                positiveDMargins+=1;
            }
            if([[dic objectForKey:@"Gender"] isEqualToString:@"Male"]){
                maleCount+=1;
            }
            if([[dic objectForKey:@"Pre_Op_1"] isEqualToString:@"Left renal mass"]){
                LRMCount+=1;
            }
            if(![[dic objectForKey:@"CytoStent"] isEqualToString:@"No"]){
                cytoStentCount+=1;
            }
            if(![[dic objectForKey:@"Adhesiolyst"] isEqualToString:@""]){
                adhesiolysisCount+=1;
            }
            if(![[dic objectForKey:@"Vascular_Anomalies"] isEqualToString:@"No"]){
                vasAnomolyCount+=1;
            }
            if(![[dic objectForKey:@"Renal_Ultrasound"] isEqualToString:@"No"]){
                intraOpUSCount+=1;
            }
            if(![[dic objectForKey:@"Renal_Coll_SR"] isEqualToString:@"No"]){
                renalSRCount+=1;
            }
            if(![[dic objectForKey:@"Use_Coagulants"] isEqualToString:@"No coagulants"]){
                coagulantCount+=1;
            }
            if(![[dic objectForKey:@"Transustion"] isEqualToString:@"No"]){
                transfusionCount+=1;
            }
            if([dic objectForKey:@"TumorSize_cm"]){
                float tsize =[[dic objectForKey:@"TumorSize_cm"] floatValue];
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
            if([dic objectForKey:@"BMI"]){
                float bmi = [[dic objectForKey:@"BMI"] floatValue];
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
            if([dic objectForKey:@"Counsel_Time"]){
                NSString *str = [dic objectForKey:@"Counsel_Time"];
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
            if([dic objectForKey:@"Room_Time"]){
                NSString *str = [dic objectForKey:@"Room_Time"];
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
            if([dic objectForKey:@"Clamp_Tim"]){
                NSString *str = [dic objectForKey:@"Clamp_Tim"];
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
            if([dic objectForKey:@"Blood_loss"]){
                NSString *str = [dic objectForKey:@"Blood_loss"];
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
        NSString *dob = [dic objectForKey:@"Patient_Dob"];
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
        if(![[dic objectForKey:@"Deep_Margin"] isEqualToString:@"No"]){
            sur_positiveDMargins+=1;
        }
        if([[dic objectForKey:@"Gender"] isEqualToString:@"Male"]){
            sur_maleCount+=1;
        }
        if([[dic objectForKey:@"Pre_Op_1"] isEqualToString:@"Left renal mass"]){
            sur_LRMCount+=1;
        }
        if(![[dic objectForKey:@"CytoStent"] isEqualToString:@"No"]){
            sur_cytoStentCount+=1;
        }
        if(![[dic objectForKey:@"Adhesiolyst"] isEqualToString:@""]){
            sur_adhesiolysisCount+=1;
        }
        if(![[dic objectForKey:@"Vascular_Anomalies"] isEqualToString:@"No"]){
            sur_vasAnomolyCount+=1;
        }
        if(![[dic objectForKey:@"Renal_Ultrasound"] isEqualToString:@"No"]){
            sur_intraOpUSCount+=1;
        }
        if(![[dic objectForKey:@"Renal_Coll_SR"] isEqualToString:@"No"]){
            sur_renalSRCount+=1;
        }
        if(![[dic objectForKey:@"Use_Coagulants"] isEqualToString:@"No coagulants"]){
            sur_coagulantCount+=1;
        }
        if(![[dic objectForKey:@"Transustion"] isEqualToString:@"No"]){
            sur_transfusionCount+=1;
        }
        if([dic objectForKey:@"TumorSize_cm"]){
            float tsize =[[dic objectForKey:@"TumorSize_cm"] floatValue];
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
        if([dic objectForKey:@"BMI"]){
            float bmi = [[dic objectForKey:@"BMI"] floatValue];
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
        if([dic objectForKey:@"Counsel_Time"]){
            NSString *str = [dic objectForKey:@"Counsel_Time"];
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
        if([dic objectForKey:@"Room_Time"]){
            NSString *str = [dic objectForKey:@"Room_Time"];
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
        if([dic objectForKey:@"Clamp_Tim"]){
            NSString *str = [dic objectForKey:@"Clamp_Tim"];
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
        if([dic objectForKey:@"Blood_loss"]){
            NSString *str = [dic objectForKey:@"Blood_loss"];
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

-(IBAction)advancedOptions:(id)sender{
    
    if (self.isNationalData) {
        
    }else{
        UCAdvancedOptions *controller = [[UCAdvancedOptions alloc] initWithNibName:@"UCAdvancedOptions" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}


-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

-(IBAction)home:(id)sender{
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


@end
