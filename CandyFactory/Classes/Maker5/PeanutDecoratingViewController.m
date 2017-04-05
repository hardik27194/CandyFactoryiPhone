//
//  PeanutDecoratingViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/17/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "PeanutDecoratingViewController.h"
#import "PeanutFinalViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ExtrasMenuViewController.h"


@implementation PeanutDecoratingViewController
@synthesize treatName;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"PeanutDecoratingViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"PeanutDecoratingViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"PeanutDecoratingViewController" bundle:[NSBundle mainBundle]];
    
    nextPressed = NO;
    [super prepareClassMostenire];
    
    return self;
}

- (void)viewDidLoad
{
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] peanutButterPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
        
    }
    else{
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showPopupAd];
    }
    lastClickedDecoration = 0;
    movingStopped = YES;
    lastTag = 1;
    //    previousX = -100;
    //    previousY = -100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackgroundChaged:) name:@"BackgroundChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DrawOnSelected:) name:@"DrawOnSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtrasSelected:) name:@"ExtrasSelected" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if (nextPressed) {
        if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] peanutButterPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
            
        }
        else{
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] showPopupAd];
        }

        nextPressed = NO;
    }
    stupidCandyCoat.image = coatImage;
    
    self.stick.image = [UIImage imageNamed:self.stickName];
    self.apple.image = [UIImage imageNamed:self.appleName];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.backgroundButton.frame = CGRectMake(self.backgroundButton.frame.origin.x, 0, self.backgroundButton.frame.size.width, self.backgroundButton.frame.size.height);
     } completion:^ (BOOL completed)
     {
         [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
          {
              self.drawOnButton.frame = CGRectMake(self.drawOnButton.frame.origin.x, 0, self.drawOnButton.frame.size.width, self.drawOnButton.frame.size.height);
          } completion:^ (BOOL completed)
          {
              [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
               {
                   self.extrasButton.frame = CGRectMake(self.extrasButton.frame.origin.x, 0, self.extrasButton.frame.size.width, self.extrasButton.frame.size.height);
               } completion:^ (BOOL completed)
               {
                   
                   
               }];
              
          }];
         
     }];

    self.apple.image = [UIImage imageNamed:treatName];
}


- (IBAction)Back:(id)sender
{
   [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)ChangeBackground:(id)sender
{
    lastClickedDecoration = 1;
    movingStopped = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    
    ExtrasMenuViewController * extras;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-iPad" bundle:nil];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-5" bundle:nil];
    else
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    
    extras.choice = 1;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] peanutButterPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        extras._isBought = YES;
    }
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlDown
     animations:^{
         [self.navigationController
          pushViewController:extras
          animated:NO];
     }
     completion:NULL];
}

- (IBAction)DrawOns:(id)sender
{
    lastClickedDecoration = 2;
    movingStopped = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    
    ExtrasMenuViewController * extras;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        extras = [[ExtrasMenuViewController alloc] initWithNibName:@"ExtrasMenuViewController-iPad" bundle:nil];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-5" bundle:nil];
    else
        extras = [[ExtrasMenuViewController alloc] initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    
    extras.choice = 2;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] peanutButterPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        extras._isBought = YES;
    }
    
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlDown
     animations:^{
         [self.navigationController
          pushViewController:extras
          animated:NO];
     }
     completion:NULL];
}

- (IBAction)Extras:(id)sender
{
    lastClickedDecoration = 3;
    movingStopped = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    
    ExtrasMenuViewController *extras;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-iPad" bundle:nil];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-5" bundle:nil];
    else
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    
    extras.choice = 3;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] peanutButterPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        extras._isBought = YES;
    }
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlDown
     animations:^{
         [self.navigationController
          pushViewController:extras
          animated:NO];
     }
     completion:NULL];
}

- (IBAction)Next:(id)sender
{
    nextPressed = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    
    PeanutFinalViewController *eat = [[PeanutFinalViewController alloc] init];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.bigView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.bigView.frame.size);
	[self.bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    eat.backgroundImage1 = viewImage;
    eat.backImage1 = self.background.image;
    
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.bigView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.bigView.frame.size);
    self.background.hidden = YES;
	[self.bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
	UIImage *viewImage3 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    eat.transparetImage = viewImage3;
    self.background.hidden = NO;
    [self.navigationController pushViewController:eat animated:YES];
}

@end
