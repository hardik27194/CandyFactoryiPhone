//
//  StirLollipopViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "StirLollipopViewController.h"
#import "ChooseFlavourLollipopViewController.h"
#import "ChooseStickViewController.h"
#import "AppDelegate.h"

@implementation StirLollipopViewController

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"StirLollipopViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"StirLollipopViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"StirLollipopViewController" bundle:[NSBundle mainBundle]];
    
    firstTime = NO;
    return self;
}

-(IBAction)Next:(id)sender
{
    //Do nothing
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    ChooseStickViewController *chooseStick2 = [[ChooseStickViewController alloc] init];
    chooseStick2.rgbForFlavour = self.rgbForFlavour;
    chooseStick2.fromLollipops = YES;
    
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] lollipopsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
        chooseStick2.isLocked = YES;
        
    }
    [self.navigationController pushViewController:chooseStick2 animated:YES];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
  
    self.spoon.hidden = NO;
    self.spoon.alpha = 1.0;
    self.stiredImage.alpha = 0.0;
    self.sugar.alpha = 1.0;
    self.syroup.alpha = 1.0;
    self.water.alpha = 1.0;
    self.bubbleBig1.alpha = 0;
    timerTest = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(playBubbles) userInfo:nil repeats:YES];
    
    if(!firstTime)
    {
        firstTime = YES;
        self.flavour.image = [self imageWithImage:self.flavour.image rotatedByHue:self.rgbForFlavour];
        self.flavour.image = [self imageWithImage:self.flavour.image rotatedByHue:self.rgbForFlavour];
        self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:self.rgbForFlavour];
        self.stiredImage.image = [self imageWithImage:self.stiredImage.image rotatedByHue:self.rgbForFlavour];
    }
   
}
- (UIImage*)imageWithImage:(UIImage*)source rotatedByHue:(NSMutableDictionary*)rgb
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
    
    // Convert the filter output back into a UIImage.
    // This section from http://stackoverflow.com/a/7797578/1318452
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef resultRef = [context createCGImage:resultCore fromRect:[resultCore extent]];
    UIImage *result = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    
    return result;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:7];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if (self.spoon.alpha > 0.0)
    {
        
    }
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.spoon)
    {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:7];
        isTouchinSpoon = YES;
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        _touchOffset = CGPointMake(touchPoint.x - self.spoon.center.x, touchPoint.y-self.spoon.center.y);
    }
}

- (IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
