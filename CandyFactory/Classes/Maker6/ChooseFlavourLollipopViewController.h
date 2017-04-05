//
//  ChooseFlavourLollipopViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseFlavourLollipopViewController : UIViewController <UIAlertViewDelegate>
{
    NSMutableArray *flavourRGBS;
    
}
@property(nonatomic,assign) BOOL fromCore;
@property(nonatomic,assign) BOOL fromGelatin;
@property(nonatomic,assign) BOOL isLocked;
@property(nonatomic,retain) IBOutlet UIScrollView * scroll;
@property(nonatomic,retain) NSMutableDictionary * flavour;
@property(nonatomic,retain) NSString * stickName;
@property (nonatomic,retain) IBOutlet UIImageView * labeldown;
-(IBAction)BackButtonPressed:(id)sender;
@end
