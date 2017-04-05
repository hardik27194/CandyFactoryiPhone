//
//  ChooseStickViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/10/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "ChooseStickViewController.h"
#import "ChooseFlavourLollipopViewController.h"
#import "StickAndAppleViewController.h"
#import "AppDelegate.h"
#import "CandyApplesStiringViewController.h"

@implementation ChooseStickViewController
@synthesize scroll;
@synthesize rgbForFlavour;
@synthesize fromLollipops;
@synthesize fromCandyAppleStiring;
@synthesize isLocked;


- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChooseStickViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChooseStickViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChooseStickViewController" bundle:[NSBundle mainBundle]];
    
    fromLollipops = NO;
    isLocked = NO;
    fromCandyAppleStiring = NO;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(int i = 0; i < 24; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        NSString *test = @"";
        
        if(i < 9)
            test = [NSString stringWithFormat:@"0%d",i+1];
        else
            test = [NSString stringWithFormat:@"%d",i+1];
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if(i % 2 == 0)
                button.frame = CGRectMake(124, (i/2 )*200 +40, 198, 198);
            else button.frame = CGRectMake(446,  (i/2 )*200 +40, 198, 198);
           

            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stickMenu0%@-iPad.png",test]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stickMenu0%@-iPad.png",test]] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stickMenu0%@-iPad.png",test]] forState:UIControlStateHighlighted];
        }
        else
        {
            if(i % 2 == 0)
                button.frame = CGRectMake(50, (i/2 )*90 +20, 84, 84);
            else
                button.frame = CGRectMake(184,  (i/2 )*90 +20, 84, 84);
            
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stickMenu0%@.png",test]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stickMenu0%@.png",test]] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"stickMenu0%@.png",test]] forState:UIControlStateHighlighted];
            
        }
        
        if(isLocked == NO)
        {
            if(i > 3)
            {
                UIImageView *lockImageView = [[UIImageView alloc] init];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    lockImageView.frame = CGRectMake(10, 10, 31, 40);
                    lockImageView.image = [UIImage imageNamed:@"lockStoreEverything-iPad.png"];
                    
                    //[button setEnabled:NO];
                }
                else
                {
                    lockImageView.frame = CGRectMake(10, 10, 31, 40);
                    lockImageView.image = [UIImage imageNamed:@"lockStoreEverything.png"];
                    
                    //[button setEnabled:NO];
                }
                [button addSubview:lockImageView];
            }
        }
        
        button.tag = i+1;
        [button addTarget:self action:@selector(Chocolatechoose:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:button];
        
    }
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        scroll.contentSize = CGSizeMake(768, 2700);
    else
        scroll.contentSize = CGSizeMake(320, 1200);
    
   [self.scroll setContentOffset: CGPointMake(0, scroll.contentSize.height - scroll.frame.size.height) animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.scroll.contentOffset = CGPointMake(0, 0);
     }
     completion:^ (BOOL completed)
     {
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        StoreViewController *store = [[StoreViewController alloc] init];
        [self presentViewController:store animated:YES completion:nil];
    }
}


- (void)Chocolatechoose:(UIButton*)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    if (fromLollipops) {
        
        if (sender.tag > 4 && !isLocked) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the Lollipops pack? This feature will unlock all items and remove ads in Lollipops maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
            [alert show];
        }
        else
        {
        
        NSString *test = @"";
        
        if (sender.tag <= 9)
            test = [NSString stringWithFormat:@"00%d",sender.tag];
        else
            test = [NSString stringWithFormat:@"0%d",sender.tag];
        ChooseFlavourLollipopViewController *core = [[ChooseFlavourLollipopViewController alloc] init];
        core.fromCore = YES;
        core.flavour = self.rgbForFlavour;
            core.isLocked = isLocked;
        core.stickName = [NSString stringWithFormat:@"stick%@.png",test];
        [self.navigationController pushViewController:core animated:YES];
        }
    }
 else
    {
        
        if (sender.tag > 4 && !isLocked) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the CandyApples pack? This feature will unlock all items and remove ads in CandyApples maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
            [alert show];
        }
        else
        {

        
        StickAndAppleViewController *chocolate = [[StickAndAppleViewController alloc] init];
        
        NSString *test = @"";
        
        if (sender.tag <= 9)
            test = [NSString stringWithFormat:@"00%d",sender.tag];
        else
            test = [NSString stringWithFormat:@"0%d",sender.tag];
        
        //    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        //        chocolate.stringApple = [NSString stringWithFormat:@"stick%@-iPad.png",test];
        //    else
        chocolate.stringApple = [NSString stringWithFormat:@"stick%@.png",test];
        chocolate.rgbForFlavour = self.rgbForFlavour;
            
            
            if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
                chocolate.isLocked = YES;
            }

        [self.navigationController pushViewController:chocolate animated:YES];
        }
    }
   
}

- (IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    if(fromCandyAppleStiring == YES)
    {
        NSArray *viewControllers = self.navigationController.viewControllers;
        CandyApplesStiringViewController *previousView = [viewControllers objectAtIndex:[viewControllers count] - 2];
        previousView.backPressed = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
