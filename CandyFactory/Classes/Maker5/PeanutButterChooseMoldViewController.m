//
//  PeanutButterChooseMoldViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/3/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "PeanutButterChooseMoldViewController.h"
#import "PutInPotViewController.h"
#import "AppDelegate.h"

@implementation PeanutButterChooseMoldViewController

@synthesize scroll;
@synthesize isLocked;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"PeanutButterChooseMoldViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"PeanutButterChooseMoldViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"PeanutButterChooseMoldViewController" bundle:[NSBundle mainBundle]];
    
    isLocked = NO;
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    for (int i =0; i<18; i++) {
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width *i, 0, [UIScreen mainScreen].bounds.size.height, scroll.frame.size.height)];
        UIImageView * apple;
        UIButton *selectButton;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             apple = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"mold%d-iPad.png",i+1]]];
              apple.frame = CGRectMake(0 , 40, 768, 700);
            selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 768, 600)];
            selectButton.center = apple.center;
            selectButton.backgroundColor = [UIColor clearColor];
            selectButton.tag = i;
            [selectButton addTarget:self action:@selector(NextFromApple:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
             apple = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"mold%d.png",i+1]]];
             apple.frame = CGRectMake(0 , 40, 325, 309);
            selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            selectButton.center = apple.center;
            selectButton.backgroundColor = [UIColor clearColor];
            selectButton.tag = i;
            [selectButton addTarget:self action:@selector(NextFromApple:) forControlEvents:UIControlEventTouchUpInside];
        }
       
        
        if(isLocked == NO)
        {
            if(i > 4)
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
                    
                  //  [selectButton setEnabled:NO];
                }
                [selectButton addSubview:lockImageView];
            }
        }
        

        [view addSubview:apple];
        [view addSubview:selectButton];
        
        
        [scroll addSubview:view];
        
    }
    scroll.contentSize = CGSizeMake(18*[UIScreen mainScreen].bounds.size.width,scroll.frame.size.height);
    [self.scroll setContentOffset: CGPointMake(scroll.contentSize.width - scroll.frame.size.width, 0) animated:NO];
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
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

-(IBAction)Next:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    NSString * treat;
    treat = [NSString stringWithFormat:@"treat%.0fi.png",self.scroll.contentOffset.x/320+1];
    int a;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) a =  self.scroll.contentOffset.x/768+1;
    else  a =  self.scroll.contentOffset.x/320+1;
    
    if (a>5 && !isLocked) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the PeanutButterCups pack? This feature will unlock all items and remove ads in PeanutButterCups maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
        [alert show];
    }
    else
    {

    PutInPotViewController * chooseStick2;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        chooseStick2 = [[PutInPotViewController alloc] init];
        chooseStick2.moldName = [NSString stringWithFormat:@"mold%.0f-iPad",self.scroll.contentOffset.x/768+1];
        chooseStick2.moldMask = [NSString stringWithFormat:@"mask%.0f~ipad",self.scroll.contentOffset.x/768+1];
    }
    else
    {
        chooseStick2 = [[PutInPotViewController alloc] init];
        chooseStick2.moldName = [NSString stringWithFormat:@"mold%.0f",self.scroll.contentOffset.x/320+1];
        chooseStick2.moldMask = [NSString stringWithFormat:@"mask%.0f",self.scroll.contentOffset.x/320+1];
    }
    [self.navigationController pushViewController:chooseStick2 animated:YES];
    }
}

- (IBAction)NextFromApple:(UIButton*)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];

    if (sender.tag > 4 && !isLocked) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the PeanutButterCups pack? This feature will unlock all items and remove ads in PeanutButterCups maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
        [alert show];
    }
    else
    {
        PutInPotViewController * chooseStick2;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            chooseStick2 = [[PutInPotViewController alloc] init];
            chooseStick2.moldName = [NSString stringWithFormat:@"mold%d-iPad",sender.tag+1];
            chooseStick2.moldMask = [NSString stringWithFormat:@"mask%d~ipad",sender.tag+1];
        }
        else
        {
            chooseStick2 = [[PutInPotViewController alloc] init];
            chooseStick2.moldName = [NSString stringWithFormat:@"mold%d",sender.tag+1];
            chooseStick2.moldMask = [NSString stringWithFormat:@"mask%d",sender.tag+1];
        }
        [self.navigationController pushViewController:chooseStick2 animated:YES];
    }
}



@end
