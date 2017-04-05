//
//  ChocolateBarsDecorating2ViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 2/7/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "ChocolateBarsDecorating2ViewController.h"
#import "ExtrasMenuViewController.h"
#import "ChocolateBarsEatingViewController.h"


@implementation ChocolateBarsDecorating2ViewController
@synthesize backgroundImage2;
@synthesize wrapImage;
@synthesize transparentImage;
@synthesize backgroundImageForEating;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChocolateBarsDecorating2ViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChocolateBarsDecorating2ViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChocolateBarsDecorating2ViewController" bundle:[NSBundle mainBundle]];
    
    nextPressed = NO;
    [super prepareClassMostenire];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.background.image = self.backgroundImage2;
    self.wrap.hidden = NO;
    if (nextPressed)
    {
        if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] chocolateBarsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] )
        {
        }
        else
        {
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
    
//    if (!firstAppear) {
//        firstAppear = YES;
//        self.chocolateBar.image = [self imageWithImage:self.chocolateBar.image rotatedByHue:flavourRGB];
//        self.chocolateBar.image = [self imageWithImage:self.chocolateBar.image rotatedByHue:flavourRGB];
//    }
    

    self.wrap.image = self.wrapImage;
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
            [self.bigView addSubview:drawOn];
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
                [self.bigView addSubview:drawOn];
                
                lastTouchedPoint = touchPoint;
            }
        }
    }
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DrawOnSelected:) name:@"DrawOnSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtrasSelected:) name:@"ExtrasSelected" object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WrapSelected:) name:@"WrapSelected" object:nil];
}
- (IBAction)Next:(id)sender
{
    nextPressed = YES;
    ChocolateBarsEatingViewController *eating = [[ChocolateBarsEatingViewController alloc] init];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.bigView.frame.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.bigView.frame.size);
    self.wrap.hidden = YES;
	[self.bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    eating.backImage2 = viewImage;
    eating.backgroundName = backgroundImageForEating;
    eating.backImage = backgroundImage2;
    eating.wrapImage = wrapImage;
    
    
//    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
//        UIGraphicsBeginImageContextWithOptions(self.bigView.frame.size, NO, [UIScreen mainScreen].scale);
//    else
//        UIGraphicsBeginImageContext(self.bigView.frame.size);
//    self.background.hidden = YES;
//    
//	[self.bigView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//	UIImage *viewImage3 = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    eating.transparetImage = transparentImage;
    self.wrap.hidden = NO;
    self.background.hidden = NO;
    [self.navigationController pushViewController:eating animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
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
    [self.bigView addSubview:imageV];
    [extraList addObject:imageV];
    self.theView = imageV;
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



@end
