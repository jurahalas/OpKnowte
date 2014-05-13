//
//  UCUtility.m
//  MZUroCapture
//
//  Created by Salman Iftikhar on 5/13/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCUtility.h"
#import <SBJson4.h>
#import "CONSTANTS.h"
#import "GentatePDFFile.h"

@implementation UCUtility

UIAlertView *blockAlert;

+ (void)showBlockView {
    blockAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    UIActivityIndicatorView *ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [ind setFrame:CGRectMake(0, 0, 30, 30)];
    [ind setCenter:CGPointMake(140, 70)];
    [ind startAnimating];
    [blockAlert addSubview:ind];
    ind = nil;
    
    [blockAlert show];
}

+ (void)hideBlockView {
    [blockAlert dismissWithClickedButtonIndex:0 animated:YES];
    blockAlert = nil;
}

+ (void)showInfoAlertView:(NSString *)title withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

#pragma mark - Email Validation Methods

+ (BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                return TRUE;
            }
        }
    }
    return FALSE;
}

+ (void)setLogInUserDefault:(UCRegisterModel *)userModel {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSString stringWithFormat:@"%@",userModel.userID] forKey:UD_USERID];
    [defaults setValue:[NSString stringWithFormat:@"%@",userModel.firstName] forKey:UD_FIRSTNAME];
    [defaults setValue:[NSString stringWithFormat:@"%@",userModel.lastName] forKey:UD_LASTNAME];
    [defaults setValue:[NSString stringWithFormat:@"%@",userModel.email] forKey:UD_EMAIL];
    [defaults setValue:[NSString stringWithFormat:@"%@",userModel.pswd] forKey:UD_PASSWORD];
    [defaults setValue:[NSString stringWithFormat:@"%@",userModel.title] forKey:UD_TITLE];
    [defaults synchronize];
}


+ (NSMutableArray *)getProceduresList:(id)response{
    NSMutableArray *procedureArray = [[NSMutableArray alloc] init];
    NSArray *tempArr = response;
    
    if (tempArr && [tempArr count] > 0) {
        for (NSDictionary *dict in tempArr) {
            UCProcdureModel *procModel = [[UCProcdureModel alloc]init];
            procModel.procedureID = [dict objectForKey:@"ProcId"];
            procModel.procedureText = [dict objectForKey:@"ProcText"];
            procModel.procedureShortName = [dict objectForKey:@"ProcNick"];
            
            [procedureArray addObject:procModel];
        }
    }
    else {
        [procedureArray removeAllObjects];
    }
    
    tempArr = nil;
    return procedureArray;
}

+ (UCStatusResponseModel *)getRegistrationObj:(id)response {
    
    NSDictionary *dict = response;
    
    UCStatusResponseModel *registration = [[UCStatusResponseModel alloc] init];
    registration.status = [dict objectForKey:@"status"];
    
    if ([registration.status isEqualToString:@"true"]) {
        UCRegisterModel *model = [[UCRegisterModel alloc] init];
        model.userID = [dict objectForKey:@"USERID"];
        model.firstName = [dict objectForKey:@"FIRSTNAME"];
        model.lastName = [dict objectForKey:@"LASTNAME"];
        model.email = [dict objectForKey:@"EMAILADDRESS"];
        model.pswd = [dict objectForKey:@"PASSWORD"];
        model.title = [dict objectForKey:@"TITLE"];
        [self setLogInUserDefault:model];
        model = nil;
    }
    else {
        registration.message = [dict objectForKey:@"msg"];
    }
    
    dict = nil;
    return registration;
}

+ (id)getLoginDetails:(id)response
{
    NSDictionary *dict = response;
    
    UCStatusResponseModel *login = [[UCStatusResponseModel alloc] init];
    login.status = [dict objectForKey:@"status"];
    
    if ([login.status isEqualToString:@"true"]) {
        UCRegisterModel *model = [[UCRegisterModel alloc] init];
        model.userID = [dict objectForKey:@"USERID"];
        model.firstName = [dict objectForKey:@"FIRSTNAME"];
        model.lastName = [dict objectForKey:@"LASTNAME"];
        model.email = [dict objectForKey:@"EMAILADDRESS"];
        model.pswd = [dict objectForKey:@"PASSWORD"];
        model.title = [dict objectForKey:@"TITLE"];
        [self setLogInUserDefault:model];
        model = nil;
    }
    else {
        login.message = [dict objectForKey:@"msg"];
    }
    
    dict = nil;
    return login;
}

+ (id)getForgotPasswordDetail:(id)response
{
    NSDictionary *dict = response;
    
    UCStatusResponseModel *forgotPassword = [[UCStatusResponseModel alloc] init];
    forgotPassword.status = [dict objectForKey:@"status"];
    forgotPassword.message = [dict objectForKey:@"msg"];
    
    dict = nil;
    return forgotPassword;
}

+ (id)getTemplateDetail:(id)response
{
    NSDictionary *templateDict = response;
    
    UCTemplateResponseModel *templateModel = [[UCTemplateResponseModel alloc]init];
    templateModel.status = [templateDict objectForKey:@"status"];
    
    if ([templateModel.status isEqualToString:@"true"]) {
        templateModel.templateID = [templateDict objectForKey:@"templateID"];
        templateModel.procedureID = [templateDict objectForKey:@"procedureID"];
        templateModel.caseData = [templateDict objectForKey:@"caseData"];
        templateModel.procedureText = [templateDict objectForKey:@"procedureText"];
        templateModel.indicationText = [templateDict objectForKey:@"indicationsText"];
    }
    else {
        templateModel.message = [templateDict objectForKey:@"msg"];
    }
    
    templateDict = nil;
    return templateModel;
}

+ (id)getTemplateDetailVariables:(id)response
{
    NSArray *templatevariables = response;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[templatevariables count]; i++) {
        
        NSDictionary *data = [templatevariables objectAtIndex:i];
        UCTemplateVariablesModel *model = [[UCTemplateVariablesModel alloc] init];
        NSString *key = [data objectForKey:@"varKey"];
        key = [key stringByReplacingOccurrencesOfString:@"(" withString:@""];
        key = [key stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        model.ID = [data objectForKey:@"id"];
        model.key = key;
        model.value = [data objectForKey:@"varValue"];
        
        [tempArray addObject:model];
        
        data = nil;
    }
    
    templatevariables = nil;
    return tempArray;
}

+ (id)getContactInfoList:(id)response
{
    NSMutableArray *assistant = [[NSMutableArray alloc]init];
    NSDictionary *dict = response;
    NSArray *arr = [dict objectForKey:@"contacts"];
    
    if ((arr) && ([arr count] > 0)) {
        for (NSDictionary *dict in arr) {
            UCContactInfoModel *contactInfo = [[UCContactInfoModel alloc]init];
            contactInfo.contactID = [dict objectForKey:@"contactID"];
            contactInfo.contactName = [dict objectForKey:@"name"];
            contactInfo.contactEmail = [dict objectForKey:@"emailAddress"];
            contactInfo.contactNumber = [dict objectForKey:@"ContactNo"];
            contactInfo.contactStreetAddress = [dict objectForKey:@"streetAddress"];
            contactInfo.contactCity = [dict objectForKey:@"city"];
            contactInfo.contactState = [dict objectForKey:@"state"];
            contactInfo.contactZip = [dict objectForKey:@"zip"];
            contactInfo.contactCountry = [dict objectForKey:@"country"];
            contactInfo.contactFax = [dict objectForKey:@"fax"];
            contactInfo.contactRoleID = [dict objectForKey:@"roleID"];
            
            [assistant addObject:contactInfo];
        }
    }
    else {
        [assistant removeAllObjects];
    }
    arr = nil;
    return assistant;
}


+ (id)getContactInfoListFromDictionary:(id)response
{
    NSMutableArray *assistant = [[NSMutableArray alloc]init];
    NSDictionary *obj = response;
    NSArray *arr = [obj objectForKey:@"contacts"];
    if ((arr) && ([arr count] > 0)) {
        for (NSDictionary *dict in arr) {
            UCContactInfoModel *contactInfo = [[UCContactInfoModel alloc]init];
            contactInfo.contactID = [dict objectForKey:@"contactID"];
            contactInfo.contactName = [dict objectForKey:@"name"];
            contactInfo.contactEmail = [dict objectForKey:@"emailAddress"];
            contactInfo.contactNumber = [dict objectForKey:@"ContactNo"];
            contactInfo.contactStreetAddress = [dict objectForKey:@"streetAddress"];
            contactInfo.contactCity = [dict objectForKey:@"city"];
            contactInfo.contactState = [dict objectForKey:@"state"];
            contactInfo.contactZip = [dict objectForKey:@"zip"];
            contactInfo.contactCountry = [dict objectForKey:@"country"];
            contactInfo.contactFax = [dict objectForKey:@"fax"];
            contactInfo.contactRoleID = [dict objectForKey:@"roleID"];
            
            [assistant addObject:contactInfo];
        }
    }
    else {
        [assistant removeAllObjects];
    }
    arr = nil;
    return assistant;
}


+ (id)getEmailsArray:(id)response
{
    NSMutableArray *emails = [[NSMutableArray alloc]init];
    NSDictionary *dict = response;
    NSArray *arr = [dict objectForKey:@"contacts"];
    NSArray *array = [self sortCasesAccordingToDate:arr];
    
    if ((array) && ([array count] > 0)) {
        
        for (NSDictionary *dict in array) {
            NSString *str = [dict objectForKey:@"DateOfService"];
            [emails addObject:str];
        }
    }
    else {
        [emails removeAllObjects];
    }
    arr = nil;
    array = nil;
    return emails;
}

+(NSArray *)sortCasesAccordingToDate:(NSArray *)array{
    NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *c1, NSDictionary *c2)
                         {
                             NSString *date1 = [c1 objectForKey:@"DateOfService"];
                             NSString *date2 = [c2 objectForKey:@"DateOfService"];
                             NSDate *d1;// = [[NSDate alloc] init];
                             NSDate *d2;// = [[NSDate alloc] init];
                             NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                             [dateFormat1 setDateFormat:@"MM-dd-yyyy"];
                             d1 = [dateFormat1 dateFromString:date1];
                             d2 = [dateFormat1 dateFromString:date2];
                             return [d1 compare:d2];
                         } ];
    
    NSArray *ary = [newArray mutableCopy];
    return ary;
}


+ (id)getAccessList:(id)response{
    
    NSMutableArray *list = [[NSMutableArray alloc]init];
    NSArray *arr = response;
    
    if ((arr) && ([arr count] > 0)) {
        
        for (NSDictionary *dict in arr) {
            UCRegisterModel *model = [[UCRegisterModel alloc] init];
            
            model.userID = [dict objectForKey:@"USERID"];
            model.firstName = [dict objectForKey:@"FIRSTNAME"];
            model.lastName = [dict objectForKey:@"LASTNAME"];
            model.email = [dict objectForKey:@"EMAILADDRESS"];
            model.pswd = [dict objectForKey:@"PASSWORD"];
            model.title = [dict objectForKey:@"TITLE"];
            
            [list addObject:model];
        }
    }
    else {
        [list removeAllObjects];
    }
    arr = nil;
    return list;
    
}


+ (id)getAge:(NSString *)DOB{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSDate *date = [dateFormatter dateFromString:DOB];
    NSDateComponents *diff = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date toDate:[NSDate date] options:0];
    dateFormatter = nil;
    
    return [NSString stringWithFormat:@"%i years old",[diff year]];
}


+ (NSString *)getCommaSeparatedString:(NSArray *)arrayOfString{
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for(int i=0;i<arrayOfString.count;i++)
    {
        NSLog(@"%@",[arrayOfString objectAtIndex:i]);
        [str appendString:[arrayOfString objectAtIndex:i]];
        if(i!=(arrayOfString.count-1))
        {
            [str appendString:@","];
        }
    }
    
    NSLog(@"%@",str);
    return str;
}

//var_patientName, var_patientDOB, var_age, var_DOS, var_MRNumber, var_sex, var_cysto, var_postOp, var_surgeon, var_anesthesiologist, var_assistant, var_history, var_bmi, var_tumorChar, var_location, var_tumorSize, var_adhTook, var_adhesions, var_vasAnomolies, var_cc, var_clamp, var_complation, var_coagulant, var_counselTime, var_bloodLoss, var_margin, var_renalUltraSound, var_transfusion, var_RCSRepair, var_roomTime, var_preOp, var_preSide, var_procedureName;

+ (UCLRPNModel *)getCaseMode:(NSMutableDictionary *)selectedCase{
    UCLRPNModel *parentModel = [[UCLRPNModel alloc] init];
    
    parentModel.var_patientName = [selectedCase objectForKey:@"Patient_Name"];
    parentModel.var_patientDOB = [selectedCase objectForKey:@"Patient_Dob"];
    parentModel.var_age = [UCUtility getAge:[selectedCase objectForKey:@"Patient_Dob"]];
    parentModel.var_DOS = [selectedCase objectForKey:@"DateOfService"];
    parentModel.var_MRNumber = [selectedCase objectForKey:@"MRNumber"];
    parentModel.var_sex = [selectedCase objectForKey:@"Gender"];
    parentModel.var_cysto = [selectedCase objectForKey:@"CytoStent"];
    parentModel.var_postOp = [selectedCase objectForKey:@"Post_Op"];
    parentModel.var_surgeon = [selectedCase objectForKey:@"SurgeonName"];
    parentModel.var_anesthesiologist = [selectedCase objectForKey:@"Anesthesiologist"];
    parentModel.var_assistant = [selectedCase objectForKey:@"Assistants"];
    parentModel.var_history = [selectedCase objectForKey:@"Previous_AS"];
    parentModel.var_bmi = [selectedCase objectForKey:@"BMI"];
    parentModel.var_tumorChar = [selectedCase objectForKey:@"Tumor_Char"];
    parentModel.var_location = [selectedCase objectForKey:@"Location"];
    parentModel.var_tumorSize = [selectedCase objectForKey:@"TumorSize_cm"];
    parentModel.var_adhTook = [selectedCase objectForKey:@"Adhesiolyst"];
    parentModel.var_adhesions = [selectedCase objectForKey:@"Intra_AA"];
    parentModel.var_vasAnomolies = [selectedCase objectForKey:@"Vascular_Anomalies"];
    parentModel.var_cc = [selectedCase objectForKey:@"Carbon_Copy"];
    parentModel.var_clamp = [selectedCase objectForKey:@"Clamp_Tim"];
    parentModel.var_complation = [selectedCase objectForKey:@"Complations"];
    parentModel.var_coagulant = [selectedCase objectForKey:@"Use_Coagulants"];
    parentModel.var_counselTime = [selectedCase objectForKey:@"Counsel_Time"];
    parentModel.var_bloodLoss = [selectedCase objectForKey:@"Blood_loss"];
    parentModel.var_margin = [selectedCase objectForKey:@"Deep_Margin"];
    parentModel.var_renalUltraSound = [selectedCase objectForKey:@"Renal_Ultrasound"];
    parentModel.var_transfusion = [selectedCase objectForKey:@"Transustion"];
    parentModel.var_RCSRepair = [selectedCase objectForKey:@"Renal_Coll_SR"];
    parentModel.var_roomTime = [selectedCase objectForKey:@"Room_Time"];
    parentModel.var_preOp = [selectedCase objectForKey:@"Pre_Op_1"];
    parentModel.var_preSide = [selectedCase objectForKey:@"Pre_Op_2"];
    parentModel.var_procedureName = [selectedCase objectForKey:@"PROCEDURE_ID"];
    
    return parentModel;
}


+ (void)deletePDF:(NSString *)path withDelay:(int)delay{
    [self performSelector:@selector(deleteFile:) withObject:path afterDelay:delay];
}

+(void)deleteFile:(NSString *)fileName{
    NSLog(@"%@",fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];
}

@end
