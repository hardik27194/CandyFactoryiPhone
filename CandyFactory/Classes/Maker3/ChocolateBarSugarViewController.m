//
//  ChocolateBarSugarViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/12/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "ChocolateBarSugarViewController.h"
#import "ChocolateBarsChooseFillingViewController.h"
#import "ChocolateBarFillingsViewController.h"
#import "AppDelegate.h"


@implementation ChocolateBarSugarViewController

@synthesize timer;
@synthesize timerPour;
@synthesize sugarPack;
@synthesize sugarPouring;
@synthesize liquid;
@synthesize nextButton;
@synthesize chocolateBar;
@synthesize bottomView;
@synthesize offSet;
@synthesize chocolate;
@synthesize milkBottom;
@synthesize milkImage;
@synthesize spoon;
@synthesize stiredImage;
@synthesize stirring;
@synthesize timer2;
@synthesize bubbleBig1;
@synthesize bubbleBig2;
@synthesize bubbleSmall1;
@synthesize bubbleSmall2;
@synthesize chocolateNumber;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChocolateBarSugarViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChocolateBarSugarViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChocolateBarSugarViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    bubbleOnce = NO;
    isTouchinSpoon = NO;
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
    
    intial = spoon.center;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"sugarfilledPot2.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    chocolateRGB = [[NSMutableArray alloc]init];
    
    
    for (int i =0; i<10; i++) {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        
        switch (i) {
            case 0:
            {
                [dict setObject:[NSNumber numberWithInt:177] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:78] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:69] forKey:@"blue"];
                
                break;
            }
            case 1:
            {
                [dict setObject:[NSNumber numberWithInt:45] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:28] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:24] forKey:@"blue"];
                
                break;
            }
            case 2:
            {
                [dict setObject:[NSNumber numberWithInt:222] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:208] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:185] forKey:@"blue"];
                
                break;
            }
            case 3:
            {
                [dict setObject:[NSNumber numberWithInt:229] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:48] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:155] forKey:@"blue"];
                
                break;
            }
            case 4:
            {
                [dict setObject:[NSNumber numberWithInt:29] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:152] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:247] forKey:@"blue"];
                
                break;
            }
            case 5:
            {
                [dict setObject:[NSNumber numberWithInt:147] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:206] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:64] forKey:@"blue"];
                
                break;
            }
            case 6:
            {
                [dict setObject:[NSNumber numberWithInt:94] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:64] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:155] forKey:@"blue"];
                
                break;
            }
            case 7:
            {
                [dict setObject:[NSNumber numberWithInt:242] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:134] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:47] forKey:@"blue"];
                
                break;
            }
            case 8:
            {
                [dict setObject:[NSNumber numberWithInt:94] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:47] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:9] forKey:@"blue"];
                
                break;
            }
            case 9:
            {
                [dict setObject:[NSNumber numberWithInt:213] forKey:@"red"];
                [dict setObject:[NSNumber numberWithInt:90] forKey:@"green"];
                [dict setObject:[NSNumber numberWithInt:90] forKey:@"blue"];
                
                break;
            }
                
            default:
                break;
        }
        [chocolateRGB addObject:dict];
    }

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!bubbleOnce) {
        bubbleOnce = YES;
        self.bubbleBig1.alpha = 0;
        NSTimer * timerT;
        timerT = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
    }
    spoon.alpha = 0.0;
    self.spoon.userInteractionEnabled = NO;
    isTouchinSpoon = NO;
    self.milkBottom.image = milkImage;
    self.chocolateBar.center = offSet;
    self.chocolateBar.image = self.chocolate;
    self.stiredImage.alpha = 0.0;
    self.sugarPack.alpha = 1.0;
    self.chocolateBar.alpha = 1.0;
    self.milkBottom.alpha = 1.0;
    self.liquid.alpha = 1.0;
    nextButton.enabled = NO;
    self.sugarPack.hidden = NO;
    _isPouring = NO;
    self.sugarPouring.hidden = YES;
    _textureMask  = nil;
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.liquid.frame.size.height, self.liquid.frame.size.width, self.liquid.frame.size.height);
    _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"sugarfilledPot2.png"] CGImage];
    self.liquid.layer.mask = _textureMask;
    if (!firstAppear) {
        firstAppear = YES;
        self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:[chocolateRGB objectAtIndex:chocolateNumber]];
        self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:[chocolateRGB objectAtIndex:chocolateNumber]];
    }
    
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
             nextButton.enabled = NO;
             self.spoon.userInteractionEnabled = YES;
             self.spoon.alpha = 1.0;
             
             
         } completion:^(BOOL finished) {
              self.sugarPack.hidden = YES;
             
         }];
        
    }
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

- (IBAction)BackButtonPressed:(id)sender
{
    if([self.timer isValid])
        [self.timer invalidate];
    if([self.timerPour isValid])
        [self.timerPour invalidate];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    if (self.spoon.alpha > 0.0) {
        stirring.hidden = NO;
    }
    if ( ! (stirring.alpha > 0.0) ) {
        stirring.alpha = 1;
    }
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == self.spoon)
    {
        isTouchinSpoon = YES;
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:7];
        
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        _touchOffset = CGPointMake(touchPoint.x - self.spoon.center.x, touchPoint.y-self.spoon.center.y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    stirring.hidden = YES;
       [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:7];
}

- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    if(isTouchinSpoon)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 454) self.spoon.center = CGPointMake(454, self.spoon.center.y);
            if (self.spoon.center.x < 221) self.spoon.center = CGPointMake(221, self.spoon.center.y);
            if (self.spoon.center.y > 540) self.spoon.center = CGPointMake(self.spoon.center.x, 540);
            if (self.spoon.center.y < 314) self.spoon.center = CGPointMake(self.spoon.center.x, 314);
        }
        else if([UIScreen mainScreen].bounds.size.height == 568)
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 190) self.spoon.center = CGPointMake(190, self.spoon.center.y);
            if (self.spoon.center.x < 105) self.spoon.center = CGPointMake(105, self.spoon.center.y);
            if (self.spoon.center.y > 234 + 72) self.spoon.center = CGPointMake(self.spoon.center.x, 234 + 72);
            if (self.spoon.center.y < 156 + 72) self.spoon.center = CGPointMake(self.spoon.center.x, 156 + 72);
        }
        else
        {
            self.spoon.center = CGPointMake(touchPoint.x - _touchOffset.x, touchPoint.y - _touchOffset.y);
            if (self.spoon.center.x > 190) self.spoon.center = CGPointMake(190, self.spoon.center.y);
            if (self.spoon.center.x < 105) self.spoon.center = CGPointMake(105, self.spoon.center.y);
            if (self.spoon.center.y > 234) self.spoon.center = CGPointMake(self.spoon.center.x, 234);
            if (self.spoon.center.y < 156) self.spoon.center = CGPointMake(self.spoon.center.x, 156);
        }
        
        if(self.stiredImage.alpha < 1)
        {
            self.stiredImage.alpha += .01;
            self.chocolateBar.alpha -=.01;
            self.milkBottom.alpha -=.01;
            self.liquid.alpha -=.01;
            self.stirring.alpha -=.009;
        }
        else
        {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
               
                 stirring.alpha = 0.0;
                 self.spoon.alpha = 0;
                 self.nextButton.enabled = YES;
             } completion:Nil];
        }
    }
}

- (UIImage*) imageWithImage:(UIImage*) source rotatedByHue:(NSMutableDictionary *) rgb;
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


-(IBAction)ResetButtonPreseed:(id)sender
{
       [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    [self viewWillAppear:YES];
}


- (IBAction)NextPage:(id)sender
{
    isTouchinSpoon = NO;
    spoon.center = intial;
       [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    
    ChocolateBarFillingsViewController *filling = [[ChocolateBarFillingsViewController alloc] init];
    filling.rgbFlavour = [chocolateRGB objectAtIndex:chocolateNumber];
    [self.navigationController pushViewController:filling animated:YES];
}

@end
