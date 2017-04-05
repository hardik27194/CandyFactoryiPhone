//
//  CrispyDragViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/21/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CrispyDragViewController.h"
#import "ChooseCrispyFormViewController.h"
#import "AppDelegate.h"

@implementation CrispyDragViewController
@synthesize cup;
@synthesize pan;
@synthesize nextButton;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CrispyDragViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CrispyDragViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CrispyDragViewController" bundle:[NSBundle mainBundle]];
    
    isTouchinCup = NO;
    howMany = 0;
    once = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    initial = self.cup.frame;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isTouchinCup = NO;
    howMany = 0;
    once = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.pan.image = [UIImage imageNamed:@"panEmpty4-iPad.png"];
    else
        self.pan.image = [UIImage imageNamed:@"panEmpty.png"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.cup.image = [UIImage imageNamed:@"scooperEmpty-iPad.png"];
    else
        self.cup.image = [UIImage imageNamed:@"scooperEmpty.png"];
    nextButton.enabled = NO;
}

- (void)touchesBegan:(NSSet*) touches withEvent:(UIEvent*)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == self.cup)
    {
       
        isTouchinCup = YES;
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        _touchOffset = CGPointMake(touchPoint.x - self.cup.center.x, touchPoint.y-self.cup.center.y);
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    if(isTouchinCup)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        self.cup.center = touchPoint;

        if(!once)
            
        {
             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             {
                 if (self.cup.center.x > 130 &&self.cup.center.x <540) {
                     if (self.cup.center.y > 30 &&self.cup.center.y <340) {
                         
                         //in bowl
                          if (howMany < 3) {
                              if (self.cup.image != [UIImage imageNamed:@"scooperFilled-iPad.png"]) {
                                   [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:23];
                              }
                         
                         self.cup.image = [UIImage imageNamed:@"scooperFilled-iPad.png"];
                          }
                         
                     }
                 }
                 if(self.cup.image == [UIImage imageNamed:@"scooperFilled-iPad.png"]) if (self.cup.center.x > 40 &&self.cup.center.x <700)
                 {
                     if (self.cup.center.y > 450 &&self.cup.center.y <890)
                     {
                         once = YES;
                         
                          if (howMany < 3) {
                          [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:11];
                         self.cup.image = [UIImage imageNamed:@"scooperEmpty-iPad.png"];
                          }
                        if(howMany == 0)
                         {
                             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                 self.pan.image = [UIImage imageNamed:@"panPartiallyEmpty4-iPad.png"];
                             else
                                 self.pan.image = [UIImage imageNamed:@"panPartiallyEmpty.png"];
                             once = NO;
                         }
                         else if(howMany == 1)
                         {
                             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                 self.pan.image = [UIImage imageNamed:@"panPartiallyFilled4-iPad.png"];
                             else
                                 self.pan.image = [UIImage imageNamed:@"panPartiallyFilled2.png"];
                             once = NO;
                         }
                         else if(howMany == 2)
                         {
                             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                 self.pan.image = [UIImage imageNamed:@"panFilled4-iPad.png"];
                             else
                                 self.pan.image = [UIImage imageNamed:@"panFilled.png"];
                             once = NO;
                             nextButton.enabled = YES;
                         }
                         
                         howMany += 1;
                     }
                 }


             }
            
            else
            {
                if (self.cup.center.x > 60 &&self.cup.center.x <230) {
                    if (self.cup.center.y > 30 &&self.cup.center.y <200) {
                        
                        //in bowl
                        
                         if (howMany < 3) {
                              if (self.cup.image != [UIImage imageNamed:@"scooperFilled.png"]) {
                                   [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:23];
                              }
                        
                        self.cup.image = [UIImage imageNamed:@"scooperFilled.png"];
                         }
                        
                    }
                }
                if(self.cup.image == [UIImage imageNamed:@"scooperFilled.png"]) if (self.cup.center.x > 37 &&self.cup.center.x <300)
                {
                    if (self.cup.center.y > 300 &&self.cup.center.y <427)
                    {
                        once = YES;
                         if (howMany < 3) {
                         [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:11];
                        self.cup.image = [UIImage imageNamed:@"scooperEmpty.png"];
                         }
                        
                                              
                        if(howMany == 0)
                        {
                            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                self.pan.image = [UIImage imageNamed:@"panPartiallyEmpty4-iPad.png"];
                            else
                                self.pan.image = [UIImage imageNamed:@"panPartiallyEmpty.png"];
                            once = NO;
                        }
                        else if(howMany == 1)
                        {
                            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                self.pan.image = [UIImage imageNamed:@"panPartiallyFilled4-iPad.png"];
                            else
                                self.pan.image = [UIImage imageNamed:@"panPartiallyFilled2.png"];
                            once = NO;
                        }
                        else if(howMany == 2)
                        {
                            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                                self.pan.image = [UIImage imageNamed:@"panFilled4-iPad.png"];
                            else
                                self.pan.image = [UIImage imageNamed:@"panFilled.png"];
                            once = NO;
                            
                          
                            nextButton.enabled = YES;
                        }
                        
                        howMany += 1;
                    }
                }


            }
            
            
            
            
                 
        }
    }
}

- (void)goBackCup
{
    [UIView beginAnimations:@"upCup" context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.cup.frame = initial;

    [UIView commitAnimations];
    once = NO;
}

- (IBAction)Reset:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    isTouchinCup = NO;
    howMany = 0;
    once = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
         self.pan.image = [UIImage imageNamed:@"panEmpty4-iPad.png"];
    else
        self.pan.image = [UIImage imageNamed:@"panEmpty.png"];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.cup.image = [UIImage imageNamed:@"scooperEmpty-iPad.png"];
    else
        self.cup.image = [UIImage imageNamed:@"scooperEmpty.png"];
       nextButton.enabled = NO;
}

- (IBAction)NextButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    ChooseCrispyFormViewController *form = [[ChooseCrispyFormViewController alloc] init];
    
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] crispiesRicePurchased] ||[(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
    {
        form.isLocked = YES;
    }
    [self.navigationController pushViewController:form animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return(interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Back:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
