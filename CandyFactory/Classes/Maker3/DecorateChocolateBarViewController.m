//
//  DecorateChocolateBarViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/16/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "DecorateChocolateBarViewController.h"
#import "ChocolateBarsEatingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ExtrasMenuViewController.h"
#import "AppDelegate.h"
#import "ChocolateBarsDecorating2ViewController.h"

@implementation DecorateChocolateBarViewController
@synthesize chocolateBar;
@synthesize flavourRGB;
@synthesize wrap;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"DecorateChocolateBarViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"DecorateChocolateBarViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"DecorateChocolateBarViewController" bundle:[NSBundle mainBundle]];
    
    firstAppear = NO;
    nextPressed = NO;
    [super prepareClassMostenire];
    
    return self;
}

- (void)viewDidLoad
{
  
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] chocolateBarsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
        
    }
    else{
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showPopupAd];
    }
    lastClickedDecoration = 0;
    movingStopped = YES;
    lastTag = 1;
    //    previousX = -100;
    //    previousY = -100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackgroundChaged:) name:@"BackgroundChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drizzleSelected) name:@"DrizzlesSelected2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtrasSelected:) name:@"DrizzlesSelected" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WrapSelected:) name:@"WrapSelected" object:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    wrap.hidden = NO;
    if (nextPressed) {
        if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] chocolateBarsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
            
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

    if (!firstAppear) {
        firstAppear = YES;
        self.chocolateBar.image = [self imageWithImage:self.chocolateBar.image rotatedByHue:flavourRGB];
        self.chocolateBar.image = [self imageWithImage:self.chocolateBar.image rotatedByHue:flavourRGB];
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
    
     if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] chocolateBarsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
     {
         extras._isBought = YES;
     }
    extras.choice = 4;
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

-(IBAction)Wrapps:(id)sender
{
    lastClickedDecoration = 4;
    movingStopped = YES;
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    ExtrasMenuViewController *extras;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-iPad" bundle:nil];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController-5" bundle:nil];
    else
        extras = [[ExtrasMenuViewController alloc]initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    
    extras.choice = 5;
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] chocolateBarsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased])
    {
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

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    touchedExtra = NO;
    //movingStopped = YES;
    lastTouchedExtra = -1;
    [self.bigView bringSubviewToFront:wrap];
}

-(void)WrapSelected:(NSNotification *)notif
{
    wrap.image = [UIImage imageNamed:notif.object];
    [self.bigView bringSubviewToFront:wrap];
}

- (IBAction)Next:(id)sender
{
    nextPressed = YES;
    ChocolateBarsDecorating2ViewController *decorating2 = [[ChocolateBarsDecorating2ViewController alloc] init];

    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.bigView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.bigView.frame.size);
    
    wrap.hidden = YES;
	[self.bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.wrap.hidden = NO;
    decorating2.backgroundImage2 = viewImage;
    decorating2.wrapImage = self.wrap.image;
    
    
    
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.bigView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.bigView.frame.size);
    self.background.hidden = YES;
    self.wrap.hidden = YES;
    
	[self.bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
	UIImage *viewImage3 = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    self.background.hidden = NO;
    self.wrap.hidden = NO;
    
    decorating2.transparentImage = viewImage3;
    decorating2.backgroundImageForEating = self.background.image;
    
    [self.navigationController pushViewController:decorating2 animated:NO];
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
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] chocolateBarsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased]) {
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

- (IBAction)GoBack:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)drizzleSelected
{
    [self.bigView bringSubviewToFront:wrap];
}

- (IBAction)undoClick:(id)sender
{
    if(wrap.image)
    {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
        wrap.image = nil;
    }
    else
        [super undoClick:sender];
}

@end
