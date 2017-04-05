//
//  CandyApplesChooseFlavourViewController1.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/11/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseStickViewController.h"

@interface CandyApplesChooseFlavourViewController1 : ChooseStickViewController <UIAlertViewDelegate>
{
    BOOL _isLocked;
  
}

@property (nonatomic,assign)   BOOL _isLocked;

@end
