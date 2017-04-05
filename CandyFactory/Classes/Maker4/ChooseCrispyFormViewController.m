//
//  ChooseCrispyFormViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/21/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "ChooseCrispyFormViewController.h"
#import "CrispyDecoratingViewController.h"
#import "CrispyFinalScreenViewController.h"
#import "AppDelegate.h"

@implementation ChooseCrispyFormViewController
@synthesize scroll;
@synthesize isLocked;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChooseCrispyFormViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChooseCrispyFormViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChooseCrispyFormViewController" bundle:[NSBundle mainBundle]];
    
    isLocked = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for(int i = 0; i < 20; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.height, scroll.frame.size.height)];
        UIButton *selectButton;
        
        UIImageView *apple = [[UIImageView alloc] init];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            apple.image = [UIImage imageNamed:[NSString stringWithFormat:@"cutter%d-4-iPad.png", i+1]];
            apple.frame = CGRectMake(0, 40, 768, 720);
            selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 768, 600)];
            selectButton.center = apple.center;
            selectButton.backgroundColor = [UIColor clearColor];
            selectButton.tag = i;
            [selectButton addTarget:self action:@selector(NextFromApple:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            apple.image = [UIImage imageNamed:[NSString stringWithFormat:@"cutter%di.png", i+1]];
            apple.frame = CGRectMake(0, 40, 325, 309);
            selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            selectButton.center = apple.center;
            selectButton.backgroundColor = [UIColor clearColor];
            selectButton.tag = i;
            [selectButton addTarget:self action:@selector(NextFromApple:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        if(isLocked == NO)
        {
            if(i > 3)
            {
                UIImageView *lockImageView = [[UIImageView alloc] init];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    lockImageView.frame = CGRectMake(10, 10, 251, 315);
                    lockImageView.image = [UIImage imageNamed:@"lockFullSize~ipad.png"];
                    
                   // [selectButton setEnabled:NO];
                }
                else
                {
                    lockImageView.frame = CGRectMake(0, -20, 106, 133);
                    lockImageView.image = [UIImage imageNamed:@"lockFullSize.png"];
                    
                    //[selectButton setEnabled:NO];
                }
                [selectButton addSubview:lockImageView];
            }
        }

        [view addSubview:apple];
        [view addSubview:selectButton];
        
        [scroll addSubview:view];
    }
    scroll.contentSize = CGSizeMake(20*[UIScreen mainScreen].bounds.size.width, scroll.frame.size.height);
    [self.scroll setContentOffset: CGPointMake(scroll.contentSize.width - scroll.frame.size.width*10, 0) animated:NO];
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.scroll.contentOffset = CGPointMake(0, 0);
     } completion:^ (BOOL completed)
     {
         
     }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)BackButtonPressed:(id)sender
{
 
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        StoreViewController *store = [[StoreViewController alloc] init];
        [self presentViewController:store animated:YES completion:nil];
    }
}

- (IBAction)Next:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    NSString *treat;
    int a;
   if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) a =  self.scroll.contentOffset.x/768+1;
   else  a =  self.scroll.contentOffset.x/320+1;

    if (a>4 && !isLocked) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the CrispyRiceTreats pack? This feature will unlock all items and remove ads in CrispyRiceTreats maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
        [alert show];
       }
    else
    {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        treat = [NSString stringWithFormat:@"treat%.0f-4-iPad.png", self.scroll.contentOffset.x/768+1];
    else
        treat = [NSString stringWithFormat:@"treat%.0fi.png", self.scroll.contentOffset.x/320+1];
    
    CrispyDecoratingViewController *final = [[CrispyDecoratingViewController alloc] init];
    final.treatName = treat;
    [self.navigationController pushViewController:final animated:YES];
        
    }
}

- (IBAction)NextFromApple:(UIButton*)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    if (sender.tag > 3 && !isLocked) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the CrispyRiceTreats pack? This feature will unlock all items and remove ads in CrispyRiceTreats maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
        [alert show];
    }
    else
    {
    NSString *treat;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        treat = [NSString stringWithFormat:@"treat%d-4-iPad.png", sender.tag+1];
    else
        treat = [NSString stringWithFormat:@"treat%di.png", sender.tag+1];
    
    CrispyDecoratingViewController *final = [[CrispyDecoratingViewController alloc] init];
    final.treatName = treat;
    [self.navigationController pushViewController:final animated:YES];
    }
}

@end
