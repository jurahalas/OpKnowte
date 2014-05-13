//
//  NSObject+CONSTANTS.h
//  MZUroCapture
//
//  Created by Salman Iftikhar on 5/13/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CONSTANTS : NSObject

+ (NSString*)GetUrl:(NSString*)neededUrl;

@end

//#define     BASEURL                         @"http://izone.us/sds/"

#define     IS_IPHONE_5                     ([[UIScreen mainScreen] bounds].size.height == 568)
#define     GET                             @"GET"
#define     POST                            @"POST"
#define     GET_URL(SERVICE_NAME)           [CONSTANTS GetUrl:SERVICE_NAME]

#define     BASEURL                         @"http://knowte.esy.es/"
//#define     BASEURL                         @"http://162.209.6.44/sds/"
//#define     BASEURL                         @"http://162.209.6.44/sds_development/"
//#define     BASEURL                         @"http://199.192.147.65/sds/"
#define     PASSWORD_SERVICE                @"getPassword?email="
#define     GET_ALL_PROCEDURES              @"getAllProc"
#define     LOGIN_SERVICE                   @"login"
#define     REGISTER_USER                   @"signUpUser"

#define     ADD_CONTACT                     @"addContact"
//#define     GET_CONTACT_LIST                @"getContactsInfo?roleID="
#define     GET_CONTACT_LIST                @"getContactsByUserIDAndRoleID"
#define     DELETE_CONTACT                  @"deleteContact?id="
#define     GET_TEMPLATE                    @"getTemplateBySurgeonIDAndProcedureID"
#define     UPDATE_TEMPLATE                 @"updateTemplate"
#define     GET_TEMPLATE_VARIABLES          @"getTemplateVariablesByProcedureID"
#define     ADD_PROCEDURE_DETAILS           @"addProcedureDetail"
#define     GET_CASE_LIST                   @"getCaseByProcIDSurgeonID"
#define     GET_INSTITUTION_SETTINGS        @"getInstitutionsSetting"
#define     GET_DATASHARING_SETTINGS        @"getDataShareSetting"
#define     GET_CONTACT_SETTINGS            @"getContactSetting"
#define     UPDATE_CONTACT_SETTINGS         @"updateContactSetting"
#define     GET_ACCESS_SETTINGS             @"getAccessSetting"
#define     GET_OTHER_CONTACTS              @"getOtherContacts"
#define     UPDATE_ACCESS_SETTINGS          @"updateAccessSetting"
#define     UPDATE_DATASHARING_SETTINGS     @"updateDataShareSetting"
#define     CONFIRM_PASWORD                 @"confirmPassword"
#define     UPDATE_INSTITUTES               @"updateInstitutionsSetting"
#define     GET_USER_ACCESS                 @"getUsersAccess"
#define     GET_REMINDER_SETTINGS           @"getReminderSetting"
#define     UPDATE_REMINDER_SETTINGS        @"updateReminderSetting"
#define     CHANGE_PASWORD                  @"changePassword"
#define     GET_ALL_TIMEPOINTS              @"getAllTimePoints"
#define     ADD_ONGOING_CLINICAL_DETAIL     @"addOngoingClinicalDetail"
#define     GET_ONGOING_CLINICAL_DETAIL     @"getOngoingClinicalDetail"
#define     GET_SURGEON_PERFORMANCE_DATA    @"getSurgeonPerformanceData"
#define     GET_CLINICAL_DETAIL             @"getClinicalDetailByCaseIDs"
#define     GET_NATIONAL_DATA               @"getSharedCases"
#define     GET_SURGEON_DATES               @"getSurgeonDates"
#define     GET_NATIONAL_DATES              @"getNationalDates"
#define     ADD_QUESTION_ANSWER             @"insertQuestionAnswers"
#define     SEND_FAX                        @"sendFaxByUserId"
#define     CHECK_MR_NUMBER                 @"checkMRNumber"
//checkMRNumber


//insertQuestionAnswers
//Template Keys
#define     INDICATIONS_TEMPLATE            @"indicationsText"
#define     PROCEDURE_TEMPLATE              @"procedureText"
#define     CASEDATA_TEMPLATE               @"caseData"
#define     PROCEDURE_ID                    @"procedureID"
#define     SERGEON_ID                      @"surgeonID"


#define     UD_USERID                       @"userID"
#define     UD_FIRSTNAME                    @"firstName"
#define     UD_LASTNAME                     @"lastName"
#define     UD_EMAIL                        @"email"
#define     UD_PASSWORD                     @"password"
#define     UD_TITLE                        @"title"
#define     UD_INTRO_KEY                    @"introduction"


#define     ROLE_SURGEON_ID                 @"1"
#define     ROLE_ASSISTANT_ID               @"2"
#define     ROLE_ANESTHESIOLOGIST_ID        @"3"
#define     ROLE_INSTITUTIONS_ID            @"4"
#define     ROLE_PHYSICIAN_ID               @"5"
#define     ROLE_OTHERS_ID                  @"6"

//2 WEEKS
#define     T_STAGE                       @"tStage"
#define     N_STAGE                       @"nStage"
#define     M_STAGE                       @"mStage"
#define     TUMOR_CHAR_STAGE              @"tumorChar"
#define     FUHRMAN_GRAGE_STAGE           @"fuhrmanGrade"
#define     MARGIN_STAGE                  @"margins"
#define     DEEP_MARGIN_STAGE             @"deepMargin"
#define     NIGHTS_STAGE                  @"lengthOfStay"
#define     COMPLICATIONS_STAGE           @"complications"
#define     PREOP_BUN_STAGE               @"preOperativeBun"
#define     PREOP_CRATININE_STAGE         @"preOperativeCreatinine"
#define     POSTOP_BUN_STAGE              @"postOperativeBun"
#define     POSTOP_CREATININE_STAGE       @"postOperativeCreatinine"
#define     ADD_DIAGNOSIS_STAGE           @"additionalDiagnosis"

//6 WEEKS
#define     XRAY_STAGE                    @"chestXray"
#define     BUN_CREATININE_STAGE          @"BunCreatinine"
#define     LIVER_ENZYMES_STAGE           @"liverEnzymes"
#define     HERNIA_STAGE                  @"portSiteHemia"
#define     OTHER_STAGE                   @"other"
#define     CT_SCAN_STAGE                 @"CtScan"
#define     BUN_STAGE                     @"Bun"
#define     CREATININE_STAGE              @"Creatinine"



