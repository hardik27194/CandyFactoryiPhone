//
//  DecoratingCottonViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/16/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CandyAppleDecoratingViewController.h"

@interface DecoratingCottonViewController : CandyAppleDecoratingViewController
{
    IBOutlet UIImageView *youCanEatThis;
    IBOutlet UIView *bigView2;
}

@property (nonatomic,retain) IBOutlet UIView * allView;
@property (nonatomic,retain) IBOutlet UIImageView * vat1;
@property (nonatomic,retain) IBOutlet UIImageView * vat2;
@property (nonatomic,retain) IBOutlet UIImageView * vat3;
@property (nonatomic,retain) IBOutlet UIImageView * vat4;
@property (nonatomic,retain) NSMutableDictionary * rgbs;

- (IBAction)resetClick:(id)sender;
- (IBAction)undoClick:(id)sender;

@end
