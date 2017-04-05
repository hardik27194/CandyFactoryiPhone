//
//  GelatinChooseCutterViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/8/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GelatinChooseCutterViewController : UIViewController<UIAlertViewDelegate>
@property(nonatomic,retain) IBOutlet UIScrollView * scroll;
@property (nonatomic,retain) NSMutableDictionary * flavourRGB;
@property(nonatomic,assign) BOOL isLocked;
-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)Next:(id)sender;
@end
