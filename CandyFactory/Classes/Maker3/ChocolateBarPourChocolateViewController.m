//
//  ChocolateBarPourChocolateViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/17/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "ChocolateBarPourChocolateViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChocolateBarsEatingViewController.h"
#import "AppDelegate.h"
#import "DecorateChocolateBarViewController.h"


@implementation ChocolateBarPourChocolateViewController

@synthesize topFilling;
@synthesize middleFilling;
@synthesize bottomFilling;
@synthesize topFillingImage;
@synthesize sugarPack;
@synthesize sugarPouring;
@synthesize nextButton;
@synthesize liquid;
@synthesize timer;
@synthesize timerPour;
@synthesize potLiquid;
@synthesize flavourRGb;
@synthesize middleFillingImage;
@synthesize bottomFillingImage;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChocolateBarPourChocolateViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChocolateBarPourChocolateViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChocolateBarPourChocolateViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    firstAppear = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval  = 1.0/10.0; // Update at 10Hz
    if(motionManager.accelerometerAvailable)
    {
        NSLog(@"Accelerometer avaliable");
        queue = [NSOperationQueue currentQueue];
        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             CMAcceleration acceleration = accelerometerData.acceleration;
             _currentX = acceleration.x;
         }];
    }
    else
    {
        NSLog(@"Accelerometer not avaliable");
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!firstAppear) {
        firstAppear = YES;
        potLiquid.image = [self imageWithImage:self.potLiquid.image rotatedByHue:flavourRGb];
        potLiquid.image = [self imageWithImage:self.potLiquid.image rotatedByHue:flavourRGb];
        sugarPouring.image = [self imageWithImage:self.sugarPouring.image rotatedByHue:flavourRGb];
        sugarPouring.image = [self imageWithImage:self.sugarPouring.image rotatedByHue:flavourRGb];
        liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGb];
        liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGb];

    }
        
    topFilling.image = topFillingImage;
    middleFilling.image = middleFillingImage;
    bottomFilling.image = bottomFillingImage;
    self.sugarPack.alpha = 1.0;
    nextButton.enabled = NO;
    self.sugarPack.hidden = NO;
    _isPouring = NO;
    self.sugarPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0,  0, self.liquid.frame.size.width, 0);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"chocolateMold22.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    _sugar = 0;
    _currentRotation = _currentX;
    if ([timer isValid]) {
        [timer invalidate];
    }
    if ([timerPour isValid]) {
        [timerPour invalidate];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
    self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
}
- (void) rotate:(NSTimer *) theTimer {
    double rotation = _currentX*2.2;
    if (rotation > 0) rotation = 0;
    
    rotation -= .15;
    
    double difference = rotation - _currentRotation;
    _currentRotation += difference *.05;
    
    if (_currentRotation <= -1.3) {
        _currentRotation = -1.3;
        
        _isPouring = YES;
        self.sugarPouring.hidden = NO;
        
    } else {
         [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:10];
        _isPouring = NO;
        self.sugarPouring.hidden = YES;
        
    }
    
    self.sugarPack.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void) pour:(NSTimer *) theTimer {
    
    if(_isPouring && ++_sugar < 8)
    {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:10];
        CABasicAnimation* anim = [[CABasicAnimation alloc] init];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
        anim.keyPath = @"position";
        anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        anim.duration = 0.5;
        
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
       _textureMask.frame = CGRectMake(_textureMask.frame.origin.x, _textureMask.frame.origin.y,_textureMask.frame.size.width , _textureMask.frame.size.height+254/7);
        else  _textureMask.frame = CGRectMake(_textureMask.frame.origin.x, _textureMask.frame.origin.y,_textureMask.frame.size.width , _textureMask.frame.size.height+143/7);
        [_textureMask addAnimation:anim forKey:nil];
    }
    if (_sugar >= 8)
    {
         [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:10];
        [self.timer invalidate];
        [self.timerPour invalidate];
        _currentRotation = 0;
        _isPouring = NO;
        self.sugarPouring.hidden = YES;
        
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             self.sugarPack.alpha = 0;
             [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];
             nextButton.enabled = NO;
           
             
             
         } completion:^(BOOL finished) {
             self.sugarPack.hidden = YES;
             
         }];
        
    }
}


- (UIImage*) imageWithImage:(UIImage*) source rotatedByHue:(NSMutableDictionary *)rgb
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
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef resultRef = [context createCGImage:resultCore fromRect:[resultCore extent]];
    UIImage *result = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)BackButtonPressed:(id)sender
{
    if([self.timer isValid])
        [self.timer invalidate];
    if([self.timerPour isValid])
        [self.timerPour invalidate];

    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)NextPage:(id)sender
{
    DecorateChocolateBarViewController *eating = [[DecorateChocolateBarViewController alloc] init];
    eating.flavourRGB = flavourRGb;
    [self.navigationController pushViewController:eating animated:YES];
}

- (IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self viewWillAppear:YES];
}

@end
