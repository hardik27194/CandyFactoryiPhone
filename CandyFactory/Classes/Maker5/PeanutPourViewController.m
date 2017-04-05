//
//  PeanutPourViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "PeanutPourViewController.h"
#import "PeanutStirViewController.h"
#import "AppDelegate.h"

@implementation PeanutPourViewController

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"PeanutPourViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"PeanutPourViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"PeanutPourViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    
    return self;
}

- (void)viewDidLoad
{
  //  [super viewDidLoad];
    
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
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"peanutTextureMixedRounded.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.sugarPack.alpha = 1.0;
    super.nextButton.enabled = NO;
    self.sugarPack.hidden = NO;
    _isPouring = NO;
    self.sugarPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"peanutTextureMixedRounded.png"] CGImage];
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
   
}

-(IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    self.sugarPack.alpha = 1.0;
    self.nextButton.enabled = NO;
    self.sugarPack.hidden = NO;
    _isPouring = NO;
    self.sugarPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"peanutTextureMixedRounded.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    _sugar = 0;
    _currentRotation = _currentX;
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    if ([self.timerPour isValid]) {
        [self.timerPour invalidate];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
    self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
    
}
-(void) rotate:(NSTimer *) theTimer {
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
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:3];
        _isPouring = NO;
        self.sugarPouring.hidden = YES;
        
    }
    
    self.sugarPack.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void) pour:(NSTimer *) theTimer {
    
    if (_isPouring && ++_sugar < 8) {
        
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:17];
        CABasicAnimation* anim = [[CABasicAnimation alloc] init];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
        anim.keyPath = @"position";
        anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        anim.duration = 0.5;
        _textureMask.position = CGPointMake(_textureMask.position.x, _textureMask.position.y - (_textureMask.frame.size.height/7));
        [_textureMask addAnimation:anim forKey:nil];
    }
    if (_sugar >= 8) {
        //[(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:3];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:17];
        [self.timer invalidate];
        [self.timerPour invalidate];
        _currentRotation = 0;
        _isPouring = NO;
        self.sugarPouring.hidden = YES;
        
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             self.sugarPack.alpha = 0;
             
         } completion:^(BOOL finished) {
             self.sugarPack.hidden = YES;
             [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];
             
         }];
        
    }
}


- (IBAction)NextPage:(id)sender
{
    PeanutStirViewController *flavour = [[PeanutStirViewController alloc] init];
    [self.navigationController pushViewController:flavour animated:NO];
}

- (IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    if([self.timer isValid])
        [self.timer invalidate];
    if([self.timerPour isValid])
        [self.timerPour invalidate];
    UINavigationController * navController = self.navigationController;
    [navController popViewControllerAnimated:NO];
}

@end
