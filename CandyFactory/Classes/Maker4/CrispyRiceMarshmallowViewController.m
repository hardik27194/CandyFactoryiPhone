//
//  CrispyRiceMarshmallowViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CrispyRiceMarshmallowViewController.h"
#import "CrispyRiceCrispysViewController.h"
//#import "marshmellowEffect.h"
#import "AppDelegate.h"
#import "CrispyRiceButterViewController.h"
#import "SFSChickenScreen.h"

@interface CrispyRiceMarshmallowViewController ()
{
    BOOL _isPouring;
    double _currentRotation;
    double _currentX;
    int _sugar;
    CALayer *_textureMask;
    CALayer *_textureMask2;
}

@end

@implementation CrispyRiceMarshmallowViewController
@synthesize offSet;
@synthesize butterMelt;
@synthesize marshmallowPack;
@synthesize marshmallowPouring;
@synthesize liquid;
@synthesize nextButton;
@synthesize timer;
@synthesize timerPour;
@synthesize backPressed;
@synthesize testView;
@synthesize fireEmitter;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CrispyRiceMarshmallowViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CrispyRiceMarshmallowViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CrispyRiceMarshmallowViewController" bundle:[NSBundle mainBundle]];
    
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
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"marshmallowTexturePot-iPad.png"] CGImage];
    else
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"marshmallowTexturePot.png"] CGImage];
    
    self.liquid.layer.mask = _textureMask;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        marshmallowPouring.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"marshmallowsPouring-iPad1.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad2.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad3.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad4.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad5.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad6.png"], [UIImage imageNamed:@"marshmallowsPouring-iPad7.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad8.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad9.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad10.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad11.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad12.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad13.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad14.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad15.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad16.png"],[UIImage imageNamed:@"marshmallowsPouring-iPad.png"],nil];
        marshmallowPouring.animationDuration = 3.0;
        marshmallowPouring.animationRepeatCount = 2;
    }
    
    
//    _textureMask2 = [CALayer layer];
//    _textureMask2.frame = CGRectMake(0,  0, self.marshmallowPouring.frame.size.width, 0);
//    _textureMask2.contents = (__bridge id)[[UIImage imageNamed:@"marshmallowsPouring.png"] CGImage];
//    self.marshmallowPouring.layer.mask = _textureMask2;
    //if iPad
//    marsh = [[marshmellowEffect alloc] initWithColor:[UIColor whiteColor] andFrame:CGRectMake(0, 0, 768, 800)];
//    [marsh awakeFromNib];
//    [self.view addSubview:marsh];

}

- (void) setFireAmount:(float)zeroToOne
{
	// Update the fire properties
	[self.fireEmitter setValue:[NSNumber numberWithInt:(zeroToOne * 10)]
					forKeyPath:@"emitterCells.fire.birthRate"];
	[self.fireEmitter setValue:[NSNumber numberWithFloat:zeroToOne]
					forKeyPath:@"emitterCells.fire.lifetime"];
	[self.fireEmitter setValue:[NSNumber numberWithFloat:(zeroToOne * 0.35)]
					forKeyPath:@"emitterCells.fire.lifetimeRange"];
	self.fireEmitter.emitterSize = CGSizeMake(50 * zeroToOne, 0);
	
//	[self.smokeEmitter setValue:[NSNumber numberWithInt:zeroToOne * 4]
//					 forKeyPath:@"emitterCells.smoke.lifetime"];
//	[self.smokeEmitter setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.3] CGColor]
//					 forKeyPath:@"emitterCells.smoke.color"];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fireEmitter	= [CAEmitterLayer layer];
    
    self.fireEmitter.emitterPosition = CGPointMake(marshmallowPouring.frame.size.width/2.0,0);
	self.fireEmitter.emitterSize	= CGSizeMake(marshmallowPouring.frame.size.width/2.0, 0);
	self.fireEmitter.emitterMode	= kCAEmitterLayerOutline;
	self.fireEmitter.emitterShape	= kCAEmitterLayerLine;
	// with additive rendering the dense cell distribution will create "hot" areas
	self.fireEmitter.renderMode		= kCAEmitterLayerAdditive;
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
	[fire setName:@"fire"];
    
    
	fire.birthRate			= 10;
	fire.emissionLongitude  = M_PI;
	fire.velocity			= 200;
	fire.velocityRange		= 50;
	fire.emissionRange		= M_PI / 4;
	fire.yAcceleration		= 0;
//    fire.scale = 0.9;
  //  fire.scaleRange = 0.2;
    //fire.spin = 0;
    //fire.spinRange = 10;
	fire.lifetime			= 50;
	fire.lifetimeRange		= (50.0 * 0.35);
    
	//fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
	fire.contents = (id) [[UIImage imageNamed:@"marsh.png"] CGImage];
    
    self.fireEmitter.emitterCells	= [NSArray arrayWithObject:fire];
    [marshmallowPouring.layer addSublayer:self.fireEmitter];
    [self setFireAmount:0.9];
    
//    SFSChickenScreen * chicken = [[SFSChickenScreen alloc]initWithFrame:CGRectMake(0, 0, 320, 100)chickenPosition:CGPointMake(156, 127)];
//    [testView addSubview:chicken];
//    [chicken decayOverTime:10.0];
    
    if(backPressed == NO)
    {
        self.marshmallowPouring.hidden = YES;
        //[marsh setFountainOn:NO];
        self.butterMelt.center = offSet;

        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
        self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
    }
    else
    {
        backPressed = NO;
        
        _textureMask = [CALayer layer];
        _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"marshmallowTexturePot-iPad.png"] CGImage];
        else
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"marshmallowTexturePot.png"] CGImage];
        
        self.liquid.layer.mask = _textureMask;
        
        _sugar = 0;
        
        self.marshmallowPack.hidden = NO;
        self.marshmallowPack.alpha = 1.0;
        
        self.marshmallowPouring.hidden = YES;
        //[marsh setFountainOn:NO];
        self.butterMelt.center = offSet;
        
        if([self.timer isValid])
            [self.timer invalidate];
        if([self.timerPour isValid])
            [self.timerPour invalidate];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(rotate:) userInfo:nil repeats: YES];
        self.timerPour = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(pour:) userInfo:nil repeats: YES];
    }
}

- (void)rotate:(NSTimer*)theTimer
{
    double rotation = _currentX * 2.2;
    if(rotation > 0)
        rotation = 0;
    
    rotation -= .15;
    
    double difference = rotation - _currentRotation;
    _currentRotation += difference *.05;
    
    if(_currentRotation <= -1.3)
    {
        _currentRotation = -1.3;
        
        _isPouring = YES;
        self.marshmallowPouring.hidden = NO;
        [self.marshmallowPouring startAnimating];
        //[marsh setFountainOn:YES];
    }
    else
    {
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:12];
        _isPouring = NO;
        self.marshmallowPouring.hidden = YES;
        //[marsh setFountainOn:NO];
    }
    
    self.marshmallowPack.transform = CGAffineTransformMakeRotation(_currentRotation);
}

- (void)pour:(NSTimer*)theTimer
{
    if(_isPouring && ++_sugar < 8)
    {
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:12];
//        if (_sugar <4) {
//            CABasicAnimation* anim = [[CABasicAnimation alloc] init];
//            anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
//            anim.keyPath = @"position";
//            anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
//            anim.duration = 0.4;
//            _textureMask2.frame = CGRectMake(_textureMask.frame.origin.x, _textureMask.frame.origin.y,_textureMask.frame.size.width , _textureMask.frame.size.height+226/3);
//            [_textureMask2 addAnimation:anim forKey:nil];
//        }
        //here make red the fire and then start the bubbles
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
          [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:12];
        [self.timer invalidate];
        [self.timerPour invalidate];
        _currentRotation = 0;
        _isPouring = NO;
        self.marshmallowPouring.hidden = YES;
        //[marsh setFountainOn:NO];
   
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             self.marshmallowPack.alpha = 0;
             [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];
             //nextButton.enabled = YES;
             
         } completion:^(BOOL finished) {
             self.marshmallowPack.hidden = YES;
             
         }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)BackButtonPressed:(id)sender
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    NSArray *viewControllers = self.navigationController.viewControllers;
    CrispyRiceButterViewController *previousView = [viewControllers objectAtIndex:[viewControllers count] - 2];
    previousView.backPressed = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ResetButtonPreseed:(id)sender
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    backPressed = YES;
    [self viewWillAppear:YES];
}

- (IBAction)NextPage:(id)sender
{
    CrispyRiceCrispysViewController *crispy = [[CrispyRiceCrispysViewController alloc] init];
    [self.navigationController pushViewController:crispy animated:NO];
}

@end
