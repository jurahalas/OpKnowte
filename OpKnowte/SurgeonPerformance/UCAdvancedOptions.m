//
//  UCAdvancedOptions.m
//  MZUroCapture
//
//  Created by Omer on 7/5/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCAdvancedOptions.h"
#import <QuartzCore/QuartzCore.h>
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
@interface UCAdvancedOptions ()

@end

@implementation UCAdvancedOptions

@synthesize answer1, answer2, answer3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    self.answer1 = @"";
    self.answer2 = @"";
    self.answer3 = @"";
    
}

-(IBAction)questionButtons:(UIButton *)sender{
    
    UIAlertView *alertForPostOp = [[UIAlertView alloc] initWithTitle: @"Answer"
                                                             message: @"\n\n\n\n\n"
                                                            delegate: self
                                                   cancelButtonTitle: @"Cancel"
                                                   otherButtonTitles: @"Done",nil];
    UITextView *textView = [[UITextView alloc] initWithFrame: CGRectMake(12.0, 45.0, 260.0, 112.0)];
    textView.tag = 10;
    textView.font = [UIFont boldSystemFontOfSize:15];
    textView.layer.cornerRadius = 6;
    textView.layer.masksToBounds = YES;
    [alertForPostOp setTransform: CGAffineTransformMakeTranslation(0.0, -100)];
    
    if (sender.tag == 0) {
        
        textView.text = self.answer1;
        
    }else if (sender.tag == 1){
        
        textView.text = self.answer2;
        
    }else if (sender.tag == 2){
        
        textView.text = self.answer3;
    }
    
    [alertForPostOp setTag:sender.tag];
    [alertForPostOp addSubview: textView];
    [alertForPostOp show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1){
        //postOxTxt_.text
        for (UIView *tf in alertView.subviews) {
            NSString *str = [NSString stringWithFormat:@"%@",[tf class]];
            if ([str isEqualToString:@"UITextView"]) {
                [((UITextView *)tf) text];
                
                if ([((UITextView *)tf) tag] == 10) {
                    switch (alertView.tag) {
                        case 0:
                        {
                            self.answer1 = [((UITextField *)tf) text];
                            [UCUtility showBlockView];
                            [UCWebServerHandler addQuestionAnswer:[NSString stringWithFormat:@"%i",alertView.tag+1] answer:self.answer1 withDelegate:self];
                            break;
                        }
                        case 1:
                        {
                            self.answer2 = [((UITextField *)tf) text];
                            [UCUtility showBlockView];
                            [UCWebServerHandler addQuestionAnswer:[NSString stringWithFormat:@"%i",alertView.tag+1] answer:self.answer2 withDelegate:self];
                            break;
                        }
                            
                        case 2:
                        {
                            self.answer3 = [((UITextField *)tf) text];
                            [UCUtility showBlockView];
                            [UCWebServerHandler addQuestionAnswer:[NSString stringWithFormat:@"%i",alertView.tag+1] answer:self.answer3 withDelegate:self];
                            break;
                        }
                            
                        default:
                            break;
                    }
                }
            }
        }
    }
    
}



- (void)AddAnswerSuccessHandler:(ASIHTTPRequest *)request {
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

- (void)AddAnswerErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
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
    
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    /*
    UCHomeScreenViewController *cont = (UCHomeScreenViewController *)[self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:cont animated:YES];
     */
}

@end
