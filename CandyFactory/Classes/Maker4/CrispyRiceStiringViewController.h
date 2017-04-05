//
//  CrispyRiceStiringViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrispyRiceStiringViewController : UIViewController

@property(nonatomic,retain) IBOutlet UIImageView *spoon;
@property(nonatomic,retain) IBOutlet UIImageView *stiredImage;
@property(nonatomic,retain) IBOutlet UIButton *nextButton;
@property(nonatomic,retain) IBOutlet UIImageView *murshmallow;
@property(nonatomic,retain) IBOutlet UIImageView *crispy;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
-(IBAction)NextPage:(id)sender;
@end
