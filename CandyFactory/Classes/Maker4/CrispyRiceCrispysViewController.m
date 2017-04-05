//
//  CrispyRiceCrispysViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CrispyRiceCrispysViewController.h"
#import "CrispyRiceStiringViewController.h"
#import "CrispyRiceMarshmallowViewController.h"
#import "AppDelegate.h"

@interface CrispyRiceCrispysViewController ()

@end

@implementation CrispyRiceCrispysViewController
@synthesize timer;
@synthesize timerPour;
@synthesize crispyCup;
@synthesize crispyPouring;
@synthesize liquid;
@synthesize nextButton;
@synthesize chocolateBar;
@synthesize bottomView;
@synthesize backPressed;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CrispyRiceCrispysViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CrispyRiceCrispysViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CrispyRiceCrispysViewController" bundle:[NSBundle mainBundle]];
    
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

    _sugar = 0;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
       _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"crispysTtexturePotRounded-iPad.png"] CGImage];
    else
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"crispysTtexturePotRounded.png"] CGImage];

    self.liquid.layer.mask = _textureMask;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(backPressed == NO)
    {
        self.crispyPouring.hidden = YES;

        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
        self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
    }
    else
    {
        backPressed = NO;
        
        _textureMask = [CALayer layer];
        _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"crispysTtexturePotRounded-iPad.png"] CGImage];
        else
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"crispysTtexturePotRounded.png"] CGImage];
        
        self.liquid.layer.mask = _textureMask;
        
        _sugar = 0;
        _isPouring = NO;
        self.crispyPouring.hidden = YES;
        self.crispyCup.alpha = 1.0;
        self.crispyCup.hidden = NO;
        
        if([self.timer isValid])
            [self.timer invalidate];
        if([self.timerPour isValid])
            [self.timerPour invalidate];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
        self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)rotate:(NSTimer*)theTimer
{
    double rotation = _currentX*2.2;
    if(rotation > 0)
        rotation = 0;
    
    rotation -= .15;
    
    double difference = rotation - _currentRotation;
    _currentRotation += difference *.05;
    
    if(_currentRotation <= -1.3)
    {
        _currentRotation = -1.3;
        
        _isPouring = YES;
        self.crispyPouring.hidden = NO;
        
    }
    else
    {
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:13];
        _isPouring = NO;
        self.crispyPouring.hidden = YES;
    }
    
    self.crispyCup.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void)pour:(NSTimer*)theTimer
{
    if(_isPouring && ++_sugar < 8)
    {
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:13];
        CABasicAnimation* anim = [[CABasicAnimation alloc] init];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
        anim.keyPath = @"position";
        anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        anim.duration = 0.5;
        _textureMask.position = CGPointMake(_textureMask.position.x, _textureMask.position.y - (_textureMask.frame.size.height/7));
        [_textureMask addAnimation:anim forKey:nil];
    }
    if(_sugar >= 8)
    {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:13];
        [self.timer invalidate];
        [self.timerPour invalidate];
        _currentRotation = 0;
        _isPouring = NO;
        self.crispyPouring.hidden = YES;
        
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             self.crispyCup.alpha = 0;
             [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];

         } completion:^(BOOL finished) {
             self.crispyCup.hidden = YES;
             
         }];
    }
}

- (IBAction)BackButtonPressed:(id)sender
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    NSArray *viewControllers = self.navigationController.viewControllers;
    CrispyRiceMarshmallowViewController *previousView = [viewControllers objectAtIndex:[viewControllers count] - 2];
    previousView.backPressed = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)ResetButtonPreseed:(id)sender
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    backPressed = YES;
    [self viewWillAppear:YES];
}

- (IBAction)NextPage:(id)sender
{
    CrispyRiceStiringViewController *spoonStir = [[CrispyRiceStiringViewController alloc] init];
    [self.navigationController pushViewController:spoonStir animated:NO];
}

@end
