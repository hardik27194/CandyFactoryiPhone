//
//  CrispyRiceButterViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CrispyRiceButterViewController : UIViewController
{
    BOOL backPressed;
}


@property (nonatomic,retain) IBOutlet UIImageView * butter;
@property (nonatomic,retain) IBOutlet UIImageView * butterMelting;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) IBOutlet UIImageView *fireOn;
@property (strong, nonatomic) NSTimer *timerPour;
@property (nonatomic) BOOL backPressed;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)NextPage:(id)sender;
-(IBAction)Reset:(id)sender;

@end
