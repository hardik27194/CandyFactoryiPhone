//
//  ChocolateBarsChooseFillingViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/17/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "ChocolateBarsChooseFillingViewController.h"
#import "ChocolateBarPourChocolateViewController.h"
#import "DecorateChocolateBarViewController.h"
#import "AppDelegate.h"


@implementation ChocolateBarsChooseFillingViewController

@synthesize scroll;
@synthesize flavourRGb;
@synthesize isLocked;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChocolateBarsChooseFillingViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChocolateBarsChooseFillingViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChocolateBarsChooseFillingViewController" bundle:[NSBundle mainBundle]];
    
    isLocked = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      
}
-(void)viewWillAppear:(BOOL)animated
{
    for (int i =0; i<12; i++) {
        UIButton * button = [[UIButton alloc]init];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if(i % 2 == 0)
                button.frame = CGRectMake(124, (i/2 )*200 +40, 198, 198);
            else button.frame = CGRectMake(446,  (i/2 )*200 +40, 198, 198);
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fillingIcon%d-iPad.png",i+1]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fillingIcon%d-iPad.png",i+1]] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fillingIcon%d-iPad.png",i+1]] forState:UIControlStateHighlighted];
        }
        else{
            if (i%2 ==0) {
                button.frame = CGRectMake(50, (i/2 )*90 +20, 84, 84);
            }
            else button.frame = CGRectMake(184,  (i/2 )*90 +20, 84, 84);
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fillingIcon%d.png",i+1]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fillingIcon%d.png",i+1]] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fillingIcon%d.png",i+1]] forState:UIControlStateHighlighted];
        }
        if(isLocked == NO)
        {
            if(i > 3)
            {
                UIImageView *lockImageView = [[UIImageView alloc] init];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    lockImageView.frame = CGRectMake(10, 10, 31, 40);
                    lockImageView.image = [UIImage imageNamed:@"lockStoreEverything-iPad.png"];
                    
                    //[button setEnabled:NO];
                }
                else
                {
                    lockImageView.frame = CGRectMake(10, 10, 31, 40);
                    lockImageView.image = [UIImage imageNamed:@"lockStoreEverything.png"];
                    
                    //[button setEnabled:NO];
                }
                [button addSubview:lockImageView];
            }
        }
        
        
        button.tag = i+1;
        [button addTarget:self action:@selector(Chocolatechoose:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:button];
        
    }
    scroll.contentSize = CGSizeMake(320, 600);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        StoreViewController *store = [[StoreViewController alloc] init];
        [self presentViewController:store animated:YES completion:nil];
    }
}

- (void)Chocolatechoose:(UIButton*)sender
{
    if (sender.tag > 4 && !isLocked) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the ChocolateBars pack? This feature will unlock all items and remove ads in ChocolateBars maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
        [alert show];
    }
    else
    {
        
   
    NSString *fillingName;
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
      if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  fillingName = [NSString stringWithFormat:@"filling%d-iPad.png",sender.tag];
    else fillingName = [NSString stringWithFormat:@"filling%d.png",sender.tag];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LayerChoosed" object:fillingName];
    
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlUp
     animations:^{
         [self.navigationController popViewControllerAnimated:NO];
     }
     completion:NULL];
         }

    
  
      
}

-(IBAction)BackButtonPressed:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [UIView
     transitionWithView:self.navigationController.view
     duration:1.0
     options:UIViewAnimationOptionTransitionCurlUp
     animations:^{
         [self.navigationController popViewControllerAnimated:NO];
     }
     completion:NULL];

    
}

@end
