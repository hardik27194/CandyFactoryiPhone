//
//  GelatinSugarViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/13/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GelatinViewController.h"

@interface GelatinSugarViewController : GelatinViewController
{
    BOOL firstTime, backPressed;
    BOOL nextPressed;
}

@property (nonatomic,retain)  UIImage * flavourImage;
@property (nonatomic,retain) NSMutableDictionary * flavourRGB;
@property (nonatomic,retain) IBOutlet UIButton * chooseButton;
@property (nonatomic,retain) IBOutlet UIImageView * chooseLabel;

- (IBAction)NextPage:(id)sender;
- (IBAction)ResetButtonPreseed:(id)sender;
- (IBAction)ChooseFlavor:(id)sender;

@end
