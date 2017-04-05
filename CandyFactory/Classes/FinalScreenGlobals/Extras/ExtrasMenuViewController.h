//
//  ExtrasMenuViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/18/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtrasMenuViewController : UIViewController<UIAlertViewDelegate>
{
    BOOL isBought;
}

@property (nonatomic, retain) IBOutlet UIScrollView * scroll;
@property (nonatomic, assign) int choice;
@property (nonatomic, assign) BOOL _isBought;

- (IBAction)Back:(id)sender;

@end
