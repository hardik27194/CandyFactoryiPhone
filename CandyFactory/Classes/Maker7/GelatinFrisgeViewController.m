//
//  GelatinFrisgeViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "GelatinFrisgeViewController.h"
#include <math.h>
#import "PSAnalogClockView.h"
#import "GelatinChooseCutterViewController.h"
#import "AppDelegate.h"
#define DEGREES_TO_RADIANS(angle) (angle/180.0*M_PI)

@interface GelatinFrisgeViewController ()
{
    BOOL first;
    BOOL once ;
    int minute, hour, second;
    int minAngle, hourAngle;
    NSDate *currentTime;
    NSDateComponents *dateComponents;
    
    NSCalendar *calendar;
    NSCalendarUnit unitFlags;
    PSAnalogClockView *analogClock2 ;
    NSTimer * clockTimer;
}

@end

@implementation GelatinFrisgeViewController
@synthesize fridgeDoor;
@synthesize potView;
@synthesize nextButton;
@synthesize clockView;
@synthesize hourHand;
@synthesize minuteHand;
@synthesize updateTimer;
@synthesize flavourRGB;
@synthesize liquid;
@synthesize labelDown;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"GelatinFrisgeViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"GelatinFrisgeViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"GelatinFrisgeViewController" bundle:[NSBundle mainBundle]];
    
    first = NO;
    hour = 0;
    minute = 60;
    once = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    initial = self.potView.center;
    clockView.hidden = YES;
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    //here make animation
    self.potView.userInteractionEnabled = YES;
    self.potView.center = initial;
    first = NO;
      nextButton.enabled = NO;
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:18];
    [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
        
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
              self.fridgeDoor.frame = CGRectMake(768, self.fridgeDoor.frame.origin.y, self.fridgeDoor.frame.size.width, self.fridgeDoor.frame.size.height);
         }
         else
         {
              self.fridgeDoor.frame = CGRectMake(320, self.fridgeDoor.frame.origin.y, self.fridgeDoor.frame.size.width, self.fridgeDoor.frame.size.height);
         }
         
     } completion:^(BOOL finished) {
         
     }];
    if (!once) {
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
        once = YES;
        
    }
    
    if ([clockTimer isValid]) {
        [clockTimer invalidate];
    }
     

}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.potView)
    {
        lastThing = self.potView.center;
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.potView.center = lastThing;
}
- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.potView)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        self.potView.center = touchPoint;
        if ([self checkIfIsInPot:self.potView.center] && !first) {
            first = YES;
            self.potView.userInteractionEnabled = NO;
            lastThing = self.potView.center;
            nextButton.enabled = YES;
            [self performSelector:@selector(closeFridge) withObject:nil afterDelay:0.5];
           //376 746
        }
        else
        {
            nextButton.enabled = NO;
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

-(void)closeFridge
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:19];
    [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.fridgeDoor.frame = CGRectMake(10, self.fridgeDoor.frame.origin.y, self.fridgeDoor.frame.size.width, self.fridgeDoor.frame.size.height);
         
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             self.labelDown.image = [UIImage imageNamed:@"waitForCooling-iPad.png"];
         }
         else
         {
             self.labelDown.image = [UIImage imageNamed:@"waitForCooling.png"];
         }
         
     } completion:^(BOOL finished) {
    
         
      
         [self updateTime];
     }];
}
- (void)updateTime {
    analogClock2 = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
         analogClock2 = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(120, 138, 121, 121)];
         analogClock2.center = CGPointMake(162, 372);
    }
    else
    {
         analogClock2 = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(120, 138, 141, 149)];
         analogClock2.center = CGPointMake(384, 769);
    }
   
   
    analogClock2.clockFaceImage  = [UIImage imageNamed:@"clock"];
    analogClock2.hourHandImage = [UIImage imageNamed:@"sageataSus"];
    analogClock2.secondHandImage = [UIImage imageNamed:@"sageataDreapta"];
    analogClock2.centerCapImage  = [UIImage imageNamed:@"bulina"];
    
    [self.view addSubview:analogClock2];
    [analogClock2 start];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:20];
    clockTimer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(NextPage:) userInfo:nil repeats:YES];
 

  
}
- (void)rotateView:(UIView *)view
       aroundPoint:(CGPoint)rotationPoint
          duration:(NSTimeInterval)duration
           degrees:(CGFloat)degrees {
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [rotationAnimation setDuration:duration];
    // Additional animation configurations here...
    
    // The anchor point is expressed in the unit coordinate
    // system ((0,0) to (1,1)) of the label. Therefore the
    // x and y difference must be divided by the width and
    // height of the view (divide x difference by width and
    // y difference by height).
    CGPoint anchorPoint = CGPointMake((rotationPoint.x - CGRectGetMinX(view.frame))/CGRectGetWidth(view.bounds),
                                      (rotationPoint.y - CGRectGetMinY(view.frame))/CGRectGetHeight(view.bounds));
    
    [[view layer] setAnchorPoint:anchorPoint];
    [[view layer] setPosition:rotationPoint]; // change the position here to keep the frame
    CATransform3D rotationTransform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(degrees), 0, 0, 1);
    [rotationAnimation setToValue:[NSValue valueWithCATransform3D:rotationTransform]];
    
    // Add the animation to the views layer
    [[view layer] addAnimation:rotationAnimation
                        forKey:@"rotateAroundAnchorPoint"];
}

-(BOOL)checkIfIsInPot:(CGPoint)point
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (point.x > 146 && point.x <176)
        {
            if (point.y >150 && point.y <185) {
                return YES;
            }
            return NO;
        }
    }
    else
    {
        if (point.x > 320 && point.x <420)
        {
            if (point.y >320 && point.y <405) {
                return YES;
            }
            return NO;
        }
    }
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
-(IBAction)BackButtonPressed:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:20];
    [self.navigationController popViewControllerAnimated:NO];
//    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [self.navigationController popToViewController:delegate.carouselController animated:YES];
}
-(IBAction)ResetButtonPreseed:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:20];
    self.potView.userInteractionEnabled = YES;
    [analogClock2 stop];
    if ([clockTimer isValid]) {
        [clockTimer invalidate];
    }

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [UIView beginAnimations:@"fgd" context:nil];
        [UIView setAnimationDuration:0.3];
        [analogClock2 removeFromSuperview];
        self.fridgeDoor.frame = CGRectMake(768, self.fridgeDoor.frame.origin.y, self.fridgeDoor.frame.size.width, self.fridgeDoor.frame.size.height);
        self.potView.center = CGPointMake(376, 746);
        
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:@"fgd" context:nil];
        [UIView setAnimationDuration:0.3];
        [analogClock2 removeFromSuperview];
        self.fridgeDoor.frame = CGRectMake(320, self.fridgeDoor.frame.origin.y, self.fridgeDoor.frame.size.width, self.fridgeDoor.frame.size.height);
        self.potView.center = CGPointMake(162, 330);
        [UIView commitAnimations];
    }
 
}

- (IBAction)NextPage:(id)sender
{
    if([clockTimer isValid])
    {
        [clockTimer invalidate];
    }
    
    [analogClock2 stop];
    [analogClock2 removeFromSuperview];
   
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:20];
    GelatinChooseCutterViewController *cutter = [[GelatinChooseCutterViewController alloc] init];
    cutter.flavourRGB = flavourRGB;
    
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] gelatinPurchased] ||[(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
    {
        cutter.isLocked = YES;
    }
    [self.navigationController pushViewController:cutter animated:YES];
}

@end
