//
//  CottonCandyViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/6/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "slushEffect.h"

@interface CottonCandyViewController : UIViewController
{
    CALayer *_textureMask;
    CALayer *_textureMask2;
    CALayer *_textureMask3;
    CALayer *_textureMask4;
    CGPoint initial1, initial2, initial3, initial4;
    NSMutableDictionary * rgbsSugars;
    BOOL isPressing;
    int sugar;
    IBOutlet UIView *backgroundView;
    
    BOOL backPressed,grow;
    
    slushEffect *slush1;
    slushEffect *slush2;
    slushEffect *slush3;
    slushEffect *slush4;
}

@property (nonatomic,retain) IBOutlet UIButton *fillbutton;
@property (nonatomic,retain) IBOutlet UIButton *nextButton;
@property (nonatomic,retain) IBOutlet UIImageView * sugar1;
@property (nonatomic,retain) IBOutlet UIImageView * sugar2;
@property (nonatomic,retain) IBOutlet UIImageView * sugar3;
@property (nonatomic,retain) IBOutlet UIImageView * sugar4;
@property (nonatomic,retain) IBOutlet UIImageView * sugarSmall;
@property (nonatomic,retain) IBOutlet UIImageView * sugarBig;
@property (nonatomic,retain) IBOutlet UIImageView * label;
@property (nonatomic,retain) IBOutlet UIImageView * arrow1; 
@property (nonatomic,retain) IBOutlet UIImageView * arrow2;
@property (nonatomic,retain) IBOutlet UIImageView * arrow3;
@property (nonatomic,retain) IBOutlet UIImageView * arrow4;
@property (strong, nonatomic) IBOutlet slushEffect *slushEffectView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timerArrows;
@property (nonatomic) BOOL backPressed;


-(IBAction)Back:(id)sender;
-(IBAction)FillPresse:(id)sender;
-(IBAction)StopPressing:(id)sender;
-(IBAction)Next:(id)sender;
-(IBAction)TouchedCanister:(UIButton*)sender;
- (IBAction)resetClick:(id)sender;


@end
