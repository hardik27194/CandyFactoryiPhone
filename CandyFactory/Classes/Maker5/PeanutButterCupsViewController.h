//
//  PeanutButterCupsViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface PeanutButterCupsViewController : UIViewController
{
    BOOL _isPouring;
    double _currentRotation;
    double _currentX;
    int _sugar;
    CALayer *_textureMask;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,retain) IBOutlet UIImageView * sugarPack;
@property (nonatomic,retain) IBOutlet UIImageView * sugarPouring;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) IBOutlet UIImageView * liquid;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerPour;

- (IBAction)BackButtonPressed:(id)sender;
- (IBAction)ResetButtonPreseed:(id)sender;
- (IBAction)NextPage:(id)sender;


@end
