//
//  ChooseFlavourLollipopViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/19/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "ChooseFlavourLollipopViewController.h"
#import "LollipopsViewController.h"
#import "LolipopsEatingViewController.h"
#import "GelatinSugarViewController.h"
#import "LollipopDecoratingViewController.h"
#import "DipLollipopViewController.h"
#import "AppDelegate.h"

@implementation ChooseFlavourLollipopViewController

@synthesize scroll;
@synthesize fromCore;
@synthesize fromGelatin;
@synthesize flavour;
@synthesize stickName;
@synthesize isLocked;
@synthesize labeldown;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"ChooseFlavourLollipopViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"ChooseFlavourLollipopViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"ChooseFlavourLollipopViewController" bundle:[NSBundle mainBundle]];
    
    fromCore = NO;
    fromGelatin = NO;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    flavourRGBS = [[NSMutableArray alloc]init];
    
    for (int i =0; i<30; i++) {
        NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
        switch (i) {
            case 0:
                [dictionary setObject:[NSNumber numberWithInt:199] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:3] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:3] forKey:@"blue"];
                break;
            case 1:
                [dictionary setObject:[NSNumber numberWithInt:3] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:68] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:199] forKey:@"blue"];
                break;
            case 2:
                [dictionary setObject:[NSNumber numberWithInt:3] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:199] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:3] forKey:@"blue"];
                break;
            case 3:
                [dictionary setObject:[NSNumber numberWithInt:187] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:199] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:35] forKey:@"blue"];
                break;
            case 4:
                [dictionary setObject:[NSNumber numberWithInt:239] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:69] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:41] forKey:@"blue"];
                break;
            case 5:
                [dictionary setObject:[NSNumber numberWithInt:239] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:227] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:41] forKey:@"blue"];
                break;
            case 6:
                [dictionary setObject:[NSNumber numberWithInt:1] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:35] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:131] forKey:@"blue"];
                break;
            case 7:
                [dictionary setObject:[NSNumber numberWithInt:223] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:83] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:6] forKey:@"blue"];
                break;
            case 8:
                [dictionary setObject:[NSNumber numberWithInt:172] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:9] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:232] forKey:@"blue"];
                break;
            case 9:
                [dictionary setObject:[NSNumber numberWithInt:245] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:237] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:199] forKey:@"blue"];
                break;
            case 10:
                [dictionary setObject:[NSNumber numberWithInt:89] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:51] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:20] forKey:@"blue"];
                break;
            case 11:
                [dictionary setObject:[NSNumber numberWithInt:38] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:14] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:0] forKey:@"blue"];
                break;
            case 12:
                [dictionary setObject:[NSNumber numberWithInt:39] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:97] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:8] forKey:@"blue"];
                break;
            case 13:
                [dictionary setObject:[NSNumber numberWithInt:37] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:8] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:97] forKey:@"blue"];
                break;
            case 14:
                [dictionary setObject:[NSNumber numberWithInt:188] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:1] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:133] forKey:@"blue"];
                break;
            case 15:
                [dictionary setObject:[NSNumber numberWithInt:110] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:1] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:203] forKey:@"blue"];
                break;
            case 16:
                [dictionary setObject:[NSNumber numberWithInt:1] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:96] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:203] forKey:@"blue"];
                break;
            case 17:
                [dictionary setObject:[NSNumber numberWithInt:19] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:210] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:244] forKey:@"blue"];
                break;
            case 18:
                [dictionary setObject:[NSNumber numberWithInt:244] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:19] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:99] forKey:@"blue"];
                break;
            case 19:
                [dictionary setObject:[NSNumber numberWithInt:254] forKey:@"red"];
                [dictionary setObject:[NSNumber numberWithInt:169] forKey:@"green"];
                [dictionary setObject:[NSNumber numberWithInt:199] forKey:@"blue"];
                break;
                           
                
                
                
                
                
                
            default:
                break;
        }
        
        [flavourRGBS addObject:dictionary];
    }

    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    if (!fromCore) {
        for (int i =0; i<20; i++) {
            UIButton * button = [[UIButton alloc]init];
            
            
            if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
                if (i%2 ==0) {
                    button.frame = CGRectMake(50, (i/2 )*90 +20, 84, 84);
                }
                else button.frame = CGRectMake(184,  (i/2 )*90 +20, 84, 84);
                
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flvMenu%d.png",i+1]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flvMenu%d.png",i+1]] forState:UIControlStateSelected];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flvMenu%d.png",i+1]] forState:UIControlStateHighlighted];
            }
            else
            {
                if (i%2 ==0) {
                    button.frame = CGRectMake(126, (i/2 )*200 +20, 195, 196);
                }
                else button.frame = CGRectMake(447,  (i/2 )*200 +20, 195, 196);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flvMenu%d-iPad.png",i+1]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flvMenu%d-iPad.png",i+1]] forState:UIControlStateSelected];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"flvMenu%d-iPad.png",i+1]] forState:UIControlStateHighlighted];
            }
            
            if(!isLocked )
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
                        
                       // [button setEnabled:NO];
                    }
                    [button addSubview:lockImageView];
                }
            }

            
            button.tag = i+1;
            [button addTarget:self action:@selector(Chocolatechoose:) forControlEvents:UIControlEventTouchUpInside];
            [scroll addSubview:button];
            
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad   ) {
            scroll.contentSize = CGSizeMake(320,2200);
        }
        else scroll.contentSize = CGSizeMake(320,1000);
    }
    else
    {
        for (int i =0; i<30; i++) {
            UIButton * button = [[UIButton alloc]init];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                if (i%2 ==0) {
                    button.frame = CGRectMake(126, (i/2 )*200 +20, 195, 196);
                }
                else button.frame = CGRectMake(447,  (i/2 )*200 +20, 195, 196);
                
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"core%d~ipad.png",i+1]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"core%d~ipad.png",i+1]] forState:UIControlStateSelected];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"core%d~ipad.png",i+1]] forState:UIControlStateHighlighted];
                labeldown.image = [UIImage imageNamed:@"chooseAcore~ipad.png"];
                
            }
            else
            {
                
           
            
            if (i%2 ==0) {
                button.frame = CGRectMake(50, (i/2 )*90 +20, 84, 84);
            }
            else button.frame = CGRectMake(184,  (i/2 )*90 +20, 84, 84);
            
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"core%d.png",i+1]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"core%d.png",i+1]] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"core%d.png",i+1]] forState:UIControlStateHighlighted];
                
                labeldown.image = [UIImage imageNamed:@"chooseAcore.png"];
                
                 }
            
            if(!isLocked )
            {
                if(i > 3)
                {
                    UIImageView *lockImageView = [[UIImageView alloc] init];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    {
                        lockImageView.frame = CGRectMake(10, 10, 31, 40);
                        lockImageView.image = [UIImage imageNamed:@"lockStoreEverything-iPad.png"];
                        
                       // [button setEnabled:NO];
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
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad   ) {
            scroll.contentSize = CGSizeMake(320,3300);
        }
        else scroll.contentSize = CGSizeMake(320,1400);
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        StoreViewController *store = [[StoreViewController alloc] init];
        [self presentViewController:store animated:YES completion:nil];
    }
}

-(void)Chocolatechoose:(UIButton*)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
  
    if (!fromCore && !fromGelatin) {
        if (sender.tag >4 && !isLocked) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the Lollipops pack? This feature will unlock all items and remove ads in Lollipops maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
            [alert show];
        }
        else
        {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
            [dict  setObject:[UIImage imageNamed:[NSString stringWithFormat:@"flv%d.png",sender.tag]] forKey:@"flavourImage"];
            [dict  setObject:[flavourRGBS objectAtIndex:sender.tag -1] forKey:@"flavourRGB"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"FlavourChoosed" object:dict];
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
    else if(fromCore && !fromGelatin)
    {
        
        if (sender.tag >4 && !isLocked) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the Lollipops pack? This feature will unlock all items and remove ads in Lollipops maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
            [alert show];
        }
        else
        {
            DipLollipopViewController *digg = [[DipLollipopViewController alloc] init];
            digg.stickImage = self.stickName;
            digg.coreImage  = [NSString stringWithFormat:@"core%d.png",sender.tag];
            digg.coatingImage =[NSString stringWithFormat:@"coating%d.png",sender.tag];
            digg.flavourRGB = flavour;
            [self.navigationController pushViewController:digg animated:YES];
        }
    }
    else if (fromGelatin && !fromCore)
    {
        if (sender.tag >4 && !isLocked) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"This item is locked. Would you like to buy the Gelatin pack? This feature will unlock all items and remove ads in Gelatin maker!" delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
            [alert show];
        }
        else
        {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict  setObject:[UIImage imageNamed:[NSString stringWithFormat:@"flv%d.png",sender.tag]] forKey:@"flavourImage"];
        [dict setObject:[flavourRGBS objectAtIndex:sender.tag -1] forKey:@"flavourRGB"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"FlavourChoosed" object:dict];
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
   
    
    
    
}

-(IBAction)BackButtonPressed:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    UINavigationController * navController = self.navigationController;
    [navController popViewControllerAnimated:YES];
    if (fromCore) {
        UINavigationController * navController = self.navigationController;
        [navController popViewControllerAnimated:NO];
        [navController popViewControllerAnimated:NO];
        [navController popViewControllerAnimated:NO];
    }
   
    
}

@end
