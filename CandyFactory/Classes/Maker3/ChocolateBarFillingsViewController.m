//
//  ChocolateBarFillingsViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/25/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "ChocolateBarFillingsViewController.h"
#import "ChocolateBarsChooseFillingViewController.h"
#import "ChocolateBarPourChocolateViewController.h"
#import "AppDelegate.h"

@interface ChocolateBarFillingsViewController ()
{
    int howMany;
    BOOL first;
}
@end

@implementation ChocolateBarFillingsViewController

@synthesize filling1;
@synthesize filling2;
@synthesize filling3;
@synthesize nextButton;
@synthesize chooseButton;
@synthesize label;
@synthesize rgbFlavour;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChocolateBarFillingsViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChocolateBarFillingsViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChocolateBarFillingsViewController" bundle:[NSBundle mainBundle]];
    
    howMany = 0;
    first = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(LayerChoosed:) name:@"LayerChoosed" object:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        filling1.frame = CGRectMake(filling1.frame.origin.x,-761, filling1.frame.size.width, filling1.frame.size.height);
        filling2.frame = CGRectMake(filling2.frame.origin.x,-689, filling2.frame.size.width, filling2.frame.size.height);
        filling3.frame = CGRectMake(filling3.frame.origin.x,-619, filling3.frame.size.width, filling3.frame.size.height);
    }
    else if([UIScreen mainScreen].bounds.size.height == 568)
    {
        filling1.frame = CGRectMake(filling1.frame.origin.x, -441, filling1.frame.size.width, filling1.frame.size.height);
        filling2.frame = CGRectMake(filling2.frame.origin.x, -405, filling2.frame.size.width, filling2.frame.size.height);
        filling3.frame = CGRectMake(filling3.frame.origin.x, -373, filling3.frame.size.width, filling3.frame.size.height);
    }
    else
    {
        filling1.frame = CGRectMake(filling1.frame.origin.x, -374, filling1.frame.size.width, filling1.frame.size.height);
        filling2.frame = CGRectMake(filling2.frame.origin.x, -338, filling2.frame.size.width, filling2.frame.size.height);
        filling3.frame = CGRectMake(filling3.frame.origin.x, -306, filling3.frame.size.width, filling3.frame.size.height);
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (first && howMany == 0)
        {
            filling1.frame = CGRectMake(filling1.frame.origin.x,-761, filling1.frame.size.width, filling1.frame.size.height);
            filling2.frame = CGRectMake(filling2.frame.origin.x,-689, filling2.frame.size.width, filling2.frame.size.height);
            filling3.frame = CGRectMake(filling3.frame.origin.x,-619, filling3.frame.size.width, filling3.frame.size.height);
            [UIView beginAnimations:@"fall" context:nil];
            [UIView setAnimationDuration:0.5];
            label.frame = CGRectMake(label.frame.origin.x, 0, label.frame.size.width, label.frame.size.height);
            chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, 0, chooseButton.frame.size.width, chooseButton.frame.size.height);
            [UIView commitAnimations];
        }
        if (!first && howMany == 0) {
            first = YES;
            [UIView beginAnimations:@"fall" context:nil];
            [UIView setAnimationDuration:0.5];
            label.frame = CGRectMake(label.frame.origin.x,0, label.frame.size.width, label.frame.size.height);
            chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, 0, chooseButton.frame.size.width, chooseButton.frame.size.height);
            [UIView commitAnimations];
            
        }
        

    }
    else if([UIScreen mainScreen].bounds.size.height == 568)
    {
        if (first && howMany == 0) {
            filling1.frame = CGRectMake(filling1.frame.origin.x,-441, filling1.frame.size.width, filling1.frame.size.height);
            filling2.frame = CGRectMake(filling2.frame.origin.x,-405, filling2.frame.size.width, filling2.frame.size.height);
            filling3.frame = CGRectMake(filling3.frame.origin.x,-373, filling3.frame.size.width, filling3.frame.size.height);
            [UIView beginAnimations:@"fall" context:nil];
            [UIView setAnimationDuration:0.5];
            label.frame = CGRectMake(label.frame.origin.x, 0, label.frame.size.width, label.frame.size.height);
            chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, 0, chooseButton.frame.size.width, chooseButton.frame.size.height);
            [UIView commitAnimations];
            
        }
        if (!first && howMany == 0) {
            first = YES;
            [UIView beginAnimations:@"fall" context:nil];
            [UIView setAnimationDuration:0.5];
            label.frame = CGRectMake(label.frame.origin.x, 0, label.frame.size.width, label.frame.size.height);
            chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, 0, chooseButton.frame.size.width, chooseButton.frame.size.height);
            [UIView commitAnimations];
        }
    }
    else
    {
        if (first && howMany == 0) {
            filling1.frame = CGRectMake(filling1.frame.origin.x,-374, filling1.frame.size.width, filling1.frame.size.height);
            filling2.frame = CGRectMake(filling2.frame.origin.x,-338, filling2.frame.size.width, filling2.frame.size.height);
            filling3.frame = CGRectMake(filling3.frame.origin.x,-306, filling3.frame.size.width, filling3.frame.size.height);
            [UIView beginAnimations:@"fall" context:nil];
            [UIView setAnimationDuration:0.5];
            label.frame = CGRectMake(label.frame.origin.x, 0, label.frame.size.width, label.frame.size.height);
            chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, 0, chooseButton.frame.size.width, chooseButton.frame.size.height);
            [UIView commitAnimations];
            
        }
        if (!first && howMany == 0) {
            first = YES;
            [UIView beginAnimations:@"fall" context:nil];
            [UIView setAnimationDuration:0.5];
            label.frame = CGRectMake(label.frame.origin.x, 0, label.frame.size.width, label.frame.size.height);
            chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, 0, chooseButton.frame.size.width, chooseButton.frame.size.height);
            [UIView commitAnimations];
        }
    }
        
    [super viewWillAppear:animated];
       
}

-(void)viewDidAppear:(BOOL)animated
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        switch (howMany)
        {
            case 1:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling1.frame = CGRectMake(filling1.frame.origin.x,filling1.frame.origin.y+761*2, filling1.frame.size.width, filling1.frame.size.height);
                
                [UIView commitAnimations];
                break;
                
            case 2:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling2.frame = CGRectMake(filling2.frame.origin.x,filling2.frame.origin.y+689*2, filling2.frame.size.width, filling2.frame.size.height);
                
                [UIView commitAnimations];
                break;
            case 3:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling3.frame = CGRectMake(filling3.frame.origin.x,filling3.frame.origin.y+619*2, filling3.frame.size.width, filling3.frame.size.height);
                label.frame = CGRectMake(label.frame.origin.x, -100, label.frame.size.width, label.frame.size.height);
                chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, -100, chooseButton.frame.size.width, chooseButton.frame.size.height);
                nextButton.enabled = YES;
                [UIView commitAnimations];
                break;
                
            default:
                break;
        }

    }
    else if([UIScreen mainScreen].bounds.size.height == 568)
    {
        switch(howMany)
        {
            case 1:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling1.frame = CGRectMake(filling1.frame.origin.x,filling1.frame.origin.y + 441*2, filling1.frame.size.width, filling1.frame.size.height);
                
                [UIView commitAnimations];
                break;
                
            case 2:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling2.frame = CGRectMake(filling2.frame.origin.x,filling2.frame.origin.y + 405*2, filling2.frame.size.width, filling2.frame.size.height);
                
                [UIView commitAnimations];
                break;
                
            case 3:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling3.frame = CGRectMake(filling3.frame.origin.x,filling3.frame.origin.y + 373*2, filling3.frame.size.width, filling3.frame.size.height);
                label.frame = CGRectMake(label.frame.origin.x, -50, label.frame.size.width, label.frame.size.height);
                chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, -50, chooseButton.frame.size.width, chooseButton.frame.size.height);
                //  nextButton.enabled = YES;
                [self performSelector:@selector(NextPage:) withObject:nil afterDelay:1.3];
                [UIView commitAnimations];
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (howMany)
        {
            case 1:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling1.frame = CGRectMake(filling1.frame.origin.x,filling1.frame.origin.y + 374*2, filling1.frame.size.width, filling1.frame.size.height);
                
                [UIView commitAnimations];
                break;
                
            case 2:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling2.frame = CGRectMake(filling2.frame.origin.x,filling2.frame.origin.y + 338*2, filling2.frame.size.width, filling2.frame.size.height);
                
                [UIView commitAnimations];
                break;
                
            case 3:
                
                [UIView beginAnimations:@"fall" context:nil];
                [UIView setAnimationDuration:2];
                filling3.frame = CGRectMake(filling3.frame.origin.x,filling3.frame.origin.y + 306*2, filling3.frame.size.width, filling3.frame.size.height);
                label.frame = CGRectMake(label.frame.origin.x, -50, label.frame.size.width, label.frame.size.height);
                chooseButton.frame = CGRectMake(chooseButton.frame.origin.x, -50, chooseButton.frame.size.width, chooseButton.frame.size.height);
              //  nextButton.enabled = YES;
                [self performSelector:@selector(NextPage:) withObject:nil afterDelay:1.3];
                [UIView commitAnimations];
                break;
                
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Back:(id)sender
{
       [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)Reset:(id)sender
{
    howMany = 0;
       [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self viewWillAppear:YES];
}

- (void)LayerChoosed:(NSNotification *)notif
{
    howMany++;
    
    switch (howMany)
    {
        case 1:
            filling1.image = [UIImage imageNamed:notif.object];
            break;
        case 2:
            filling2.image = [UIImage imageNamed:notif.object];
            break;
        case 3:
            filling3.image = [UIImage imageNamed:notif.object];
            break;
            
        default:
            break;
    }
}

- (IBAction)NextPage:(id)sender
{
    howMany = 0;

    ChocolateBarPourChocolateViewController *chocolate = [[ChocolateBarPourChocolateViewController alloc] init];
    chocolate.topFillingImage = filling3.image;
    chocolate.middleFillingImage = filling2.image;
    chocolate.bottomFillingImage = filling1.image;
    
    chocolate.flavourRGb = rgbFlavour;
    [self.navigationController pushViewController:chocolate animated:NO];
}

- (IBAction)ChooseLayers:(id)sender
{
       [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    if (howMany == 3) {
        //rien!!
    }
    else
    {
        ChocolateBarsChooseFillingViewController *choose = [[ChocolateBarsChooseFillingViewController alloc] init];
        
        if([(AppDelegate *)[[UIApplication sharedApplication] delegate] chocolateBarsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
        {
            choose.isLocked = YES;
        }
    
        [UIView
         transitionWithView:self.navigationController.view
         duration:1.0
         options:UIViewAnimationOptionTransitionCurlDown
         animations:^{
             [self.navigationController
              pushViewController:choose
              animated:NO];
         }
         completion:NULL];
        
    }
}
@end
