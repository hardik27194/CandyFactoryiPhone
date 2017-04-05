//
//  PourPeanutViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 2/4/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface PourPeanutViewController : UIViewController
{
    CALayer *_textureMask;
    int _sugar;
    double _currentRotation;
    double _currentX;
    BOOL _isPouring,firstAppear;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,retain) IBOutlet UIImageView * pot;
@property (nonatomic,retain) IBOutlet UIImageView * mask;
@property (nonatomic,retain) IBOutlet UIImageView * treat;
@property (nonatomic,retain) IBOutlet UIImageView * sugarPack;
@property (nonatomic,retain) IBOutlet UIImageView * sugarPouring;
@property (nonatomic,retain) UIImage * potImage;
@property (nonatomic,retain) UIImage * maskImage;
@property (nonatomic,retain) NSString * treatImage;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerPour;

- (IBAction)BackButtonPressed:(id)sender;
- (IBAction)ResetButtonPreseed:(id)sender;
- (IBAction)NextPage:(id)sender;

@end
