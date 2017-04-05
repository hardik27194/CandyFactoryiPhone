//
//  ChocolateBarsChooseFillingViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/17/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChocolateBarsChooseFillingViewController : UIViewController <UIAlertViewDelegate>


@property(nonatomic,retain) IBOutlet UIScrollView * scroll;
@property(nonatomic,retain) NSMutableDictionary * flavourRGb;
@property(nonatomic,assign) BOOL isLocked;

-(IBAction)BackButtonPressed:(id)sender;

@end
