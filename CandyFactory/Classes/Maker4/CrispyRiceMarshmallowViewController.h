//
//  CrispyRiceMarshmallowViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>
//#import "marshmellowEffect.h"

@class CAEmitterLayer;
@interface CrispyRiceMarshmallowViewController : UIViewController
{
    //marshmellowEffect *marsh;
    BOOL backPressed;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,assign)  CGPoint  offSet;
@property (strong) CAEmitterLayer *fireEmitter;
@property (nonatomic,retain) IBOutlet UIImageView * butterMelt;
@property (nonatomic,retain) IBOutlet UIImageView * marshmallowPack;
@property (nonatomic,retain) IBOutlet UIImageView * marshmallowPouring;
@property (nonatomic,retain) IBOutlet UIImageView * liquid;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) IBOutlet UIView * testView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerPour;
@property (nonatomic) BOOL backPressed;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
-(IBAction)NextPage:(id)sender;

@end
