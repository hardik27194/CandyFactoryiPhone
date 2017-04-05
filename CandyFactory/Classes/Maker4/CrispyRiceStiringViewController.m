//
//  CrispyRiceStiringViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CrispyRiceStiringViewController.h"
#import "CrispyDragViewController.h"
#import "CrispyRiceCrispysViewController.h"
#import "AppDelegate.h"

@interface CrispyRiceStiringViewController ()
{
    CGPoint _touchOffset;
    BOOL isTouchinSpoon;
}

@end

@implementation CrispyRiceStiringViewController

@synthesize spoon;
@synthesize stiredImage;
@synthesize nextButton;
@synthesize murshmallow;
@synthesize crispy;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CrispyRiceStiringViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CrispyRiceStiringViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CrispyRiceStiringViewController" bundle:[NSBundle mainBundle]];
    
    isTouchinSpoon = NO;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    isTouchinSpoon = NO;
    self.spoon.alpha = 1.0;
    nextButton.enabled = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.spoon.frame = CGRectMake(385, 114, 112, 460);
    else
        self.spoon.frame = CGRectMake(164, 79, 48, 195);
    
    murshmallow.alpha = 1.0;
    crispy.alpha = 1.0;
    stiredImage.alpha = 0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    NSArray *viewControllers = self.navigationController.viewControllers;
    CrispyRiceCrispysViewController *previousView = [viewControllers objectAtIndex:[viewControllers count] - 2];
    previousView.backPressed = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    nextButton.enabled = NO;
    isTouchinSpoon = NO;
    self.spoon.alpha = 1.0;

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.spoon.frame = CGRectMake(385, 114, 112, 460);
    else
        self.spoon.frame = CGRectMake(164, 79, 48, 195);
    
    murshmallow.alpha = 1.0;
    crispy.alpha = 1.0;
    stiredImage.alpha = 0.0;
}

- (IBAction)NextPage:(id)sender
{
    CrispyDragViewController *crispyT = [[CrispyDragViewController alloc] init];
    [self.navigationController pushViewController:crispyT animated:YES];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:7];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if (self.spoon.alpha > 0.0)
    {

    }
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.spoon)
    {
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:7];
        isTouchinSpoon = YES;
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        _touchOffset = CGPointMake(touchPoint.x - self.spoon.center.x, touchPoint.y-self.spoon.center.y);
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    if(self.spoon.alpha > 0)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
            
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 454) self.spoon.center = CGPointMake(454, self.spoon.center.y);
            if (self.spoon.center.x < 221) self.spoon.center = CGPointMake(221, self.spoon.center.y);
            if (self.spoon.center.y > 540) self.spoon.center = CGPointMake(self.spoon.center.x, 540);
            if (self.spoon.center.y < 314) self.spoon.center = CGPointMake(self.spoon.center.x, 314);
        }
        else if([UIScreen mainScreen].bounds.size.height == 568)
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 190) self.spoon.center = CGPointMake(190, self.spoon.center.y);
            if (self.spoon.center.x < 105) self.spoon.center = CGPointMake(105, self.spoon.center.y);
            if (self.spoon.center.y > 234 + 72) self.spoon.center = CGPointMake(self.spoon.center.x, 234 + 72);
            if (self.spoon.center.y < 156 + 72) self.spoon.center = CGPointMake(self.spoon.center.x, 156 + 72);
        }
        else
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 190) self.spoon.center = CGPointMake(190, self.spoon.center.y);
            if (self.spoon.center.x < 105) self.spoon.center = CGPointMake(105, self.spoon.center.y);
            if (self.spoon.center.y > 234) self.spoon.center = CGPointMake(self.spoon.center.x, 234);
            if (self.spoon.center.y < 156) self.spoon.center = CGPointMake(self.spoon.center.x, 156);
        }
        
        if(self.stiredImage.alpha < 1)
        {
            self.stiredImage.alpha += .005;
            self.crispy.alpha -=.005;
            self.murshmallow.alpha -=.005;
        }
        else
        {
          
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.spoon.alpha = 0;
                 self.nextButton.enabled = YES;
             } completion:Nil];
        }
    }
}
 



@end
