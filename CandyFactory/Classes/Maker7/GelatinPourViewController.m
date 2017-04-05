//
//  GelatinPourViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "GelatinPourViewController.h"
#import "GelatinFrisgeViewController.h"
#import "AppDelegate.h"

@implementation GelatinPourViewController

@synthesize syrupBottle;
@synthesize syrupPouring;
@synthesize timer;
@synthesize timerPour;
@synthesize liquid;
@synthesize bottom;
@synthesize fireOn;
@synthesize bubbleBig1;
@synthesize bubbleBig2;
@synthesize bubbleSmall1;
@synthesize bubbleSmall2;
@synthesize nextButton;
@synthesize potview;
@synthesize potLiqiud;
@synthesize flavourRGB;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"GelatinPourViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"GelatinPourViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"GelatinPourViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    once = NO;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated
{
    if (!once) {
        once = YES;
        self.syrupPouring.image = [self imageWithImage:self.syrupPouring.image rotatedByHue:flavourRGB];
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
        self.potLiqiud.image = [self imageWithImage:self.potLiqiud.image rotatedByHue:flavourRGB];
        self.syrupPouring.image = [self imageWithImage:self.syrupPouring.image rotatedByHue:flavourRGB];
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
        self.potLiqiud.image = [self imageWithImage:self.potLiqiud.image rotatedByHue:flavourRGB];
        point1 = self.syrupPouring.center;
        point2 = self.potview.center;
    }
    else
    {
        [UIView beginAnimations:@"das" context:nil];
        [UIView setAnimationDuration:0.3];
        self.syrupPouring.center= point1;
        self.potview.center= point2;
        [UIView commitAnimations];

    }
 
    self.syrupBottle.alpha = 1.0;
    nextButton.enabled = NO;
    self.syrupBottle.hidden = NO;
    self.fireOn.alpha = 0;
    self.bubbleBig1.alpha = 0;
    self.bubbleBig2.alpha = 0;
    self.bubbleSmall1.alpha = 0;
    self.bubbleSmall2.alpha = 0;
    _isPouring = NO;
    self.syrupPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
     _textureMask.frame = CGRectMake(self.liquid.frame.size.width, 0, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[self.liquid.image CGImage];
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
    [super viewWillAppear:animated];
}


- (IBAction)BackButtonPressed:(id)sender
{
    if([self.timer isValid])
        [self.timer invalidate];
    if([self.timerPour isValid])
        [self.timerPour invalidate];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:NO];
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
        self.syrupPouring.hidden = NO;
        
    } else {
        _isPouring = NO;
         [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:10];
        self.syrupPouring.hidden = YES;
        
    }
    
    self.syrupBottle.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void) pour:(NSTimer *) theTimer {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (_isPouring && ++_sugar < 8) {
             [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:10];
            CABasicAnimation* anim = [[CABasicAnimation alloc] init];
            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
            anim.keyPath = @"position";
            anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
            anim.duration = 0.5;
            _textureMask.position = CGPointMake(_textureMask.position.x- (_textureMask.frame.size.width/7), _textureMask.position.y );
            [_textureMask addAnimation:anim forKey:nil];
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 
                 self.bubbleBig1.alpha = 1;
                 self.bubbleBig2.alpha = 1;
                 self.bubbleSmall1.alpha = 1;
                 self.bubbleSmall2.alpha = 1;
                 self.potview.frame = CGRectMake(self.potview.frame.origin.x - 50, self.potview.frame.origin.y
                                                 , self.potview.frame.size.width, self.potview.frame.size.height);
                 self.syrupPouring.frame = CGRectMake(self.syrupPouring.frame.origin.x - 50, self.syrupPouring.frame.origin.y
                                                      , self.syrupPouring.frame.size.width, self.syrupPouring.frame.size.height);
                 
             } completion:^(BOOL finished) {
                 
             }];
            
        }
        if (_sugar >= 8) {
             [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:10];
            [self.timer invalidate];
            [self.timerPour invalidate];
            _currentRotation = 0;
            _isPouring = NO;
            self.syrupPouring.hidden = YES;

            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.fireOn.alpha = 1;
                 self.bubbleBig1.alpha = 1;
                 self.bubbleBig2.alpha = 1;
                 self.bubbleSmall1.alpha = 1;
                 self.bubbleSmall2.alpha = 1;
                 
             } completion:^(BOOL finished) {
                 
             }];
            
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.syrupBottle.alpha = 0;
                 //nextButton.enabled = YES;
                 
                 
             } completion:^(BOOL finished) {
                 self.syrupBottle.hidden = YES;
                   [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];
                 
             }];
            
        }
        
    }
    else
    {
        if (_isPouring && ++_sugar < 8) {
             [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:10];
            //here make red the fire and then start the bubbles
            
            CABasicAnimation* anim = [[CABasicAnimation alloc] init];
            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
            anim.keyPath = @"position";
            anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
            anim.duration = 0.5;
            _textureMask.position = CGPointMake(_textureMask.position.x- (_textureMask.frame.size.width/7), _textureMask.position.y );
            [_textureMask addAnimation:anim forKey:nil];
           [UIView animateWithDuration:.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                
                self.bubbleBig1.alpha = 1;
                self.bubbleBig2.alpha = 1;
                self.bubbleSmall1.alpha = 1;
                self.bubbleSmall2.alpha = 1;
              
                self.potview.frame = CGRectMake(self.potview.frame.origin.x - 24, self.potview.frame.origin.y
                                                    , self.potview.frame.size.width, self.potview.frame.size.height);
                 self.syrupPouring.frame = CGRectMake(self.syrupPouring.frame.origin.x - 24, self.syrupPouring.frame.origin.y
                                                     , self.syrupPouring.frame.size.width, self.syrupPouring.frame.size.height);
               
             } completion:^(BOOL finished) {
                
            }];
            
        }
        if (_sugar >= 8) {
             [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:10];
            [self.timer invalidate];
            [self.timerPour invalidate];
            _currentRotation = 0;
            _isPouring = NO;
            self.syrupPouring.hidden = YES;

            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.fireOn.alpha = 1;
                 self.bubbleBig1.alpha = 1;
                 self.bubbleBig2.alpha = 1;
                 self.bubbleSmall1.alpha = 1;
                 self.bubbleSmall2.alpha = 1;
                 
             } completion:^(BOOL finished) {
                 
             }];
            
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.syrupBottle.alpha = 0;
                //nextButton.enabled = YES;
                 
                 
             } completion:^(BOOL finished) {
                 self.syrupBottle.hidden = YES;
                 [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];
                 
             }];
            
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

- (IBAction)ResetButtonPreseed:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    _isPouring = NO;
    self.syrupPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(self.liquid.frame.size.width, 0, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[self.liquid.image CGImage];
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
    [UIView beginAnimations:@"das" context:nil];
    [UIView setAnimationDuration:0.3];
     self.syrupPouring.center= point1;
     self.potview.center= point2;
    [UIView commitAnimations];
}

- (IBAction)NextPage:(id)sender
{
    GelatinFrisgeViewController *fridge = [[GelatinFrisgeViewController alloc] init];
    fridge.flavourRGB = flavourRGB;
    [self.navigationController pushViewController:fridge animated:NO];
}

@end
