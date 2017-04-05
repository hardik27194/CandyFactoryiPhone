//
//  StickAndAppleViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/18/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickAndAppleViewController : UIViewController <UIAlertViewDelegate>



@property(nonatomic,retain) IBOutlet UIScrollView * scroll;
@property(nonatomic,retain) NSString * stringApple;
@property(nonatomic,retain) NSMutableDictionary * rgbForFlavour;
@property(nonatomic,assign) BOOL isLocked;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)Next:(UIButton*)sender;


@end
