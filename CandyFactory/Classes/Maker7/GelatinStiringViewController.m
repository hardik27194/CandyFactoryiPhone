//
//  GelatinStiringViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "GelatinStiringViewController.h"
#import "GelatinPourViewController.h"
#import "AppDelegate.h"


@implementation GelatinStiringViewController
@synthesize spoon;
@synthesize stiredImage;
@synthesize stirring;
@synthesize nextButton;
@synthesize sugar;
@synthesize water;
@synthesize chooseStick;
@synthesize flavourRGB;
@synthesize bubbleBig1;
@synthesize bubbleBig2;
@synthesize bubbleSmall1;
@synthesize bubbleSmall2;
@synthesize timerT;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"GelatinStiringViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"GelatinStiringViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"GelatinStiringViewController" bundle:[NSBundle mainBundle]];
    
    once = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.sugar.image = [self imageWithImage:self.sugar.image rotatedByHue:flavourRGB];
    self.sugar.image = [self imageWithImage:self.sugar.image rotatedByHue:flavourRGB];
    
    self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:flavourRGB];
    self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:flavourRGB];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    self.bubbleBig1.alpha = 0;
    self.bubbleBig2.alpha = 1;
    self.bubbleSmall1.alpha = 1;
    self.bubbleSmall2.alpha = 1;
    if ([timerT isValid]) {
        [timerT invalidate];
    }
     timerT = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
    intialCenterSpoon = self.spoon.center;
    if (once) {
        stiredImage.alpha = 0.0;
        self.sugar.alpha =1.0;
        self.water.alpha =1.0;
        self.stirring.alpha =0.0;
        self.stirring.hidden = YES;
        self.spoon.center = intialCenterSpoon;
        self.spoon.alpha = 1.0;
        once = NO;
    }
}
- (void)playBubbles
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
    else if(bubbleSmall1.alpha < 1)
    {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 0;
    }
    else if(bubbleSmall2.alpha < 1)
    {
        bubbleBig1.alpha = 0;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 1;
    }
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    if (self.spoon.alpha > 0.0) {
        stirring.hidden = NO;
    }
    if ( ! (stirring.alpha > 0.0) ) {
        stirring.alpha = 1;
    }
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.spoon) {
        isTouchinSpoon = YES;
         [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:7];
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        _touchOffset = CGPointMake(touchPoint.x - self.spoon.center.x, touchPoint.y-self.spoon.center.y);
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate]stopSoundEffect:7];

    stirring.hidden = YES;
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
        

        
        if (self.stiredImage.alpha < 1) {
            self.stiredImage.alpha += .005;
            self.sugar.alpha -=.005;
            self.water.alpha -=.005;
            self.stirring.alpha -=.009;
        } else if(!once) {
            once = YES;
        
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.chooseStick.frame = CGRectMake(self.chooseStick.frame.origin.x, 20, self.chooseStick.frame.size.width, self.chooseStick.frame.size.height);
                 stirring.alpha = 0.0;
                 self.spoon.alpha = 0;
                [self performSelector:@selector(Next:) withObject:nil afterDelay:0.3];
             } completion:Nil];
           
        }
    }
}

- (UIImage*) imageWithImage:(UIImage*) source rotatedByHue:(NSMutableDictionary *) rgb;
{
    
    CIImage *sourceCore = [CIImage imageWithCGImage:[source CGImage]];
    
    
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIColorMonochrome"];
    [hueAdjust setDefaults];
    [hueAdjust setValue:[NSNumber numberWithFloat:0.7] forKey:@"inputIntensity"];
    
    [hueAdjust setValue: sourceCore forKey: @"inputImage"];
    [hueAdjust setValue: [[CIColor alloc]initWithColor:[UIColor colorWithRed:[[rgb objectForKey:@"red"] floatValue]/255.0 green:[[rgb objectForKey:@"green"] floatValue]/255.0 blue:[[rgb objectForKey:@"blue"] floatValue]/255.0 alpha:1.0f]] forKey: @"inputColor"];
    CIImage *resultCore = [hueAdjust valueForKey: @"outputImage"];
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef resultRef = [context createCGImage:resultCore fromRect:[resultCore extent]];
    UIImage *result = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    
    return result;
}


-(IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    UINavigationController * navcontroller = self.navigationController;
    [navcontroller popViewControllerAnimated:NO];

}

- (IBAction)Next:(id)sender
{
    GelatinPourViewController *gelatin = [[GelatinPourViewController alloc] init];
    gelatin.flavourRGB = flavourRGB;
    [self.navigationController pushViewController:gelatin animated:NO];
}

-(IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    stiredImage.alpha = 0.0;
    self.sugar.alpha =1.0;
    self.water.alpha =1.0;
    self.stirring.alpha =0.0;
    self.stirring.hidden = YES;
    self.spoon.center = intialCenterSpoon;
    self.spoon.alpha = 1.0;
}
-(IBAction)ChooseStick:(id)sender
{
    
}


@end
