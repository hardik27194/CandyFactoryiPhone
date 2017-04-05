//
//  CandyApplesViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/6/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CandyApplesViewController.h"
#import "CandyAppleWaterViewController.h"
#import "AppDelegate.h"


@implementation CandyApplesViewController

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

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CandyApplesViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CandyApplesViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CandyApplesViewController" bundle:[NSBundle mainBundle]];
    
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

    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
    {
    }
    else
    {
        NSUserDefaults * standard = [NSUserDefaults standardUserDefaults];
        if(![standard boolForKey:@"firstTimeCandyApple"])
        {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Notice:" message:@"While playing CandyApple Maker you will see ads. If you purchase the unlock CandyApple pack, ads will be removed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            [standard setBool:YES forKey:@"firstTimeCandyApple"];
            [standard synchronize];
        }
        else
        {
        }
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     
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
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"syrupFilledPot-iPad.png"] CGImage];
    }
    
    else _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"syrupFilledPot2.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    _textureMask2 = [CALayer layer];
    _textureMask2.frame = CGRectMake(0, 0, self.syrupPouring.frame.size.width,self.syrupPouring.frame.size.height);
    _textureMask2.contents = (__bridge id)[[UIImage imageNamed:@"syrupPouring.png"] CGImage];
    self.syrupPouring.layer.mask = _textureMask2;
    _sugar = 0;
    _currentRotation = _currentX;
    
    if([timer isValid])
        [timer invalidate];
    if ([timerPour isValid])
        [timerPour invalidate];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
    self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
    
}

- (IBAction)BackButtonPressed:(id)sender
{
    if([timer isValid])
        [timer invalidate];
    if ([timerPour isValid])
        [timerPour invalidate];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) rotate:(NSTimer *) theTimer
{
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
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:3];
        _isPouring = NO;
        self.syrupPouring.hidden = YES;
    }
    
    self.syrupBottle.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void)playBubbles
{
    [UIView beginAnimations:@"sparkle" context:nil];
    [UIView setAnimationDuration:0.3];
    
    if (bubbleBig1.alpha < 1)
    {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 0;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 1;
    }
    else if (bubbleBig2.alpha < 1)
    {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 0;
        bubbleSmall2.alpha = 1;
    }
    else if(bubbleSmall1.alpha < 1)
    {
        bubbleBig1.alpha = 1;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 0;
    }
    else if(bubbleSmall2.alpha < 1)
    {
        bubbleBig1.alpha = 0;
        bubbleBig2.alpha = 1;
        bubbleSmall1.alpha = 1;
        bubbleSmall2.alpha = 1;
    }
    [UIView commitAnimations];
}

- (void)pour:(NSTimer*)theTimer
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (_isPouring && ++_sugar < 7)
        {
             [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:3];
            
            //here make red the fire and then start the bubbles
           
            CABasicAnimation* anim = [[CABasicAnimation alloc] init];
            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
            anim.keyPath = @"position";
            anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
            anim.duration = 0.5;
            _textureMask.position = CGPointMake(_textureMask.position.x, _textureMask.position.y - (_textureMask.frame.size.height/6));
            [_textureMask addAnimation:anim forKey:nil];
            
            if(_sugar == 1)
            {
                timerT = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
            }
    
        }
        if(_sugar >= 7)
        {
             [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:3];
            [self.timer invalidate];
            [self.timerPour invalidate];
            _currentRotation = 0;
            _isPouring = NO;
            self.syrupPouring.hidden = YES;
           
            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.fireOn.alpha = 1;
             }
             completion:^(BOOL finished)
             {
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
        if (_isPouring && ++_sugar < 6)
        {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:3];
            //here make red the fire and then start the bubbles
             if (_sugar < 5)
             {
            CABasicAnimation* anim = [[CABasicAnimation alloc] init];
            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
            anim.keyPath = @"position";
            anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
            anim.duration = 0.6;
            _textureMask.position = CGPointMake(_textureMask.position.x, _textureMask.position.y - (_textureMask.frame.size.height/4));
            [_textureMask addAnimation:anim forKey:nil];
             }

            

            
            if (_sugar ==1) {
                
                timerT = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
            }    
            
        }
        if(_sugar >= 6)
        {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:3];
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

- (IBAction)ResetButtonPreseed:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
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
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"syrupFilledPot-iPad.png"] CGImage];
    }
    
    else _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"syrupFilledPot2.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    _textureMask2 = [CALayer layer];
    _textureMask2.frame = CGRectMake(0, self.syrupPouring.frame.size.height, self.liquid.frame.size.width,0);
    _textureMask2.contents = (__bridge id)[[UIImage imageNamed:@"syrupPouring.png"] CGImage];
    //self.syrupPouring.layer.mask = _textureMask2;
    _sugar = 0;
    
    _currentRotation = _currentX;
    
    if([timerT isValid])
        [timerT invalidate];
    if([timer isValid])
        [timer invalidate];
    if([timerPour isValid])
        [timerPour invalidate];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
    self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
}

- (IBAction)NextPage:(id)sender
{
    if([timerT isValid])
        [timerT invalidate];
    
    CandyAppleWaterViewController *pourWater = [[CandyAppleWaterViewController alloc] init];
    [self.navigationController pushViewController:pourWater animated:NO];
}

@end
