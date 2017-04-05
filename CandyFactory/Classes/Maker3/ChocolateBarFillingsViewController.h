//
//  ChocolateBarFillingsViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/25/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChocolateBarFillingsViewController : UIViewController
@property (nonatomic,retain) IBOutlet UIImageView * filling1;
@property (nonatomic,retain) IBOutlet UIImageView * filling2;
@property (nonatomic,retain) IBOutlet UIImageView * filling3;
@property (nonatomic,retain) IBOutlet UIImageView * label;
@property (nonatomic,retain) IBOutlet UIButton * chooseButton;
@property (nonatomic,retain) IBOutlet UIButton * nextButton;
@property (nonatomic,retain) NSMutableDictionary * rgbFlavour;
-(IBAction)Back:(id)sender;
-(IBAction)Reset:(id)sender;
-(IBAction)ChooseLayers:(id)sender;
-(void)LayerChoosed:(NSNotification *)notif;
@end
