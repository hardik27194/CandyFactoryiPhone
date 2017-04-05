//
//  CandyAppleDecoratingViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/11/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CandyAppleDecoratingViewController : UIViewController
{
    BOOL _isTouchingView;
    int lastClickedDecoration;
    UIImageView *drawOn;
    UIImage *currentDrawingImage;
    IBOutlet UIImageView *stupidCandyCoat;
    BOOL nextPressed;
    BOOL movingStopped;
    BOOL touchedExtra;
    NSMutableArray *extraList;
    int lastTouchedExtra;
    CGPoint lastTouchedPoint;
    int lastTag;
    
    UIImage *coatImage;
    AVAudioPlayer * decoratingSound;
    
//    int previousX;
//    int previousY;
}

@property(nonatomic,retain) IBOutlet UIButton *backgroundButton;
@property(nonatomic,retain) IBOutlet UIButton *drawOnButton;
@property(nonatomic,retain) IBOutlet UIButton *extrasButton;
@property(nonatomic,retain) IBOutlet UIImageView *stick;
@property(nonatomic,retain) IBOutlet UIImageView *apple;
@property(nonatomic,retain) IBOutlet UIImageView *background;
@property(nonatomic,retain) IBOutlet UIView *bigView;
@property(nonatomic,retain) NSString *stickName;
@property(nonatomic,retain) NSString *appleName;
@property(nonatomic,retain) UIImageView *theView;
@property(nonatomic,retain) UIImage *coatImage;


- (IBAction)Back:(id)sender;
- (IBAction)Reset:(id)sender;
- (IBAction)Next:(id)sender;
- (IBAction)ChangeBackground:(id)sender;
- (IBAction)DrawOns:(id)sender;
- (IBAction)Extras:(id)sender;
- (IBAction)undoClick:(id)sender;
- (BOOL)isFarEnoughFrom:(CGPoint)touchedPoint;
- (void)prepareClassMostenire;

@end
