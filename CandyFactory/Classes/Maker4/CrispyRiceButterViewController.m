//
//  CrispyRiceButterViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "CrispyRiceButterViewController.h"
#import "CrispyRiceMarshmallowViewController.h"
#import "AppDelegate.h"

@interface CrispyRiceButterViewController ()
{
    CALayer *_textureMask;
    CALayer *_textureMask2;
    int enough;
    BOOL stuff;
}

@end

@implementation CrispyRiceButterViewController
@synthesize butter;
@synthesize butterMelting;
@synthesize nextButton;
@synthesize fireOn;
@synthesize timerPour;
@synthesize backPressed;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CrispyRiceButterViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CrispyRiceButterViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CrispyRiceButterViewController" bundle:[NSBundle mainBundle]];
    
    enough = 0;
    stuff = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] crispiesRicePurchased] ||[(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] )
    {
    }
    else
    {
        NSUserDefaults * standard = [NSUserDefaults standardUserDefaults];
        if (![standard boolForKey:@"firstTimeCrispy"]) {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Notice:" message:@"While playing CrispyRiceTreats Maker you will see ads. If you purchase the unlock CrispyRiceTreats pack, ads will be removed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            [standard setBool:YES forKey:@"firstTimeCrispy"];
            [standard synchronize];
        }
        else
        {
        }
    }
    self.butter.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(backPressed == NO)
    {
        if([self.timerPour isValid])
            [self.timerPour invalidate];
        
        self.butter.userInteractionEnabled = YES;
        self.butter.hidden = NO;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.butter.center = CGPointMake(355, 310);
            butter.image = [UIImage imageNamed:@"butter-iPad.png"];
        }
        else if([UIScreen mainScreen].bounds.size.height == 568)
        {
            self.butter.center = CGPointMake(204, 153);
            butter.image = [UIImage imageNamed:@"butter.png"];
        }
        else
        {
            self.butter.center = CGPointMake(204, 81);
            butter.image = [UIImage imageNamed:@"butter.png"];
        }
        butter.layer.mask = nil;
        butter.alpha = 1;

        self.nextButton.enabled = NO;
        _textureMask = [CALayer layer];
        _textureMask.frame = CGRectMake(0, self.butterMelting.frame.size.height, self.butterMelting.frame.size.width, self.butterMelting.frame.size.height);
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"butterMelted-iPad.png"] CGImage];
        else
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"butterMelted.png"] CGImage];
        
        self.butterMelting.layer.mask = _textureMask;
    }
    else
    {
        backPressed = NO;
        
        if([self.timerPour isValid])
            [self.timerPour invalidate];
        
        enough = 0;
        stuff = NO;
        self.butter.userInteractionEnabled = YES;
        self.butter.hidden = NO;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.butter.center = CGPointMake(355, 310);
            butter.image = [UIImage imageNamed:@"butter-iPad.png"];
        }
        else if([UIScreen mainScreen].bounds.size.height == 568)
        {
            self.butter.center = CGPointMake(204, 153);
            butter.image = [UIImage imageNamed:@"butter.png"];
        }
        else
        {
            self.butter.center = CGPointMake(204, 81);
            butter.image = [UIImage imageNamed:@"butter.png"];
        }
        
        butter.layer.mask = nil;
        butter.alpha = 1;
        
        self.nextButton.enabled = NO;
        
        _textureMask = [CALayer layer];
        _textureMask.frame = CGRectMake(0, self.butterMelting.frame.size.height, self.butterMelting.frame.size.width, self.butterMelting.frame.size.height);
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"butterMelted-iPad.png"] CGImage];
        else
            _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"butterMelted.png"] CGImage];
        
        self.butterMelting.layer.mask = _textureMask;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)meltButter
{
    if(++enough < 8)
    {
        CABasicAnimation* anim = [[CABasicAnimation alloc] init];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask.position.x, _textureMask.position.y)];
        anim.keyPath = @"position";
        anim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        anim.duration = 0.5;
        _textureMask.position = CGPointMake(_textureMask.position.x, _textureMask.position.y - (_textureMask.frame.size.height/7));
        [_textureMask addAnimation:anim forKey:nil];
        CABasicAnimation* anim2 = [[CABasicAnimation alloc] init];
        anim2.fromValue = [NSValue valueWithCGPoint:CGPointMake(_textureMask2.position.x, _textureMask2.position.y)];
        anim2.keyPath = @"position";
        anim2.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        anim2.duration = 0.5;
        _textureMask2.position = CGPointMake(_textureMask2.position.x, _textureMask2.position.y + (_textureMask2.frame.size.height/9));
        [_textureMask2 addAnimation:anim2 forKey:nil];
    }
    else
    {
        [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             self.butter.alpha = 0;
             
         } completion:^(BOOL finished) {
             
         }];
        
        [self.timerPour invalidate];
         [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:22];
        self.timerPour = nil;
        [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.3];
    }
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view] == self.butter)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        
        if([self.butter isUserInteractionEnabled])
            self.butter.center = touchPoint;
        
        if([self checkIfIsInPot:self.butter.center] && !stuff)
        {
            stuff = YES;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                self.butter.image = [UIImage imageNamed:@"butterMelting-iPad.png"];
            else
                self.butter.image = [UIImage imageNamed:@"butterMelting.png"];
            
            self.butterMelting.layer.mask = _textureMask;
            _textureMask2 = [CALayer layer];
            _textureMask2.frame = CGRectMake(0, 0, self.butter.frame.size.width, self.butter.frame.size.height);
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                _textureMask2.contents = (__bridge id)[[UIImage imageNamed:@"butterMelting-iPad.png"] CGImage];
            else
                _textureMask2.contents = (__bridge id)[[UIImage imageNamed:@"butterMelting.png"] CGImage];
            
            self.butter.layer.mask = _textureMask2;
            self.butter.alpha = 0.7;
            
            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                     self.butter.center = CGPointMake(365, 690);
                 else if([UIScreen mainScreen].bounds.size.height == 568)
                     self.butter.center = CGPointMake(164, 383);
                 else
                     self.butter.center = CGPointMake(160, 334);
                 
             } completion:^(BOOL finished) {
                 
             }];
            
            
            self.butter.userInteractionEnabled = NO;
            [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
             {
                 self.fireOn.alpha = 1;
                 
             } completion:^(BOOL finished) {
                 
             }];
                      
            [self performSelector:@selector(startPouring) withObject:nil afterDelay:0.5];
        }
        else
        {
            nextButton.enabled = NO;
        }
    }
}

- (void)startPouring
{
    //here melButter
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:22];
    self.timerPour = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(meltButter) userInfo:nil repeats: YES];
}

- (BOOL)checkIfIsInPot:(CGPoint)point
{
    if([UIScreen mainScreen].bounds.size.height == 568)
    {
        if(point.x > 105 && point.x < 218)
        {
            if (point.y > 360 && point.y < 419)
            {
                return YES;
            }
            return NO;
        }
    }
    else if([UIScreen mainScreen].bounds.size.height == 480)
    {
        if(point.x > 105 && point.x < 200)
        {
            if (point.y > 320 && point.y < 353)
            {
                return YES;
            }
            return NO;
        }
    }
    else
    {
        if(point.x > 200 && point.x < 550)
        {
            if (point.y > 630 && point.y < 680)
            {
                return YES;
            }
            return NO;
        }
    }
    return NO;
}

- (IBAction)BackButtonPressed:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:22];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)NextPage:(id)sender
{
    CrispyRiceMarshmallowViewController *marshmallow = [[CrispyRiceMarshmallowViewController alloc] init];
    marshmallow.offSet = self.butterMelting.center;
    marshmallow.butterMelt.layer.mask = self.butterMelting.layer.mask;
    [self.navigationController pushViewController:marshmallow animated:NO];
}

- (IBAction)Reset:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:17];
    if([self.timerPour isValid])
        [self.timerPour invalidate];

    enough = 0;
    stuff = NO;
    self.butter.userInteractionEnabled = YES;
    self.butter.hidden = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.butter.center = CGPointMake(355, 310);
        butter.image = [UIImage imageNamed:@"butter-iPad.png"];
    }
    else
    {
        self.butter.center = CGPointMake(204, 81);
        butter.image = [UIImage imageNamed:@"butter.png"];
    }
    
    butter.layer.mask = nil;
    butter.alpha = 1;
    
    self.nextButton.enabled = NO;
    
    _textureMask = [CALayer layer];
    _textureMask.frame = CGRectMake(0, self.butterMelting.frame.size.height, self.butterMelting.frame.size.width, self.butterMelting.frame.size.height);
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"butterMelted-iPad.png"] CGImage];
    else
        _textureMask.contents = (__bridge id)[[UIImage imageNamed:@"butterMelted.png"] CGImage];
    self.butterMelting.layer.mask = _textureMask;
}



@end
