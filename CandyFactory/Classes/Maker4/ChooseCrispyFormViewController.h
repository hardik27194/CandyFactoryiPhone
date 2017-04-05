//
//  ChooseCrispyFormViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/21/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCrispyFormViewController : UIViewController<UIAlertViewDelegate>
{
}

@property (nonatomic, retain) IBOutlet UIScrollView *scroll;
@property (nonatomic, assign) BOOL isLocked;

- (IBAction)BackButtonPressed:(id)sender;
- (IBAction)Next:(id)sender;

@end
