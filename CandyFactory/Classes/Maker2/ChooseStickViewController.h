//
//  ChooseStickViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/10/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseStickViewController : UIViewController<UIAlertViewDelegate>
{
    BOOL fromCandyAppleStiring;
    
}

@property(nonatomic,retain) IBOutlet UIScrollView *scroll;
@property(nonatomic,retain) NSMutableDictionary *rgbForFlavour;
@property(nonatomic,assign) BOOL fromLollipops;
@property(nonatomic,assign) BOOL isLocked;
@property(nonatomic) BOOL fromCandyAppleStiring;

-(IBAction)BackButtonPressed:(id)sender;

@end
