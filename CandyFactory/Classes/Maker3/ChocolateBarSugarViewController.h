//
//  ChocolateBarSugarViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/12/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface ChocolateBarSugarViewController : UIViewController
{
    CGPoint  offSet;
    UIImage* chocolate;
    BOOL _isPouring;
    double _currentRotation;
    double _currentX;
    int _sugar;
    CALayer *_textureMask;
    CALayer *_textureMask2;
    BOOL isTouchinSpoon;
    CGPoint _touchOffset;
    BOOL bubbleOnce;
    NSMutableArray * chocolateRGB;
    BOOL firstAppear;
    CGPoint intial;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,assign) CGPoint  offSet;
@property (nonatomic,retain) UIImage * chocolate;
@property (nonatomic,retain) IBOutlet UIImageView * sugarPack;
@property (nonatomic,retain) IBOutlet UIImageView * sugarPouring;
@property (nonatomic,retain) IBOutlet UIImageView * milkBottom;
@property (nonatomic,retain) UIImage * milkImage;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) IBOutlet UIImageView * liquid;
@property (nonatomic,retain) IBOutlet UIImageView * chocolateBar;
@property (nonatomic,retain) IBOutlet UIView * bottomView;
@property (nonatomic,retain) IBOutlet UIImageView *spoon;
@property (nonatomic,retain) IBOutlet UIImageView *stiredImage;
@property (nonatomic,retain) IBOutlet UIImageView *stirring;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleBig1;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleBig2;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleSmall1;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleSmall2;
@property (nonatomic,assign) int chocolateNumber;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timer2;
@property (strong, nonatomic) NSTimer *timerPour;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
-(IBAction)NextPage:(id)sender;

@end
