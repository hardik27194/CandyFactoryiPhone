//
//  PeanutButterCupsViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "PeanutButterCupsViewController.h"
#import "PeanutPourViewController.h"
#import "AppDelegate.h"

@implementation PeanutButterCupsViewController
@synthesize timer;
@synthesize timerPour;
@synthesize sugarPack;
@synthesize sugarPouring;
@synthesize liquid;
@synthesize nextButton;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"PeanutButterCupsViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"PeanutButterCupsViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"PeanutButterCupsViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    
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

    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] peanutButterPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
    {
    }
    else
    {
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        if (![standard boolForKey:@"firstTimePeanut"])
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notice:" message:@"While playing PeanutButterCups Maker you will see ads. If you purchase the unlock PeanutButterCups pack, ads will be removed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            [standard setBool:YES forKey:@"firstTimePeanut"];
            [standard synchronize];
        }
        else
        {
        }
    }
    
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"sugarfilledPot2.png"] CGImage];
    self.liquid.layer.mask = _textureMask; 
}

- (void)viewWillAppear:(BOOL)animated
{
    self.sugarPack.alpha = 1.0;
    nextButton.enabled = NO;
    self.sugarPack.hidden = NO;
    _isPouring = NO;
    self.sugarPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"sugarfilledPot2.png"] CGImage];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:5];
        _isPouring = NO;
        self.sugarPouring.hidden = YES;
        
    }
    
    self.sugarPack.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void) pour:(NSTimer *) theTimer {
    
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

-(IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    UINavigationController * navController = self.navigationController;
//    [navController popViewControllerAnimated:NO];
//    [navController popViewControllerAnimated:NO];
    [navController popViewControllerAnimated:YES];
    
    
}




-(IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    self.sugarPack.alpha = 1.0;
    nextButton.enabled = NO;
    self.sugarPack.hidden = NO;
    _isPouring = NO;
    self.sugarPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"sugarfilledPot2.png"] CGImage];
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


- (IBAction)NextPage:(id)sender
{
    PeanutPourViewController *flavour = [[PeanutPourViewController alloc] init];
    [self.navigationController pushViewController:flavour animated:NO];
}

@end
