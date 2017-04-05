//
//  CandyApplesViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/6/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface CandyApplesViewController : UIViewController
{
    BOOL _isPouring;
    double _currentRotation;
    double _currentX;
    int _sugar;
    CALayer *_textureMask;
    CALayer *_textureMask2;
    NSTimer *timerT;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic, retain) IBOutlet UIImageView *syrupBottle;
@property (nonatomic, retain) IBOutlet UIImageView *syrupPouring;
@property (nonatomic, retain) IBOutlet UIImageView *liquid;
@property (nonatomic, retain) IBOutlet UIImageView *bottom;
@property (nonatomic, retain) IBOutlet UIImageView *fireOn;
@property (nonatomic, retain) IBOutlet UIImageView *bubbleBig1;
@property (nonatomic, retain) IBOutlet UIImageView *bubbleBig2;
@property (nonatomic, retain) IBOutlet UIImageView *bubbleSmall1;
@property (nonatomic, retain) IBOutlet UIImageView *bubbleSmall2;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerPour;

- (IBAction)BackButtonPressed:(id)sender;
- (IBAction)ResetButtonPreseed:(id)sender;
- (IBAction)NextPage:(id)sender;

@end
