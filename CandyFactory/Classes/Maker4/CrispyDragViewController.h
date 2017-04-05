//
//  CrispyDragViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/21/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrispyDragViewController : UIViewController
{
    BOOL isTouchinCup;
    int howMany;
    CGPoint _touchOffset;
    CGRect initial;
    BOOL once;
}

@property (nonatomic, retain) IBOutlet UIImageView *cup;
@property (nonatomic, retain) IBOutlet UIImageView *pan;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;

- (IBAction)Back:(id)sender;
- (IBAction)NextButtonPreseed:(id)sender;
- (IBAction)Reset:(id)sender;

@end
