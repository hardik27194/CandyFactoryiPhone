//
//  PourPeanutViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 2/4/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "PourPeanutViewController.h"
#import "PeanutDecoratingViewController.h"
#import "AppDelegate.h"


@implementation PourPeanutViewController
@synthesize pot;
@synthesize mask;
@synthesize treat;
@synthesize sugarPack;
@synthesize sugarPouring;
@synthesize potImage;
@synthesize maskImage;
@synthesize treatImage;
@synthesize timer;
@synthesize timerPour;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"PourPeanutViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"PourPeanutViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"PourPeanutViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    firstAppear = NO;
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.pot.image = potImage;
    self.sugarPack.alpha = 1;
    self.mask.image = self.maskImage;
    self.sugarPack.hidden = NO;
    self.treat.image = [UIImage imageNamed:treatImage];
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0,  0, self.treat.frame.size.width, 0);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:treatImage] CGImage];
    self.treat.layer.mask = _textureMask;
    
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
    
    if (_isPouring && ++_sugar < 8) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:10];
        CABasicAnimation* anim = [[CABasicAnimation alloc] init];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
        anim.keyPath = @"position";
        anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        anim.duration = 0.5;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textureMask.frame = CGRectMake(_textureMask.frame.origin.x, _textureMask.frame.origin.y,_textureMask.frame.size.width , _textureMask.frame.size.height+730/7);
        else  _textureMask.frame = CGRectMake(_textureMask.frame.origin.x, _textureMask.frame.origin.y,_textureMask.frame.size.width , _textureMask.frame.size.height+315/7);
        [_textureMask addAnimation:anim forKey:nil];
    }
    if (_sugar >= 8) {
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
           
             
             
             
         } completion:^(BOOL finished) {
             self.sugarPack.hidden = YES;
             
         }];
        
    }
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
    // Dispose of any resources that can be recreated.
}

-(IBAction)BackButtonPressed:(id)sender
{
    if([self.timer isValid])
        [self.timer invalidate];
    if ([self.timerPour isValid])
        [self.timerPour invalidate];
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)ResetButtonPreseed:(id)sender
{
    self.sugarPack.hidden = NO;
    self.sugarPack.alpha = 1;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0,  0, self.treat.frame.size.width, 0);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:treatImage] CGImage];
    self.treat.layer.mask = _textureMask;
    
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
    PeanutDecoratingViewController *decorate = [[PeanutDecoratingViewController alloc] init];
    decorate.treatName = treatImage;
    [self.navigationController pushViewController:decorate animated:YES];
}

@end
