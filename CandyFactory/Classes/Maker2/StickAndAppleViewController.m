//
//  StickAndAppleViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/18/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "StickAndAppleViewController.h"
#import "DigAppleViewController.h"
#import "AppDelegate.h"

@implementation StickAndAppleViewController
@synthesize scroll;
@synthesize stringApple;
@synthesize rgbForFlavour;
@synthesize isLocked;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"StickAndAppleViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"StickAndAppleViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"StickAndAppleViewController" bundle:[NSBundle mainBundle]];
    
    isLocked = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    for (int i = 0; i < 5; i++)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width *i, 0, [UIScreen mainScreen].bounds.size.height, scroll.frame.size.height)];
        UIImageView *apple;
        UIButton *selectButton;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            apple = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"apple%d~ipad.png",i+1]]];
            apple.frame = CGRectMake(scroll.frame.size.width/2 - 221 , 520, 443, 379);
            
            selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
            selectButton.center = apple.center;
            selectButton.backgroundColor = [UIColor clearColor];
            selectButton.tag = i;
            [selectButton addTarget:self action:@selector(NextFromApple:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            apple = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"apple%d.png",i+1]]];
            apple.frame = CGRectMake(scroll.frame.size.width/2 - 93 , (scroll.frame.size.height - 380)/2+210, 187, 160);
            
            selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            selectButton.center = apple.center;
            selectButton.backgroundColor = [UIColor clearColor];
            selectButton.tag = i;
            [selectButton addTarget:self action:@selector(NextFromApple:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        if(isLocked == NO)
        {
            if(i > 0)
            {
                UIImageView *lockImageView = [[UIImageView alloc] init];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    lockImageView.frame = CGRectMake(10, 10, 251, 315);
                    lockImageView.image = [UIImage imageNamed:@"lockFullSize~ipad.png"];
                    
                   // [selectButton setEnabled:NO];
                }
                else
                {
                    lockImageView.frame = CGRectMake(0, -20, 106, 133);
                    lockImageView.image = [UIImage imageNamed:@"lockFullSize.png"];
                    
                   // [selectButton setEnabled:NO];
                }
                [selectButton addSubview:lockImageView];
            }
        }

        [view addSubview:apple];
        [view addSubview:selectButton];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:stringApple]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
          imageView.frame = CGRectMake(scroll.frame.size.width/2 - 39, 20, 78, 520);
        }
        else
        {
             imageView.frame = CGRectMake(scroll.frame.size.width/2 - 16 , (scroll.frame.size.height - 380)/2, 33, 220);
        }
        [view addSubview:imageView];

        [scroll addSubview:view];
        
    }
    scroll.contentSize = CGSizeMake(5*[UIScreen mainScreen].bounds.size.width,scroll.frame.size.height);
    [self.scroll setContentOffset: CGPointMake(scroll.contentSize.width - scroll.frame.size.width, 0) animated:NO];
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.scroll.contentOffset = CGPointMake(0, 0);
     } completion:^ (BOOL completed)
     {
         
     }];
}

- (void)Chocolatechoose:(UIButton*)sender
{
       
}

- (IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        StoreViewController *store = [[StoreViewController alloc] init];
        [self presentViewController:store animated:YES completion:nil];
    }
}

- (IBAction)Next:(id)sender
{
   [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    DigAppleViewController *digg;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (self.scroll.contentOffset.x/768+1 >1 && !isLocked) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the CandyApples pack? This feature will unlock all items and remove ads in CandyApples maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
            [alert show];
        }
        else
        {
        digg = [[DigAppleViewController alloc]initWithNibName:@"DigAppleViewController-iPad" bundle:nil];
        digg.appleName = [NSString stringWithFormat:@"apple%.0f~ipad.png",self.scroll.contentOffset.x/768+1];
        digg.stickName = stringApple;
        digg.rgbForFlavour = self.rgbForFlavour;
        [self.navigationController pushViewController:digg animated:YES];
        }
    }
    else
    {
        if (self.scroll.contentOffset.x/320+1 >1  && !isLocked) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the CandyApples pack? This feature will unlock all items and remove ads in CandyApples maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
            [alert show];
        }
        else
        {
         digg = [[DigAppleViewController alloc] init];
         digg.appleName = [NSString stringWithFormat:@"apple%.0f.png",self.scroll.contentOffset.x/320+1];
         digg.stickName = stringApple;
        digg.rgbForFlavour = self.rgbForFlavour;
        [self.navigationController pushViewController:digg animated:YES];
        }
    }
   
    
}

- (IBAction)NextFromApple:(UIButton*)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    DigAppleViewController *digg;
    if (sender.tag > 0 && isLocked == NO) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the CandyApples pack? This feature will unlock all items and remove ads in CandyApples maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
        [alert show];
    }
    else
    {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        digg = [[DigAppleViewController alloc]initWithNibName:@"DigAppleViewController-iPad" bundle:nil];
        digg.appleName = [NSString stringWithFormat:@"apple%d~ipad.png", sender.tag + 1];
        digg.stickName = stringApple;
    }
    else
    {
        digg = [[DigAppleViewController alloc] init];
        digg.appleName = [NSString stringWithFormat:@"apple%d.png", sender.tag + 1];
        digg.stickName = stringApple;
    }
    
    digg.rgbForFlavour = self.rgbForFlavour;
    [self.navigationController pushViewController:digg animated:YES];
    }
}

@end
