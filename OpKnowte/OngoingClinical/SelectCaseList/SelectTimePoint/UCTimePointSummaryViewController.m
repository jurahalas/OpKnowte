//
//  UCTimePointSummaryViewController.m
//  MZUroCapture
//
//  Created by Atif Joyia on 18/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCTimePointSummaryViewController.h"
#import "UCESWLTimePoint.h"

@interface UCTimePointSummaryViewController ()

@end

@implementation UCTimePointSummaryViewController

@synthesize caseData, summaryDictionary, tableArray;
@synthesize caseID, timePointID, timePoint, sixMonthsDict;
@synthesize selectedIndexPath, timePointDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.caseData = [[NSMutableDictionary alloc] init];
        self.sixMonthsDict = [[NSMutableDictionary alloc] init];
        self.summaryDictionary = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)update:(id)sender{
    [UCUtility showBlockView];
    if ([self.timePoint isEqualToString:@"Two"]) {
        if([UCAppDelegate sharedObject].selectedUser!=nil)
        {
            [UCWebServerHandler addTwoWeeksOngoingClinicalDetail:self.caseID withTimePointID:timePointID withDictionary:self.caseData withUserID:[[UCAppDelegate sharedObject].selectedUser userID] withDelegate:self];
        }
        else
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [UCWebServerHandler addTwoWeeksOngoingClinicalDetail:self.caseID withTimePointID:timePointID withDictionary:self.caseData withUserID:[defaults objectForKey:UD_USERID] withDelegate:self];
        }
        
    }else if ([self.timePoint isEqualToString:@"Six"]){
        if([UCAppDelegate sharedObject].selectedUser!=nil)
        {
            [UCWebServerHandler addSixWeeksOngoingClinicalDetail:self.caseID withTimePointID:timePointID withDictionary:self.sixMonthsDict withUserID:[[UCAppDelegate sharedObject].selectedUser userID] withDelegate:self];
        }
        else
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [UCWebServerHandler addSixWeeksOngoingClinicalDetail:self.caseID withTimePointID:timePointID withDictionary:self.sixMonthsDict withUserID:[defaults objectForKey:UD_USERID] withDelegate:self];
        }
        
    }
    
}


- (void)AddOnGoingDetailsSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    
    id result = [response JSONValue];
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:[result objectForKey:@"msg"]];
        
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
    
    result = nil;
    response = nil;
}

- (void)AddOnGoingDetailsErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    NSLog(@"%@",self.summaryDictionary);
    self.tableArray = [self.summaryDictionary allKeys];
    if([self.timePoint isEqualToString:@"Two"])
    {
        [self orderKeysForTwoWeeks];
    }
    else if([self.timePoint isEqualToString:@"Two"])
    {
        [self orderKeysForSixWeeks];
        
    }else{
        [self orderKeysForESWL];
    }
    
    
    ////////////////////////////////////////////////
    if (refreshHeaderView_ == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.summaryTable.bounds.size.height, self.view.frame.size.width, self.summaryTable.bounds.size.height)];
		view.delegate = self;
		[self.summaryTable addSubview:view];
		refreshHeaderView_ = view;
	}
	
	//  update the last update date
	[refreshHeaderView_ refreshLastUpdatedDate];
    ////////////////////////////////////////////////
    
}


-(void)orderKeysForESWL{
    NSMutableArray *temp = [tableArray mutableCopy];
    
    //Follow up
    //Fragmentation for stone 

    
    for(int i=0;i<tableArray.count;i++)
    {
        if([[tableArray objectAtIndex:i] isEqualToString:@"Follow up"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:0];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Complications"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:1];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Fragmentation for stone 1"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:2];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Fragmentation for stone 2"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:3];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Fragmentation for stone 3"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:4];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Fragmentation for stone 4"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:5];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Fragmentation for stone 5"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:6];
        }
        
    }
    tableArray = temp;
    
}

- (void)orderKeysForTwoWeeks{
    NSMutableArray *temp = [tableArray mutableCopy];

    for(int i=0;i<tableArray.count;i++)
    {
        if([[tableArray objectAtIndex:i] isEqualToString:@"T"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:0];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"N"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:1];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"M"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:2];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Tumor Characterictics"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:3];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Fuhrman Grade"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:4];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Pre-operative Bun"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:5];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Pre-operative Creatinine"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:6];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Post-operative Bun"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:7];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Post-operative Creatinine"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:8];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Margins"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:9];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Deep Margin"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:10];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Post-Op Hospital Stay"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:11];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Complications"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:12];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Additional Diagnosis"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:13];
        }
        
    }
    tableArray = temp;
}

-(void)orderKeysForSixWeeks{
    NSMutableArray *temp = [tableArray mutableCopy];
    for(int i=0;i<tableArray.count;i++)
    {
        if([[tableArray objectAtIndex:i] isEqualToString:@"Chest X-ray"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:0];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"CT-Scan"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:1];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Bun"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:2];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Creatinine"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:3];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Liver Enzymes"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:4];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Port Site Hernia"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:5];
        }
        else if([[tableArray objectAtIndex:i] isEqualToString:@"Other"])
        {
            [temp setObject:[tableArray objectAtIndex:i] atIndexedSubscript:6];
        }
        
    }
    tableArray = temp;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectCaseCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell.textLabel setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:15]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    [cell.textLabel setText:[self.tableArray objectAtIndex:indexPath.row]];
    
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"PTSans-Regular" size:15]];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.4863f green:0.7294f blue:0.7333 alpha:1.0f]];
    [cell.detailTextLabel setText:[self.summaryDictionary objectForKey:[self.tableArray objectAtIndex:indexPath.row]]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    self.selectedIndexPath = indexPath;
    
    UIAlertView *alertForPostOp = [[UIAlertView alloc] initWithTitle: [self.tableArray objectAtIndex:indexPath.row]
                                                             message: @"\n\n\n\n\n"
                                                            delegate: self
                                                   cancelButtonTitle: @"Cancel"
                                                   otherButtonTitles: @"OK",nil];
    [alertForPostOp setTag:202];
	UITextView *textView = [[UITextView alloc] initWithFrame: CGRectMake(12.0, 45.0, 260.0, 112.0)];
    textView.tag = 10;
	textView.font = [UIFont boldSystemFontOfSize:15];
	textView.layer.cornerRadius = 6;
	textView.layer.masksToBounds = YES;
	[alertForPostOp setTransform: CGAffineTransformMakeTranslation(0.0, -100)];
    textView.text = [self.summaryDictionary objectForKey:[self.tableArray objectAtIndex:indexPath.row]];
	[alertForPostOp addSubview: textView];
	[alertForPostOp show];
     */
    
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    NSLog(@"DO SOMETHING");
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[refreshHeaderView_ egoRefreshScrollViewDataSourceDidFinishedLoading:self.summaryTable];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to edit enteries" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alert.tag = 100;
    [alert show];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[refreshHeaderView_ egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[refreshHeaderView_ egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


#pragma mark UIAlertViewDelagate Methods


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            
            if ([self.timePoint isEqualToString:@"Two"]) {
                
                UCTWTPPageOneViewController *controller = [[UCTWTPPageOneViewController alloc] initWithNibName:@"UCTWTPPageOneViewController" bundle:nil];
                controller.caseData = [self.caseData mutableCopy];
                controller.timePoint = self.timePointDictionary;
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if ([self.timePoint isEqualToString:@"Six"]){
                
                UCSixMonthTimePointViewController *controller = [[UCSixMonthTimePointViewController alloc] initWithNibName:@"UCSixMonthTimePointViewController" bundle:nil];
                
                controller.caseData = [self.caseData mutableCopy];
                controller.timePoint = self.timePointDictionary;
                
                [self.navigationController pushViewController:controller animated:YES];
                
            }else{
                UCESWLTimePoint *controller = [[UCESWLTimePoint alloc] initWithNibName:@"UCESWLTimePoint" bundle:nil];
                
                controller.stonesCount = [self.caseData objectForKey:@"Stones_Count"];
                controller.caseID = [self.caseData objectForKey:@"DetailID"];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
    }
    
    
    if (alertView.tag == 202) {
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            
            for (UIView *tf in alertView.subviews) {
                NSString *str = [NSString stringWithFormat:@"%@",[tf class]];
                if ([str isEqualToString:@"UITextView"]) {
                    [((UITextView *)tf) text];
                    
                    if ([((UITextView *)tf) tag] == 10) {
                        //postOxTxt_.text = [((UITextField *)tf) text];
                        [self.summaryDictionary setObject:[((UITextField *)tf) text] forKey:[self.tableArray objectAtIndex:self.selectedIndexPath.row]];
                        [self.summaryTable reloadData];
                    }
                }
            }
        }
    }
}

@end
