//
//  GelatinDecoratingViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/21/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CandyAppleDecoratingViewController.h"
@interface GelatinDecoratingViewController : CandyAppleDecoratingViewController
@property (nonatomic,retain) NSString * treatName;
@property (nonatomic,retain) NSMutableDictionary * flavourRGB;
-(IBAction)NewBack:(id)sender;
@end
