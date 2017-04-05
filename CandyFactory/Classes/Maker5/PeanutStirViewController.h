//
//  PeanutStirViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeanutStirViewController : UIViewController
{
    BOOL isTouchinSpoon;
    CGPoint _touchOffset;
}
@property(nonatomic,retain) IBOutlet UIImageView *spoon;
@property(nonatomic,retain) IBOutlet UIImageView *sugar;
@property(nonatomic,retain) IBOutlet UIButton *nextButton;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)Next:(id)sender;
-(IBAction)ResetButtonPreseed:(id)sender;
@end
