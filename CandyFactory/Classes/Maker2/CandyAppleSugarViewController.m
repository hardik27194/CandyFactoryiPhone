//
//  CandyAppleSugarViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/6/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CandyAppleSugarViewController.h"
#import "CandyAppleFlavourViewController.h"
#import "AppDelegate.h"

@implementation CandyAppleSugarViewController
@synthesize timer;
@synthesize timerPour;
@synthesize sugarPack;
@synthesize sugarPouring;
@synthesize liquid;
@synthesize nextButton;
@synthesize bubbleBig1;
@synthesize bubbleBig2;
@synthesize bubbleSmall1;
@synthesize bubbleSmall2;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CandyAppleSugarViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CandyAppleSugarViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CandyAppleSugarViewController" bundle:[NSBundle mainBundle]];
    
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
    
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"sugarfilledPot2.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.bubbleBig1.alpha = 0;
    
    if([timerT isValid])
        [timerT invalidate];
    timerT = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
    
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
-(void)playBubbles
{
    [UIView beginAnimations:@"sparkle" context:nil];
    [UIView setAnimationDuration:0.3];
    if (bubbleBig1.alpha < 1) {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 0;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 1;
    }
    else if (bubbleBig2.alpha < 1) {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 0;
        bubbleSmall2.alpha = 1;
    }
    
    else if (bubbleSmall1.alpha < 1) {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 0;
    }
    else if (bubbleSmall2.alpha < 1) {
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


- (IBAction)BackButtonPressed:(id)sender
{
    if([timer isValid])
        [timer invalidate];
    if ([timerPour isValid])
        [timerPour invalidate];

    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ResetButtonPreseed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self viewWillAppear:YES];
}

- (IBAction)NextPage:(id)sender
{
    CandyAppleFlavourViewController *flavour = [[CandyAppleFlavourViewController alloc] init];
    [self.navigationController pushViewController:flavour animated:NO];
}

@end
