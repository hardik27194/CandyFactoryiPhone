//
//  DipLollipopViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/29/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StirLollipopViewController.h"

@interface DipLollipopViewController : StirLollipopViewController
{
    BOOL isTouchingStick,first, firstAppear;
    BOOL firstTimeInPot;
    BOOL left;
    CGPoint initialCenter;
    CGAffineTransform initialTransform;
    CGPoint initial;
}

@property (nonatomic,retain) IBOutlet UIView * stickDigging;
@property (nonatomic,retain) IBOutlet UIImageView * stick;
@property (nonatomic,retain) IBOutlet UIImageView * flavour1;
@property (nonatomic,retain) IBOutlet UIImageView * flavour2;
@property (nonatomic,retain) IBOutlet UIImageView * coat;
@property (nonatomic,retain) IBOutlet UIImageView * core;
@property (nonatomic,retain) NSString * stickImage;
@property (nonatomic,retain) NSString * coreImage;
@property (nonatomic,retain) NSString * coatingImage;
@property (nonatomic,retain) NSTimer * timerApple;
@property (nonatomic,retain) NSTimer * timerOut;
@property (nonatomic,retain) NSMutableDictionary * flavourRGB;

@end
