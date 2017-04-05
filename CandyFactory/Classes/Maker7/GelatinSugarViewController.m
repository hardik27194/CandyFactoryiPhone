//
//  GelatinSugarViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "GelatinSugarViewController.h"
#import "GelatinStiringViewController.h"
#import "ChooseFlavourLollipopViewController.h"
#import "AppDelegate.h"

@implementation GelatinSugarViewController
@synthesize flavourImage;
@synthesize flavourRGB;
@synthesize chooseButton;
@synthesize chooseLabel;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"GelatinSugarViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"GelatinSugarViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"GelatinSugarViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    firstTime = NO;
    backPressed = NO;
    nextPressed = NO;
    self.syrupBottle.hidden = YES;
    self.syrupPouring.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catchNotif:) name:@"FlavourChoosed" object:nil];
    
    return self;
}

- (IBAction)ChooseFlavor:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    ChooseFlavourLollipopViewController *pour = [[ChooseFlavourLollipopViewController alloc] init];
    pour.fromCore = NO;
    pour.fromGelatin = YES;
    
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] gelatinPurchased] ||[(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
        
        pour.isLocked = YES;
    }
    
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlDown
     animations:^{
         [self.navigationController
          pushViewController:pour
          animated:NO];
     }
     completion:NULL];
    
}

- (void)viewDidLoad
{
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
   
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"syrupFilledPot-iPad.png"] CGImage];
    }
    
    else _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"syrupFilledPot.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    _textureMask2 = [CALayer layer];
    _textureMask2.frame = CGRectMake(0, 0, self.syrupPouring.frame.size.width,self.syrupPouring.frame.size.height);
    _textureMask2.contents = (__bridge id)[[UIImage imageNamed:@"syrupPouring.png"] CGImage];
    self.syrupPouring.layer.mask = _textureMask2;
   
}


-(void)catchNotif:(NSNotification *)notif
{
   
    NSMutableDictionary * dict = notif.object;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.syrupPouring.image = [UIImage imageNamed:@"flavourPouringL-iPad.png"];
        self.liquid.image = [UIImage imageNamed:@"flavourPoured-iPad.png"];
    }
    else
    {
        self.syrupPouring.image = [UIImage imageNamed:@"flavourPouringL.png"];
        self.liquid.image = [UIImage imageNamed:@"flavourPoured.png"];
    }
    
    self.flavourImage = [dict objectForKey:@"flavourImage"];
    self.flavourRGB = [dict objectForKey:@"flavourRGB"];
    
    self.syrupBottle.image = flavourImage;
    self.syrupBottle.alpha = 1.0;
    super.nextButton.enabled = NO;
    self.syrupBottle.hidden = YES;
    self.fireOn.alpha = 0;
    self.bubbleBig1.alpha = 0;
    self.bubbleBig2.alpha = 1;
    self.bubbleSmall1.alpha = 1;
    self.bubbleSmall2.alpha = 1;
    _isPouring = NO;
    self.syrupPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"flavourPoured-iPad.png"] CGImage];
    else _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"flavourPoured.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    _sugar = 0;
    _currentRotation = _currentX;
    if ([super.timer isValid]) {
        [super.timer invalidate];
    }
    if ([super.timerPour isValid]) {
        [super.timerPour invalidate];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
    self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
    
    if (!firstTime) {
        firstTime = YES;
        self.syrupPouring.image = [self imageWithImage:self.syrupPouring.image rotatedByHue:flavourRGB];
        self.syrupPouring.image = [self imageWithImage:self.syrupPouring.image rotatedByHue:flavourRGB];
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
    }
    if (nextPressed) {
        nextPressed = NO;
        self.syrupPouring.image = [self imageWithImage:self.syrupPouring.image rotatedByHue:flavourRGB];
        self.syrupPouring.image = [self imageWithImage:self.syrupPouring.image rotatedByHue:flavourRGB];
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
        self.liquid.image = [self imageWithImage:self.liquid.image rotatedByHue:flavourRGB];
    }
    
    self.syrupBottle.image = flavourImage;
    self.syrupBottle.alpha = 1.0;
    super.nextButton.enabled = NO;
    self.syrupBottle.hidden = NO;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.bubbleBig1.alpha = 0;
    self.bubbleBig2.alpha = 0;
    self.bubbleSmall1.alpha = 0;
    self.bubbleSmall2.alpha = 0;
    if ([timerT isValid]) {
        [timerT invalidate];
    }
    timerT = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
    _isPouring = NO;
    self.syrupPouring.hidden = YES;
    if (!firstTime || backPressed) {
        self.syrupBottle.hidden = YES;
        self.syrupPouring.hidden = YES;
        backPressed = NO;
        _textureMask  = nil;
        _textureMask = [CALayer layer];
        _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"flavourPoured-iPad.png"] CGImage];
        else _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"flavourPoured.png"] CGImage];
        self.liquid.layer.mask = _textureMask;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             self.chooseButton.frame = CGRectMake(self.chooseButton.frame.origin.x, 0, self.chooseButton.frame.size.width, self.chooseButton.frame.size.height);
             self.chooseLabel.frame = CGRectMake(self.chooseLabel.frame.origin.x, 0, self.chooseLabel.frame.size.width, self.chooseLabel.frame.size.height);
             
         }
                         completion:^ (BOOL completed)
         {
         }];
    }
    
    else
    {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             self.chooseButton.frame = CGRectMake(self.chooseButton.frame.origin.x, -100, self.chooseButton.frame.size.width, self.chooseButton.frame.size.height);
             self.chooseLabel.frame = CGRectMake(self.chooseLabel.frame.origin.x, -100, self.chooseLabel.frame.size.width, self.chooseLabel.frame.size.height);
             
         }
                         completion:^ (BOOL completed)
         {
         }];
    }
}
- (void) rotate:(NSTimer *) theTimer {
    double rotation = _currentX*2.2;
    if (rotation > 0) rotation = 0;
    
    rotation -= .15;
    
    double difference = rotation - _currentRotation;
    _currentRotation += difference *.05;
    
    if(_currentRotation <= -1.3)
    {
        _currentRotation = -1.3;
        _isPouring = YES;
        self.syrupPouring.hidden = NO;
    }
    else
    {
          
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:5];
        _isPouring = NO;
        self.syrupPouring.hidden = YES;
    }
    
    self.syrupBottle.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void) pour:(NSTimer *) theTimer {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (_isPouring && ++_sugar < 8) {
           
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:5];
            CABasicAnimation* anim = [[CABasicAnimation alloc] init];
            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
            anim.keyPath = @"position";
            anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
            anim.duration = 0.5;
            _textureMask.position = CGPointMake(_textureMask.position.x, _textureMask.position.y - (_textureMask.frame.size.height/7));
            [_textureMask addAnimation:anim forKey:nil];
            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 
                                
             } completion:^(BOOL finished) {
                 
             }];
            
        }
        if (_sugar >= 8) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:5];
            [self.timer invalidate];
            [self.timerPour invalidate];
            _currentRotation = 0;
            _isPouring = NO;
            self.syrupPouring.hidden = YES;

            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.fireOn.alpha = 1;
               
                 
             } completion:^(BOOL finished) {
                 
             }];
            
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.syrupBottle.alpha = 0;
                
                 
                 
             } completion:^(BOOL finished) {
                 self.syrupBottle.hidden = YES;
                 [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];
                 
             }];
            
        }
        
    }
    else
    {
        if (_isPouring && ++_sugar < 8) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:5];
            
            
            CABasicAnimation* anim = [[CABasicAnimation alloc] init];
            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
            anim.keyPath = @"position";
            anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
            anim.duration = 0.5;
            _textureMask.position = CGPointMake(_textureMask.position.x, _textureMask.position.y - (_textureMask.frame.size.height/7));
            [_textureMask addAnimation:anim forKey:nil];
           
             
                   }
        if (_sugar >= 8) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:5];
            [self.timer invalidate];
            [self.timerPour invalidate];
            _currentRotation = 0;
            _isPouring = NO;
            self.syrupPouring.hidden = YES;

            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.fireOn.alpha = 1;
            } completion:^(BOOL finished) {
                 
             }];
            
            [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.syrupBottle.alpha = 0;
                
                 
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

- (IBAction)NextPage:(id)sender
{
    backPressed = YES;
    nextPressed = YES;
    
    GelatinStiringViewController *stirIt = [[GelatinStiringViewController alloc] init];
    stirIt.flavourRGB = flavourRGB;
    [self.navigationController pushViewController:stirIt animated:NO];
}

- (IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    if([self.timer isValid])
        [self.timer invalidate];
    if([self.timerPour isValid])
        [self.timerPour invalidate];
    UINavigationController * navController = self.navigationController;
   
    [navController popViewControllerAnimated:YES];
}

- (IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    firstTime = NO;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.syrupPouring.image = [UIImage imageNamed:@"flavourPouringL-iPad.png"];
        self.liquid.image = [UIImage imageNamed:@"flavourPoured-iPad.png"];
    }
    else
    {
        self.syrupPouring.image = [UIImage imageNamed:@"flavourPouringL.png"];
        self.liquid.image = [UIImage imageNamed:@"flavourPoured.png"];
    }
    
    [self viewWillAppear:YES];
}

@end
