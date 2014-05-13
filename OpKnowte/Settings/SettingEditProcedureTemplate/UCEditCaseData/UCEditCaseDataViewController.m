//
//  UCEditCaseDataViewController.m
//  MZUroCapture
//
//  Created by Atif Joyia on 22/05/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCEditCaseDataViewController.h"

@interface UCEditCaseDataViewController ()

@end

@implementation UCEditCaseDataViewController

@synthesize headerLbl;
@synthesize parent;
@synthesize caseDataTable;
@synthesize tableArray;
@synthesize caseDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.tableArray = [[NSMutableArray alloc] init];
        //self.caseDataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(IS_IPHONE_5)
    {
        headerLbl.frame=CGRectMake(headerLbl.frame.origin.x, headerLbl.frame.origin.y+5, headerLbl.frame.size.width, headerLbl.frame.size.height);
    }
    [headerLbl setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.parent.templateVariables count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UCTemplateVariablesModel *model = [self.parent.templateVariables objectAtIndex:indexPath.row];
    
    if ([self.caseDataArray containsObject:model.key]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    [cell.textLabel setText:[model value]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 0 && indexPath.row !=1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        UCTemplateVariablesModel *model = [self.parent.templateVariables objectAtIndex:indexPath.row];
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self.caseDataArray removeObject:model.key];
            
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.caseDataArray addObject:model.key];
            
        }
    }
}

-(void)sortArray{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<self.parent.templateVariables.count; i++) {
        UCTemplateVariablesModel *model = [self.parent.templateVariables objectAtIndex:i];
        
        if ([self.caseDataArray containsObject:model.key]) {
            [tempArray addObject:model.key];
        }
    }
    
    [self.caseDataArray removeAllObjects];
    self.caseDataArray = [tempArray mutableCopy];
    tempArray = nil;
    
}

-(IBAction)back:(id)sender{
    
    NSLog(@"%i",[self.caseDataArray count]);
    
    [self sortArray];
    
    if ([self.caseDataArray count] >0) {
        
        NSString *caseData = [[NSString alloc] init];
        
        for (int i = 0; i < [self.caseDataArray count]; i++) {
            NSString *str = [self.caseDataArray objectAtIndex:i];
            caseData = [caseData stringByAppendingFormat:@"(%@)",str];
            if (i != [self.caseDataArray count] - 1) {
                caseData = [caseData stringByAppendingString:@","];
            }
        }
        self.parent.templateModel.caseData = caseData;
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Select atleast 1 value for Case Data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    
}




@end
