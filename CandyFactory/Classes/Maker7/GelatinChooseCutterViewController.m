//
//  GelatinChooseCutterViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/8/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "GelatinChooseCutterViewController.h"
#import "GelatinfinalViewController.h"
#import "GelatinDecoratingViewController.h"
#import "AppDelegate.h"

@implementation GelatinChooseCutterViewController
@synthesize scroll;
@synthesize flavourRGB;
@synthesize isLocked;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"GelatinChooseCutterViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"GelatinChooseCutterViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"GelatinChooseCutterViewController" bundle:[NSBundle mainBundle]];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    for (int i =0; i<18; i++) {
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width *i, 0, [UIScreen mainScreen].bounds.size.height, scroll.frame.size.height)];
        view.userInteractionEnabled = YES;
         if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
             UIImageView * apple = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"cutter%d.png",i+1]]];
             apple.frame = CGRectMake(0 , 40, 325, 309);
             apple.tag =i+1;
             UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickedView:)];
             tap.numberOfTapsRequired = 1;
             [apple addGestureRecognizer:tap];
             apple.userInteractionEnabled = YES;
             [view addSubview:apple];

         }
        else
        {
        UIImageView * apple = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"cutter%d-iPad.png",i+1]]];
        apple.frame = CGRectMake(0 , 40, 768, 730);
        apple.tag =i+1;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickedView:)];
        tap.numberOfTapsRequired = 1;
        [apple addGestureRecognizer:tap];
        apple.userInteractionEnabled = YES;
        [view addSubview:apple];
        }
        if (!isLocked && i>3) {
           // view.userInteractionEnabled = NO;
            UIImageView * lock = [[UIImageView alloc]init];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                lock.image = [UIImage imageNamed:@"lockFullSize~ipad.png"];
                lock.frame = CGRectMake(0, 0, lock.image.size.width, lock.image.size.height);
                lock.center = [view center];
            }
            else
            {
                   lock.image = [UIImage imageNamed:@"lockFullSize.png"];
                lock.frame = CGRectMake(50, 50, lock.image.size.width, lock.image.size.height);
//                lock.center = [view center];
            }
            [view addSubview:lock];
        }
        
        [scroll addSubview:view];
        
    }
    scroll.contentSize = CGSizeMake(18*[UIScreen mainScreen].bounds.size.width,scroll.frame.size.height);
    scroll.userInteractionEnabled = YES;
    [self.scroll setContentOffset: CGPointMake(scroll.contentSize.width - 10*scroll.frame.size.width, 0) animated:NO];
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.scroll.contentOffset = CGPointMake(0, 0);
     } completion:^ (BOOL completed)
     {
         
     }];

    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)BackButtonPressed:(id)sender
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
   // [self.navigationController popViewControllerAnimated:NO];
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

-(void)ClickedView:(UITapGestureRecognizer *)tap
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    NSString * treat;
    
     if (!isLocked && tap.view.tag>4)
     {
         
         UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the Gelatin pack? This feature will unlock all items and remove ads in Gelatin maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
         [alert show];
     }
    else
    {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                treat = [NSString stringWithFormat:@"treat%.0f~ipad.png",self.scroll.contentOffset.x/768+1];
            }
            else
            {
                treat = [NSString stringWithFormat:@"treat%.0f.png",self.scroll.contentOffset.x/320+1];
            }
            
            GelatinDecoratingViewController *final = [[GelatinDecoratingViewController alloc] init];
            final.treatName = treat;
            final.flavourRGB = flavourRGB;
            [self.navigationController pushViewController:final animated:YES];
    }

}
-(IBAction)Next:(id)sender
{
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
  

    NSString * treat;
   
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
          treat = [NSString stringWithFormat:@"treat%.0f~ipad.png",self.scroll.contentOffset.x/768+1];
     }
    else
    {
         treat = [NSString stringWithFormat:@"treat%.0f.png",self.scroll.contentOffset.x/320+1];
    }

    int a =  self.scroll.contentOffset.x/320+1;
    
     if(!isLocked && a > 4)
     {
         UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the Gelatin pack? This feature will unlock all items and remove ads in Gelatin maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
         [alert show];
     }
    else
    {
        GelatinDecoratingViewController *final = [[GelatinDecoratingViewController alloc] init];
        final.treatName = treat;
        final.flavourRGB = flavourRGB;
        [self.navigationController pushViewController:final animated:YES];
    }
}

@end
