//
//  CandyApplesStiringViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/10/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CandyApplesStiringViewController.h"
#import "ChooseStickViewController.h"
#import "AppDelegate.h"
#import "CandyAppleFlavourViewController.h"

@implementation CandyApplesStiringViewController
@synthesize spoon;
@synthesize stiredImage;
@synthesize stirring;
@synthesize nextButton;
@synthesize syroup;
@synthesize sugar;
@synthesize water;
@synthesize flavour;
@synthesize chooseStick;
@synthesize rgbForFlavour;
@synthesize bubbleBig1;
@synthesize bubbleBig2;
@synthesize bubbleSmall1;
@synthesize bubbleSmall2;
@synthesize backPressed;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CandyApplesStiringViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CandyApplesStiringViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CandyApplesStiringViewController" bundle:[NSBundle mainBundle]];
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    spoon.alpha = 1.0;
    self.sugar.alpha = 1.0;
    self.stiredImage.alpha = 0.0;
    self.syroup.alpha = 1.0;
    self.water.alpha = 1.0;
    if(backPressed == NO)
    {
        bubbleBig1.alpha = 0;
        timerTest = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
        
        self.flavour.image = [self imageWithImage:self.flavour.image rotatedByHue:rgbForFlavour];
        self.flavour.image = [self imageWithImage:self.flavour.image rotatedByHue:rgbForFlavour];
        self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:rgbForFlavour];
        self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:rgbForFlavour];
    }
    else
    {
        backPressed =  NO;
        [self ResetButtonPreseed:nil];
    }
}

-(void)playBubbles
{
    [UIView beginAnimations:@"sparkle" context:nil];
    [UIView setAnimationDuration:0.3];
    
    if (bubbleBig1.alpha < 1)
    {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 0;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 1;
    }
    else if (bubbleBig2.alpha < 1)
    {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 0;
        bubbleSmall2.alpha = 1;
    }
    else if (bubbleSmall1.alpha < 1)
    {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 0;
    }
    else if (bubbleSmall2.alpha < 1)
    {
        bubbleBig1.alpha = 0;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 1;
    }
    [UIView commitAnimations];
}

- (UIImage*)imageWithImage:(UIImage*)source rotatedByHue:(NSMutableDictionary*)rgb
{
    // Create a Core Image version of the image.
    CIImage *sourceCore = [CIImage imageWithCGImage:[source CGImage]];
    
    // Apply a CIHueAdjust filter
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIColorMonochrome"];
    [hueAdjust setDefaults];
    [hueAdjust setValue:[NSNumber numberWithFloat:0.7] forKey:@"inputIntensity"];
    
    [hueAdjust setValue: sourceCore forKey: @"inputImage"];
    [hueAdjust setValue: [[CIColor alloc]initWithColor:[UIColor colorWithRed:[[rgb objectForKey:@"red"] floatValue]/255.0 green:[[rgb objectForKey:@"green"] floatValue]/255.0 blue:[[rgb objectForKey:@"blue"] floatValue]/255.0 alpha:1.0f]] forKey: @"inputColor"];
    CIImage *resultCore = [hueAdjust valueForKey: @"outputImage"];
    
    // Convert the filter output back into a UIImage.
    // This section from http://stackoverflow.com/a/7797578/1318452
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef resultRef = [context createCGImage:resultCore fromRect:[resultCore extent]];
    UIImage *result = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    
    if(self.spoon.alpha > 0.0)
    {
        stirring.hidden = NO;
    }  
    if(!(stirring.alpha > 0.0))
    {
        stirring.alpha = 1;
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

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
       stirring.hidden = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:7];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    if(isTouchinSpoon)
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
            self.stiredImage.alpha += .01;
            self.sugar.alpha -=.01;
            self.water.alpha -=.01;
            self.syroup.alpha -=.01;
            self.flavour.alpha -= .01;
            self.stirring.alpha -=.009;
        }
        else
        {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.chooseStick.frame = CGRectMake(self.chooseStick.frame.origin.x, 20, self.chooseStick.frame.size.width, self.chooseStick.frame.size.height);
                 stirring.alpha = 0.0;
                 self.spoon.alpha = 0;
                 self.nextButton.enabled = YES;
             } completion:Nil];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)BackButtonPressed:(id)sender
{

    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    NSArray *viewControllers = self.navigationController.viewControllers;
    CandyAppleFlavourViewController *previousView = [viewControllers objectAtIndex:[viewControllers count] - 2];
    previousView.backPressed = YES;
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)Next:(id)sender
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    ChooseStickViewController *chooseStick2 = [[ChooseStickViewController alloc] init];
    chooseStick2.rgbForFlavour = self.rgbForFlavour;
    
    chooseStick2.fromCandyAppleStiring = YES;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        chooseStick2.isLocked = YES;
    }

    
    [self.navigationController pushViewController:chooseStick2 animated:YES];
}

- (IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    if([timerTest isValid])
        [timerTest invalidate];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        spoon.frame = CGRectMake(364, 156, 112, 460);
    else
        spoon.frame = CGRectMake(149, 96, 48, 195);
    spoon.alpha = 1;
    
    nextButton.enabled = NO;
    stirring.alpha = 0;
    self.stiredImage.alpha = 0;
    self.sugar.alpha = 1.0;
    self.flavour.alpha = 1.0;
    self.water.alpha = 1.0;
    self.syroup.alpha = 1.0;
    
    bubbleBig1.alpha = 0;
    bubbleBig2.alpha = 0;
    bubbleSmall1.alpha = 0;
    bubbleSmall2.alpha = 0;
    
    timerTest = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
}

- (IBAction)ChooseStick:(id)sender
{
    
}

@end
