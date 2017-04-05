//
//  SpiningVatViewController.h
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/20/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageFilter.h"

@interface SpiningVatViewController : UIViewController
{
    CGPoint _touchOffset;
    
    IBOutlet UIImageView *vata1;
    IBOutlet UIImageView *vata2;
    IBOutlet UIImageView *vata3;
    IBOutlet UIImageView *vata4;
    IBOutlet UIImageView *vata5;
    
    BOOL backPressed;
}

@property (nonatomic,retain) IBOutlet UIView * spining;
@property (nonatomic,retain) IBOutlet UIView * allview;
@property (nonatomic,retain) IBOutlet UIImageView *stick;
@property (nonatomic,retain) IBOutlet UIImageView * vat1;
@property (nonatomic,retain) IBOutlet UIImageView * vat2;
@property (nonatomic,retain) IBOutlet UIImageView * vat3;
@property (nonatomic,retain) IBOutlet UIImageView * vat4;
@property (nonatomic,retain) IBOutlet UIImageView *spin1;
@property (nonatomic,retain) IBOutlet UIImageView *spin2;
@property (nonatomic,retain) IBOutlet UIImageView *spin3;
@property (nonatomic,retain) IBOutlet UIImageView *spin4;
@property (nonatomic,retain) NSString * stickName;
@property (nonatomic,retain) NSMutableDictionary *rgbs;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL backPressed;

- (IBAction)resetClick:(id)sender;
- (IBAction)Back:(id)sender;

@end
