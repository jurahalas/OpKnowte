//
//  OKSelectContactTypeVC.m
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectContactTypeVC.h"
#import "OKSelectContactsVC.h"
@interface OKSelectContactTypeVC () <OKSelectContactsVCDelegate>
@property (strong, nonatomic) IBOutlet UITableView *selectTypeTable;
@property (strong, nonatomic) NSMutableArray *choosedContacts;

@end

@implementation OKSelectContactTypeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataDict =  @{@"Surgeons":@"1",
                       @"Others":@"6"};
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    _selectTypeTable.backgroundColor = [UIColor clearColor];
    self.selectTypeTable.dataSource = self;
    self.selectTypeTable.delegate = self;
    _selectTypeTable.frame = CGRectMake(_selectTypeTable.frame.origin.x, _selectTypeTable.frame.origin.y, _selectTypeTable.frame.size.width, (_selectTypeTable.frame.size.height - 57.f));
    [self.selectTypeTable reloadData];
}


- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate setChoosedContactsArray:_choosedContacts];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromContactTypeToSelectContacts"]){
        OKSelectContactsVC *contactVC = (OKSelectContactsVC*)segue.destinationViewController;
        contactVC.delegate = self;
        contactVC.contactID = [self.dataDict valueForKey:sender];
    }
}
-(void)setChoosedContactsArray:(NSMutableArray *)contactsArray{
    _choosedContacts = contactsArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataDict.allKeys.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contactsType";
    OKSelectContactTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKSelectContactTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.contactTypeLabel.text = [self.dataDict.allKeys objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"fromContactTypeToSelectContacts" sender:self.dataDict.allKeys[indexPath.row]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end