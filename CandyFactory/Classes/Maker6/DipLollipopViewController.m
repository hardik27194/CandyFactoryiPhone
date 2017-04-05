//
//  DipLollipopViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/29/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "DipLollipopViewController.h"
#import "LollipopDecoratingViewController.h"
#import "AppDelegate.h"

@implementation DipLollipopViewController

@synthesize stickDigging;
@synthesize stick;
@synthesize flavour1;
@synthesize flavour2;
@synthesize coat;
@synthesize core;
@synthesize stickImage;
@synthesize coreImage;
@synthesize coatingImage;
@synthesize flavourRGB;
@synthesize timerApple;
@synthesize timerOut;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"DipLollipopViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"DipLollipopViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"DipLollipopViewController" bundle:[NSBundle mainBundle]];
    
    isTouchingStick = NO;
    first = NO;
    firstAppear = NO;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    firstTimeInPot = YES;
    initialCenter = stickDigging.center;
    initial = self.stickDigging.center;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated

{
  
    self.coat.alpha = 0.0;
    self.stickDigging.center = initial;
    initialTransform = stickDigging.transform;

    if ([timerApple isValid]) {
        [timerApple invalidate];
    }
    
    timerApple = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkIfIsInPot) userInfo:nil repeats:YES];
    if (!firstAppear) {
        firstAppear = YES;
         first =NO;
        self.coat.image = [UIImage imageNamed:coatingImage];
        self.core.image = [UIImage imageNamed:coreImage];
        self.stick.image = [UIImage imageNamed:stickImage];
        self.coat.image = [self imageWithImage:self.coat.image rotatedByHue:flavourRGB];
        self.coat.image = [self imageWithImage:self.coat.image rotatedByHue:flavourRGB];
        
        self.flavour1.image = [self imageWithImage:self.flavour1.image rotatedByHue:flavourRGB];
        self.flavour1.image = [self imageWithImage:self.flavour1.image rotatedByHue:flavourRGB];
        self.flavour2.image = [self imageWithImage:self.flavour2.image rotatedByHue:flavourRGB];
        self.flavour2.image = [self imageWithImage:self.flavour2.image rotatedByHue:flavourRGB];
    }
    
    
   
}
-(void)checkIfIsInPot
{
    CGPoint center = self.stickDigging.center;
    CGRect rect;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        rect = CGRectMake(140, 565, 486, 236);
    }
    else
    {
        rect = CGRectMake(50, 268, 213, 100);
    }
    
    
    if (CGRectContainsPoint(rect, center)) {
        if (firstTimeInPot) {
           
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:8];
            firstTimeInPot = NO;
            
        }
        
        coat.alpha += 0.02;
        if (coat.alpha >= 1) {
          
            
            if ([timerOut isValid]) {
                
            }
            else
            {
                [timerApple invalidate];
                timerOut = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(rotateApple) userInfo:nil repeats:YES];
            }
            
            
        }
        
        //is in Pot
    }
    else
    {
        firstTimeInPot = YES;
        //out of the pot!!
    }
}



- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{

    
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == self.stickDigging)
    {
       
        isTouchingStick = YES;
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        _touchOffset = CGPointMake(touchPoint.x - self.stickDigging.center.x, touchPoint.y - self.stickDigging.center.y);
    }
}
-(void)rotateApple
{
    
    [UIView beginAnimations:@"spin1" context:nil];
    [UIView setAnimationDuration:0.2];
    
    if (!left) {
        left = YES;
        stickDigging.transform =  CGAffineTransformRotate(initialTransform,-M_PI/20);
        stickDigging.transform =  CGAffineTransformRotate(initialTransform,M_PI/20);
    }
    else
    {
        left = NO;
        stickDigging.transform =  CGAffineTransformRotate(initialTransform,M_PI/20);
        
        stickDigging.transform =  CGAffineTransformRotate(initialTransform,-M_PI/20);
    }
    stickDigging.transform = initialTransform;
    [UIView commitAnimations];
    
 //   [self performSelector:@selector(goBack) withObject:nil afterDelay:0.3];
    
}
-(void)goBack
{
    
    [UIView beginAnimations:@"dfsadfs" context:nil];
    [UIView setAnimationDuration:0.3];
    stickDigging.center = initialCenter;
    stickDigging.userInteractionEnabled = NO;
    
    [UIView commitAnimations];
}


- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:8];
}

- (void)touchesMoved:(NSSet*) touches withEvent:(UIEvent*) event
{
    if(isTouchingStick)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.stickDigging.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.stickDigging.center.x > 454) self.stickDigging.center = CGPointMake(454, self.stickDigging.center.y);
            if (self.stickDigging.center.x < 284) self.stickDigging.center = CGPointMake(284, self.stickDigging.center.y);
            if (self.stickDigging.center.y > 600) self.stickDigging.center = CGPointMake(self.stickDigging.center.x, 600);
            if (self.stickDigging.center.y < 300) self.stickDigging.center = CGPointMake(self.stickDigging.center.x, 300);
        }
        else if([UIScreen mainScreen].bounds.size.height == 568)
        {
            self.stickDigging.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.stickDigging.center.x > 190) self.stickDigging.center = CGPointMake(190, self.stickDigging.center.y);
            if (self.stickDigging.center.x < 105) self.stickDigging.center = CGPointMake(105, self.stickDigging.center.y);
            if (self.stickDigging.center.y > 284 + 72) self.stickDigging.center = CGPointMake(self.stickDigging.center.x, 284 + 72);
            if (self.stickDigging.center.y < 150 + 72) self.stickDigging.center = CGPointMake(self.stickDigging.center.x, 150 + 72);
        }
        else
        {
            self.stickDigging.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.stickDigging.center.x > 190) self.stickDigging.center = CGPointMake(190, self.stickDigging.center.y);
            if (self.stickDigging.center.x < 105) self.stickDigging.center = CGPointMake(105, self.stickDigging.center.y);
            if (self.stickDigging.center.y > 284) self.stickDigging.center = CGPointMake(self.stickDigging.center.x, 284);
            if (self.stickDigging.center.y < 150) self.stickDigging.center = CGPointMake(self.stickDigging.center.x, 150);
        }
        
        CGRect testRect = CGRectMake(20, 53, 275, 158);
        if([UIScreen mainScreen].bounds.size.height == 568)
             testRect = CGRectMake(20, 53 + 72, 275, 158);
        
        if (CGRectContainsPoint(testRect, self.stickDigging.center)) {
            if (coat.alpha >= 1.0 ) {
                self.nextButton.enabled = YES;
                if ([timerOut isValid]) {
                    [timerOut invalidate];
                }
                
            }
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

- (IBAction)Next:(id)sender
{
    //do something here
    firstTimeInPot = YES;
    stickDigging.userInteractionEnabled = YES;
    
    LollipopDecoratingViewController *lollipop = [[LollipopDecoratingViewController alloc] init];
    lollipop.appleName = self.coatingImage;
    lollipop.flavourRGB = flavourRGB;
    lollipop.stickName = self.stickImage;
    [self.navigationController pushViewController:lollipop animated:YES];
}


- (IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    self.stickDigging.center = initial;
    self.coat.alpha = 0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
