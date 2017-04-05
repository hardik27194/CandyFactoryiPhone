//
//  ChocolateBarsDragChocolateViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/10/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChocolateBarsDragChocolateViewController : UIViewController
{
     CGPoint _touchOffset;
    NSMutableArray * chocolateRGB;
}
@property (nonatomic,retain) IBOutlet UIImageView * chocolateBar;
@property (nonatomic,retain) IBOutlet UIButton *nextButton;
@property (nonatomic,retain) IBOutlet UIView *bottomView;
@property (nonatomic,assign) int chocolateNumber;

-(IBAction)BackButtonPressed:(id)sender;
-(IBAction)Next:(id)sender;
-(BOOL)checkIfIsInPot:(CGPoint)point;

@end
