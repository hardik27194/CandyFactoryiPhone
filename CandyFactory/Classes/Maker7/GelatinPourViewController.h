//
//  GelatinPourViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface GelatinPourViewController : UIViewController
{
    BOOL _isPouring;
    BOOL once;
    double _currentRotation;
    double _currentX;
    int _sugar;
    CALayer *_textureMask;
    CGPoint  point1;
    CGPoint  point2;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property(nonatomic,retain) IBOutlet UIView* syrupBottle;
@property(nonatomic,retain) IBOutlet UIView* potview;
@property(nonatomic,retain) IBOutlet UIImageView * syrupPouring;
@property(nonatomic,retain) IBOutlet UIImageView * potLiqiud;
@property(nonatomic,retain) IBOutlet UIImageView * liquid;
@property(nonatomic,retain) IBOutlet UIImageView * bottom;
@property(nonatomic,retain) IBOutlet UIImageView * fireOn;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleBig1;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleBig2;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleSmall1;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleSmall2;
@property(nonatomic,retain) IBOutlet UIButton * nextButton;
@property(nonatomic,retain) NSMutableDictionary * flavourRGB;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) NSTimer *timerPour;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
-(IBAction)NextPage:(id)sender;

@end
