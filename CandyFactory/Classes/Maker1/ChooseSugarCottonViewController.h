//
//  ChooseSugarCottonViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/20/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ChooseSugarCottonViewController : UIViewController<UIAlertViewDelegate>
{
    NSMutableArray * sugarRGB;
    NSMutableDictionary * rgb;
    IBOutlet UIImageView *labelSugarStick;
    BOOL _isLocked;
}

@property(nonatomic,retain) NSMutableArray * sugarRGB;
@property(nonatomic,assign) BOOL fromCore;
@property(nonatomic,retain) IBOutlet UIScrollView * scroll;
@property(nonatomic,retain) IBOutlet UIImageView* back;
@property(nonatomic,retain) IBOutlet UIImageView *label;
@property(nonatomic,assign) int canister;
@property(nonatomic,retain) NSMutableDictionary * sugarSelected;

-(IBAction)BackButtonPressed:(id)sender;
@end
