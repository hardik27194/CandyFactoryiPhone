//
//  ChocolateBarsEatingViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/9/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EatAppleViewController.h"
#import <Social/Social.h>

@interface ChocolateBarsEatingViewController : EatAppleViewController
{
    AVAudioPlayer * wrappSound;
    //UIImage * newBackImage;
}


@property(nonatomic,retain) UIImage * backImage;
@property(nonatomic,retain) UIImage * backgroundName;
@property(nonatomic,retain) UIImage * backImage2;
@property(nonatomic,retain) IBOutlet UIImageView * wrap;
@property(nonatomic,retain) UIImage * wrapImage;
@property(nonatomic,retain) IBOutlet UIView * downView;
@property(nonatomic,retain) IBOutlet UIButton * homeButton;
@property(nonatomic,retain) IBOutlet UIImageView * anotherViewOnTop;

@end
