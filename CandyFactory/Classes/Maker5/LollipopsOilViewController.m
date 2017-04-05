//
//  LollipopsOilViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "LollipopsOilViewController.h"
#import "LollipopsWaterViewController.h"
#import "AppDelegate.h"


@implementation LollipopsOilViewController

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"LollipopsOilViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"LollipopsOilViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"LollipopsOilViewController" bundle:[NSBundle mainBundle]];
    
    _isPouring = NO;
    
    return self;
}

- (void)viewDidLoad
{
   // [super viewDidLoad];
    
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

    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] lollipopsPurchased] ||[(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
        
        
    }
    else
    {
        NSUserDefaults * standard = [NSUserDefaults standardUserDefaults];
        if (![standard boolForKey:@"firstTimeLollipop"]) {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Notice:" message:@"While playing Lollipops Maker you will see ads. If you purchase the unlock Lollipops pack, ads will be removed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            [standard setBool:YES forKey:@"firstTimeLollipop"];
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

- (IBAction)NextPage:(id)sender
{
    LollipopsWaterViewController *water = [[LollipopsWaterViewController alloc] init];
    [self.navigationController pushViewController:water animated:NO];
}

- (IBAction)BackButtonPressed:(id)sender
{
    if([self.timer isValid])
        [self.timer invalidate];
    if ([self.timerPour isValid])
        [self.timerPour invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
