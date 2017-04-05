//
//  CandyAppleFlavourViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/6/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface CandyAppleFlavourViewController : UIViewController
{
    BOOL _isPouring;
    double _currentRotation;
    double _currentX;
    int _sugar;
    BOOL  hasNotif;
    CALayer *_textureMask;
    NSMutableArray *flavoursRGB;
    int selectedFlavour;
    NSTimer *timerT;
    BOOL backPressed;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,retain) IBOutlet UIImageView *flavourBottle;
@property (nonatomic,retain) IBOutlet UIImageView *flavourPouring;
@property (nonatomic,retain) IBOutlet UIButton *nextButton;
@property (nonatomic,retain) IBOutlet UIImageView *liquid;
@property (nonatomic,retain) IBOutlet UIButton *pickFlavourButton;

@property (nonatomic,retain) IBOutlet UIImageView *bubbleBig1;
@property (nonatomic,retain) IBOutlet UIImageView *bubbleBig2;
@property (nonatomic,retain) IBOutlet UIImageView *bubbleSmall1;
@property (nonatomic,retain) IBOutlet UIImageView *bubbleSmall2;
@property (nonatomic) BOOL backPressed;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerPour;

- (IBAction)BackButtonPressed:(id)sender;
- (IBAction)ResetButtonPreseed:(id)sender;
- (IBAction)NextPage:(id)sender;
- (IBAction)ChooseFlavour:(id)sender;

@end
