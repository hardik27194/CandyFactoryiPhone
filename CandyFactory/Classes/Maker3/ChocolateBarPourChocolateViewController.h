//
//  ChocolateBarPourChocolateViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/17/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ChocolateBarPourChocolateViewController : UIViewController
{
    CGPoint  offSet;
    CALayer *_textureMask;
    int _sugar;
    double _currentRotation;
    double _currentX;
    BOOL _isPouring,firstAppear;
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (nonatomic,retain) IBOutlet UIImageView * topFilling;
@property (nonatomic,retain) IBOutlet UIImageView * middleFilling;
@property (nonatomic,retain) IBOutlet UIImageView * bottomFilling;
@property (nonatomic,retain) IBOutlet UIView * sugarPack;
@property (nonatomic,retain) IBOutlet UIImageView * sugarPouring;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) IBOutlet UIImageView * liquid;
@property (nonatomic,retain) IBOutlet UIImageView * potLiquid;
@property (nonatomic,retain) NSMutableDictionary * flavourRGb;
@property (nonatomic,retain) UIImage * topFillingImage;
@property (nonatomic,retain) UIImage * middleFillingImage;
@property (nonatomic,retain) UIImage * bottomFillingImage;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerPour;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)NextPage:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
@end
