//
//  CandyAppleDecoratingViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/11/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "CandyAppleDecoratingViewController.h"
#import "EatAppleViewController.h"
#import "ExtrasMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "DigAppleViewController.h"

@implementation CandyAppleDecoratingViewController

@synthesize backgroundButton;
@synthesize drawOnButton;
@synthesize extrasButton;
@synthesize stick;
@synthesize apple;
@synthesize stickName;
@synthesize appleName;
@synthesize background;
@synthesize bigView;
@synthesize theView;
@synthesize coatImage;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"CandyAppleDecoratingViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"CandyAppleDecoratingViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"CandyAppleDecoratingViewController" bundle:[NSBundle mainBundle]];
    
    nextPressed = NO;
    _isTouchingView = NO;
    extraList = [[NSMutableArray alloc] init];
    lastTouchedExtra = -1;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
    {
    }
    else
    {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showPopupAd];
    }
    lastClickedDecoration = 0;
    movingStopped = YES;
    lastTag = 1;
//    previousX = -100;
//    previousY = -100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackgroundChaged:) name:@"BackgroundChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DrawOnSelected:) name:@"DrawOnSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtrasSelected:) name:@"ExtrasSelected" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(nextPressed)
    {
        if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
            
        }
        else{
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] showPopupAd];
        }
        nextPressed = NO;
    }
    stupidCandyCoat.image = coatImage;
    
    self.stick.image = [UIImage imageNamed:self.stickName];
    self.apple.image = [UIImage imageNamed:self.appleName];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.backgroundButton.frame = CGRectMake(self.backgroundButton.frame.origin.x, 0, self.backgroundButton.frame.size.width, self.backgroundButton.frame.size.height);
     } completion:^ (BOOL completed)
     {
         [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
          {
             self.drawOnButton.frame = CGRectMake(self.drawOnButton.frame.origin.x, 0, self.drawOnButton.frame.size.width, self.drawOnButton.frame.size.height);
          } completion:^ (BOOL completed)
          {
              [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
               {
                  self.extrasButton.frame = CGRectMake(self.extrasButton.frame.origin.x, 0, self.extrasButton.frame.size.width, self.extrasButton.frame.size.height);
               } completion:^ (BOOL completed)
               {
                   
                   
               }];
              
          }];
         
     }];
}

- (IBAction)Back:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    NSArray *viewControllers = self.navigationController.viewControllers;
    DigAppleViewController *previousView = [viewControllers objectAtIndex:[viewControllers count] - 2];
    previousView.backPressed = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{

    BOOL foundExtra = NO;
    UITouch *touch = [[event allTouches] anyObject];
    for(UIImageView *imgView in extraList)
    {
        if([touch view] == imgView)
        {
            touchedExtra = YES;
            lastTouchedExtra = imgView.tag;
            foundExtra = YES;
        }
    }
    
    if(foundExtra == NO)
    {
        if(movingStopped == NO)
        {
            drawOn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, currentDrawingImage.size.width/2, currentDrawingImage.size.height/2)];
            drawOn.image = currentDrawingImage;
            drawOn.tag = lastTag + 1;
            lastTag++;
            
            CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
            drawOn.center = CGPointMake(touchPoint.x, touchPoint.y);
            [bigView addSubview:drawOn];
            lastTouchedPoint = touchPoint;
        }
    }
}


- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    touchedExtra = NO;
    //movingStopped = YES;
    lastTouchedExtra = -1;
}

- (void)touchesMoved:(NSSet*) touches withEvent:(UIEvent*)event
{
    if(touchedExtra == YES)
    {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        for(int i = 0; i < [extraList count]; i++)
        {
            UIImageView *imgView = [extraList objectAtIndex:i];

            if(imgView.tag == lastTouchedExtra)
                self.theView = [extraList objectAtIndex:i];
        }
        self.theView.center = CGPointMake(touchPoint.x, touchPoint.y);
    }
    else if(lastClickedDecoration == 2)//draw on apple
    {
        if(movingStopped == NO)
        {
            CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
            if([self isFarEnoughFrom:touchPoint])
            {
                drawOn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, currentDrawingImage.size.width/2, currentDrawingImage.size.height/2)];
                drawOn.image = currentDrawingImage;
                drawOn.tag = lastTag;
                
                
                drawOn.center = CGPointMake(touchPoint.x, touchPoint.y);
                [bigView addSubview:drawOn];
                
                lastTouchedPoint = touchPoint;
            }
        }
    }
}

- (BOOL)isFarEnoughFrom:(CGPoint)touchedPoint
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(touchedPoint.x < lastTouchedPoint.x - 35)
            return YES;
        
        if(touchedPoint.x > lastTouchedPoint.x + 35)
            return YES;
        
        if(touchedPoint.y > lastTouchedPoint.y + 35)
            return YES;
        
        if(touchedPoint.y < lastTouchedPoint.y - 35)
            return YES;
    }
    else
    {
        if(touchedPoint.x < lastTouchedPoint.x - 25)
            return YES;
        
        if(touchedPoint.x > lastTouchedPoint.x + 25)
            return YES;
        
        if(touchedPoint.y > lastTouchedPoint.y + 25)
            return YES;
        
        if(touchedPoint.y < lastTouchedPoint.y - 25)
            return YES;

    }
    
    return NO;
}


- (IBAction)Reset:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    for(UIView *view in [bigView subviews])
    {
        if(view != stick && view != background && view != apple && view != stupidCandyCoat)
           [view removeFromSuperview];
    }
}

- (void)BackgroundChaged:(NSNotification*)notif
{
    self.background.image = [UIImage imageNamed:notif.object];
}

- (void)DrawOnSelected:(NSNotification*)notif
{
    //here do  something
    currentDrawingImage = [UIImage imageNamed:notif.object];
    movingStopped = NO;
    lastClickedDecoration = 2;

    
}

- (void)ExtrasSelected:(NSNotification*)notif
{
    movingStopped = YES;
    UIImage *newImage = [UIImage imageNamed:notif.object];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:notif.object]];
    imageV.frame = CGRectMake(0, 0, newImage.size.width/2, newImage.size.height/2);
    imageV.center = self.view.center;
    imageV.tag = lastTag + 1;
    lastTag++;
    imageV.userInteractionEnabled = YES;
    [bigView addSubview:imageV];
    [extraList addObject:imageV];
    theView = imageV;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DrizzlesSelected2" object:nil];
}


- (IBAction)Next:(id)sender
{
    nextPressed = YES;
    movingStopped = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    EatAppleViewController *digg = [[EatAppleViewController alloc] init];
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(bigView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(bigView.frame.size);
	[bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    digg.backImage = viewImage;
    
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(bigView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(bigView.frame.size);
    background.hidden = YES;
	[bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
	UIImage *viewImage2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    digg.transparetImage = viewImage2;
    background.hidden = NO;
    
    //imi mai trebuie si backgroundNumber!
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, background.frame.size.width, background.frame.size.height)];
    tempImageView.image = background.image;
    
    UIImageView *stickImgView = [[UIImageView alloc] initWithImage:stick.image];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        stickImgView.frame = CGRectMake(358, -10, 63, 433);
    else if([UIScreen mainScreen].bounds.size.height == 568)
        stickImgView.frame = CGRectMake(144, 96, 33, 220);
    else
        stickImgView.frame = CGRectMake(144, -5, 33, 220);
    [tempImageView addSubview:stickImgView];
    
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(tempImageView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(tempImageView.frame.size);
	[tempImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    
	UIImage *maskApple = UIGraphicsGetImageFromCurrentImageContext();
    digg.maskImage = [maskApple copy];
        
    [self.navigationController pushViewController:digg animated:YES];
}

- (IBAction)ChangeBackground:(id)sender
{
    lastClickedDecoration = 1;
    movingStopped = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    ExtrasMenuViewController * extras;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-iPad" bundle:nil];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-5" bundle:nil];
    else
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    
    extras.choice = 1;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        extras._isBought = YES;
    }
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlDown
     animations:^{
         [self.navigationController
          pushViewController:extras
          animated:NO];
     }
     completion:NULL];
}

- (IBAction)DrawOns:(id)sender
{
    lastClickedDecoration = 2;
    movingStopped = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    ExtrasMenuViewController * extras;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        extras = [[ExtrasMenuViewController alloc] initWithNibName:@"ExtrasMenuViewController-iPad" bundle:nil];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-5" bundle:nil];
    else
        extras = [[ExtrasMenuViewController alloc] initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    
    extras.choice = 2;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        extras._isBought = YES;
    }
    
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlDown
     animations:^{
         [self.navigationController
          pushViewController:extras
          animated:NO];
     }
     completion:NULL];
}

- (IBAction)Extras:(id)sender
{
    lastClickedDecoration = 3;
    movingStopped = YES;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    ExtrasMenuViewController *extras;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-iPad" bundle:nil];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-5" bundle:nil];
    else
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    
    extras.choice = 3;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] candyApplesPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
        extras._isBought = YES;
    }
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlDown
     animations:^{
         [self.navigationController
          pushViewController:extras
          animated:NO];
     }
     completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)undoClick:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    for(UIView *view in [self.bigView subviews])
    {
        if(view.tag == lastTag)
            [view removeFromSuperview];
    }
    
    if([[extraList lastObject] tag] == lastTag)
        [extraList removeLastObject];

    if(lastTag > 1)
        lastTag--;
}

- (void)prepareClassMostenire
{
    nextPressed = NO;
    _isTouchingView = NO;
    extraList = [[NSMutableArray alloc] init];
    lastTouchedExtra = -1;
}


@end
