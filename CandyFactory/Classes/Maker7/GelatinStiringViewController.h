//
//  GelatinStiringViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GelatinStiringViewController : UIViewController
{
    BOOL isTouchinSpoon;
    CGPoint _touchOffset;
    CGPoint intialCenterSpoon;
    BOOL once;
}
@property(nonatomic,retain) IBOutlet UIImageView *spoon;
@property(nonatomic,retain) IBOutlet UIImageView *stiredImage;
@property(nonatomic,retain) IBOutlet UIImageView *stirring;
@property(nonatomic,retain) IBOutlet UIImageView *water;
@property(nonatomic,retain) IBOutlet UIImageView *sugar;
@property(nonatomic,retain) NSMutableDictionary * flavourRGB;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleBig1;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleBig2;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleSmall1;
@property(nonatomic,retain) IBOutlet UIImageView * bubbleSmall2;
@property(nonatomic,retain) IBOutlet UIButton *nextButton;
@property(nonatomic,retain) IBOutlet UIButton *chooseStick;
@property(nonatomic,retain) NSTimer * timerT;
-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)Next:(id)sender;
-(IBAction)ChooseStick:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;

@end
