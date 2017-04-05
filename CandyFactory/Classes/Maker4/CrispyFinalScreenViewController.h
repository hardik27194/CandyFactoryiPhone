//
//  CrispyFinalScreenViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/21/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EatAppleViewController.h"
#import "SFSConfettiScreen.h"
#import <Social/Social.h>

@interface CrispyFinalScreenViewController : EatAppleViewController
{
    IBOutlet UIButton *homeButton;
    
}

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *backImage;
//
//- (IBAction)Back:(id)sender;
//- (IBAction)Home:(id)sender;
//- (IBAction)eatAgainCrispy:(id)sender;

@end
