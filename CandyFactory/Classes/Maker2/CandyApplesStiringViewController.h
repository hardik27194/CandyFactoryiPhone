//
//  CandyApplesStiringViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/10/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyApplesStiringViewController : UIViewController
{
    BOOL isTouchinSpoon;
    CGPoint _touchOffset;
    NSTimer *timerTest;
    BOOL backPressed;
}

@property(nonatomic,retain) IBOutlet UIImageView *spoon;
@property(nonatomic,retain) IBOutlet UIImageView *stiredImage;
@property(nonatomic,retain) IBOutlet UIImageView *stirring;
@property(nonatomic,retain) IBOutlet UIImageView *syroup;
@property(nonatomic,retain) IBOutlet UIImageView *water;
@property(nonatomic,retain) IBOutlet UIImageView *sugar;
@property(nonatomic,retain) IBOutlet UIImageView *flavour;
@property(nonatomic,retain) IBOutlet UIImageView *bubbleBig1;
@property(nonatomic,retain) IBOutlet UIImageView *bubbleBig2;
@property(nonatomic,retain) IBOutlet UIImageView *bubbleSmall1;
@property(nonatomic,retain) IBOutlet UIImageView *bubbleSmall2;
@property(nonatomic,retain) IBOutlet UIButton *nextButton;
@property(nonatomic,retain) IBOutlet UIButton *chooseStick;
@property(nonatomic,retain) NSMutableDictionary *rgbForFlavour;
@property (nonatomic) BOOL backPressed;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)Next:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
-(IBAction)ChooseStick:(id)sender;
@end
