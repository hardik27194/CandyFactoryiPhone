//
//  PeanutStirViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "PeanutStirViewController.h"
#import "PutInPotViewController.h"
#import "AppDelegate.h"
#import "PeanutButterChooseMoldViewController.h"

@implementation PeanutStirViewController
@synthesize spoon;
@synthesize sugar;
@synthesize nextButton;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"PeanutStirViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"PeanutStirViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"PeanutStirViewController" bundle:[NSBundle mainBundle]];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.spoon.alpha = 1.0;
    sugar.alpha = 1.0;
}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.spoon) {
        isTouchinSpoon = YES;
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:14];
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        _touchOffset = CGPointMake(touchPoint.x - self.spoon.center.x, touchPoint.y-self.spoon.center.y);
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:14];
}

- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    if (isTouchinSpoon) {
        
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 454) self.spoon.center = CGPointMake(454, self.spoon.center.y);
            if (self.spoon.center.x < 200) self.spoon.center = CGPointMake(200, self.spoon.center.y);
            if (self.spoon.center.y > 562) self.spoon.center = CGPointMake(self.spoon.center.x, 562);
            if (self.spoon.center.y < 314) self.spoon.center = CGPointMake(self.spoon.center.x, 314);
        }
        else if([UIScreen mainScreen].bounds.size.height == 568)
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 190 - 3) self.spoon.center = CGPointMake(190 - 3, self.spoon.center.y);
            if (self.spoon.center.x < 105 - 3) self.spoon.center = CGPointMake(105 - 3, self.spoon.center.y);
            if (self.spoon.center.y > 290 + 72) self.spoon.center = CGPointMake(self.spoon.center.x, 290 + 72);
            if (self.spoon.center.y < 156 + 72) self.spoon.center = CGPointMake(self.spoon.center.x, 156 + 72);
        }
        else
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 190) self.spoon.center = CGPointMake(190, self.spoon.center.y);
            if (self.spoon.center.x < 105) self.spoon.center = CGPointMake(105, self.spoon.center.y);
            if (self.spoon.center.y > 290) self.spoon.center = CGPointMake(self.spoon.center.x, 290);
            if (self.spoon.center.y < 156) self.spoon.center = CGPointMake(self.spoon.center.x, 156);
        }
        

        
       
        
        if (self.sugar.alpha > 0.0) {
            
            self.sugar.alpha -=.01;
            
        } else {
       
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
              
                 self.spoon.alpha = 0;
                 self.nextButton.enabled = YES;
             } completion:Nil];
          
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BackButtonPressed:(id)sender
{
   
  [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)Next:(id)sender
{
//    //do something
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    PeanutButterChooseMoldViewController *choose = [[PeanutButterChooseMoldViewController alloc] init];

    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] peanutButterPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        choose.isLocked = YES;
    }

   [self.navigationController pushViewController:choose animated:YES];
 }

-(IBAction)ResetButtonPreseed:(id)sender
{[(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    self.spoon.alpha = 1.0;
    sugar.alpha = 1.0;

}



@end
