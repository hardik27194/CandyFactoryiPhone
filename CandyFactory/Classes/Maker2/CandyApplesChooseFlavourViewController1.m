//
//  CandyApplesChooseFlavourViewController1.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/11/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "CandyApplesChooseFlavourViewController1.h"
#import "AppDelegate.h"
#import "StoreViewController.h"
@implementation CandyApplesChooseFlavourViewController1
@synthesize _isLocked;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CandyApplesChooseFlavourViewController1-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CandyApplesChooseFlavourViewController1-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CandyApplesChooseFlavourViewController1" bundle:[NSBundle mainBundle]];
    
    return self;
}

- (void)viewDidLoad
{
   
}


- (void)viewWillAppear:(BOOL)animated
{
    for (int i = 0; i < 20; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        NSString *test = @"";
        
        if(i < 9)
            test = [NSString stringWithFormat:@"0%d",i+1];
        else
            test = [NSString stringWithFormat:@"%d",i+1];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if(i%2 == 0)
                button.frame = CGRectMake(124, (i/2 )*200 +40, 198, 198);
            else
                button.frame = CGRectMake(446,  (i/2 )*200 +40, 198, 198);
            
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flavour0%@-iPad.png",test]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flavour0%@-iPad.png",test]] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flavour0%@-iPad.png",test]] forState:UIControlStateHighlighted];
        }
        else
        {
            if(i%2 == 0)
                button.frame = CGRectMake(50, (i/2)*90 +20, 84, 84);
            else
                button.frame = CGRectMake(184,  (i/2)*90 +20, 84, 84);
            
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flavour0%@.png",test]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flavour0%@.png",test]] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flavour0%@.png",test]] forState:UIControlStateHighlighted];
        }
        
        if(_isLocked == NO)
        {
            if(i > 3)
            {
                UIImageView *lockImageView = [[UIImageView alloc] init];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    lockImageView.frame = CGRectMake(10, 10, 31, 40);
                    lockImageView.image = [UIImage imageNamed:@"lockStoreEverything-iPad.png"];
                    
                   // [button setEnabled:NO];
                }
                else
                {
                    lockImageView.frame = CGRectMake(10, 10, 31, 40);
                    lockImageView.image = [UIImage imageNamed:@"lockStoreEverything.png"];
                    
                   // [button setEnabled:NO];
                }
                [button addSubview:lockImageView];
            }
        }
        button.tag = i;
        [button addTarget:self action:@selector(Chocolatechoose:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:button];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.scroll.contentSize = CGSizeMake(768,2000);
    else
        self.scroll.contentSize = CGSizeMake(320,1000);
    
    self.scroll.contentOffset = CGPointMake(0, self.scroll.contentSize.height - self.scroll.frame.size.height);
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
    {
         self.scroll.contentOffset = CGPointMake(0, 0);
    }
    completion:^ (BOOL completed)
    {
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        StoreViewController *store = [[StoreViewController alloc] init];
        [self presentViewController:store animated:YES completion:nil];
    }
}

- (void)Chocolatechoose:(UIButton*)sender
{
    if (sender.tag > 3 && _isLocked == NO) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the CandyApples pack? This feature will unlock all items and remove ads in CandyApples maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
        [alert show];
    }
    else
    {
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FlavourSelected" object:[NSNumber numberWithInt:sender.tag]];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
