//
//  GelatinFrisgeViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PSAnalogClockView.h"

@interface GelatinFrisgeViewController : UIViewController
{
    CGPoint initial;
    CGPoint lastThing;
}
@property (nonatomic,retain) IBOutlet UIImageView * fridgeDoor;
@property (nonatomic,retain) IBOutlet UIView * potView;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) IBOutlet UIView *clockView;
@property (nonatomic,retain) IBOutlet UIImageView *hourHand;
@property (nonatomic,retain) IBOutlet UIImageView *minuteHand;
@property (nonatomic,retain) IBOutlet UIImageView * liquid;
@property (nonatomic,retain) IBOutlet UIImageView * labelDown; 
@property (nonatomic,retain) NSTimer *updateTimer;
@property (nonatomic,retain) NSMutableDictionary * flavourRGB;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
-(IBAction)NextPage:(id)sender;
@end
