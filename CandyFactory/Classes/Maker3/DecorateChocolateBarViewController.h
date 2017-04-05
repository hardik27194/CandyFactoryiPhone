//
//  DecorateChocolateBarViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/16/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CandyAppleDecoratingViewController.h"

@interface DecorateChocolateBarViewController : CandyAppleDecoratingViewController
{
    BOOL firstAppear;
}
@property (nonatomic,retain) NSMutableDictionary * flavourRGB;
@property (nonatomic,retain) IBOutlet UIImageView * chocolateBar;
@property (nonatomic,retain) IBOutlet UIImageView *wrap;
-(IBAction)Wrapps:(id)sender;
@end
