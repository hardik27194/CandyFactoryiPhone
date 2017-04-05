//
//  LolipopsEatingViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/7/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EatAppleViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SFSConfettiScreen.h"

@interface LolipopsEatingViewController : EatAppleViewController
{
    CALayer *_textureMask;
}

@property (nonatomic, retain) NSString *stickName;
@property (nonatomic, retain) IBOutlet UIImageView *stick;
@property (nonatomic, retain) IBOutlet UIImageView *something;
@property (nonatomic, retain) UIImage *backImage;
@property (nonatomic, retain) UIImage *backgroundImage;

@end