//
//  ChocolateBarMilkViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/11/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface ChocolateBarMilkViewController : UIViewController
{
    CGPoint  offSet;
    CGPoint initial;
    UIImage* chocolate;
    CALayer *_textureMask;
    CALayer *_textureMask2;
    int _sugar;
    double _currentRotation;
    double _currentX;
    BOOL _isPouring;
    BOOL first;
    BOOL bubbleOnce;
    BOOL fromChocolate;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,assign) CGPoint  offSet;
@property (nonatomic,retain) UIImage* chocolate;
@property (nonatomic,retain) IBOutlet UIImageView * milkTextureBottom;
@property (nonatomic,retain) IBOutlet UIImageView * fireOn;
@property (nonatomic,retain) IBOutlet UIImageView * chocolateBar;
@property (nonatomic,retain) IBOutlet UIImageView * milkTexture;
@property (nonatomic,retain) IBOutlet UIImageView * milkPouring;
@property (nonatomic,retain) IBOutlet UIView * bottomView;
@property (nonatomic,retain) IBOutlet UIButton* nextButton;
@property (nonatomic,retain) IBOutlet UIButton* ChooseChocolate;
@property (nonatomic,retain) IBOutlet UIView * milkcup;
@property (nonatomic,retain) IBOutlet UIImageView * textLabel;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleBig1;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleBig2;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleSmall1;
@property (nonatomic,retain) IBOutlet UIImageView * bubbleSmall2;
@property (nonatomic,retain) IBOutlet UIImageView * labelButton;
@property (nonatomic,assign) int chocolateNumber;
@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) NSTimer *timerPour;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)NextPage:(id)sender;
-(IBAction)ChooseChocolate:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;

@end
