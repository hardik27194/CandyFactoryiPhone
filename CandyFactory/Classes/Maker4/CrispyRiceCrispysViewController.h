//
//  CrispyRiceCrispysViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface CrispyRiceCrispysViewController : UIViewController
{
    BOOL _isPouring;
    double _currentRotation;
    double _currentX;
    int _sugar;
    CALayer *_textureMask;
    BOOL backPressed;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,retain) IBOutlet UIView * crispyCup;
@property (nonatomic,retain) IBOutlet UIImageView * crispyPouring;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) IBOutlet UIImageView * liquid;
@property (nonatomic,retain) IBOutlet UIImageView * chocolateBar;
@property (nonatomic,retain) IBOutlet UIView * bottomView;
@property (nonatomic) BOOL backPressed;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerPour;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
-(IBAction)NextPage:(id)sender;

@end
