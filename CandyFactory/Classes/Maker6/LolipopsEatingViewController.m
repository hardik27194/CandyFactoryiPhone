//
//  LolipopsEatingViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 1/7/13.
//  Copyright (c) 2013 Ana-Maria Stoica. All rights reserved.
//

#import "LolipopsEatingViewController.h"
#import "AppDelegate.h"
#import "Defines.h"

@implementation LolipopsEatingViewController

@synthesize stick;
@synthesize stickName;
@synthesize something;
@synthesize backImage;
@synthesize backgroundImage;

- (id)init
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self = [super initWithNibName:@"LolipopsEatingViewController-iPad" bundle:[NSBundle mainBundle]];
    else if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"LolipopsEatingViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super initWithNibName:@"LolipopsEatingViewController" bundle:[NSBundle mainBundle]];
    
    biteNumber = 0;
    self.isSaved = NO;
    self.isSavedOnFridge = NO;
    
    return self;
}

-(void)viewDidLoad
{
      [Flurry logEvent:@"Lollipop_Created"];
   

}
- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    
        if (bite) {
            [bite stop];
            bite = nil;
        }
    
    BOOL hasSounds = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).hasSounds;
    
    if(hasSounds == YES)
    {
        NSURL *soundPath10= nil;
        soundPath10 = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ChompFood2_CF" ofType:@"mp3"]];
        bite = [[AVAudioPlayer alloc]initWithContentsOfURL:soundPath10 error:NULL];
        bite.volume = 6.0;
        [bite setDelegate:nil];
        [bite prepareToPlay];
        [bite play];
    }
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    float xPoint = touchPoint.x;
    float yPoint = touchPoint.y;
    
   
    UIImageView *campFireView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    campFireView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"stars1.png"],[UIImage imageNamed:@"stars2.png"],[UIImage imageNamed:@"stars3.png"],[UIImage imageNamed:@"stars4.png"],[UIImage imageNamed:@"stars5.png"],[UIImage imageNamed:@"stars6.png"], nil];
    campFireView.animationDuration = 0.5;
    campFireView.animationRepeatCount = 0;
    [campFireView startAnimating];
    campFireView.center = CGPointMake(xPoint, yPoint);
    [self.view addSubview:campFireView];
    [NSTimer scheduledTimerWithTimeInterval:0.7 target:campFireView selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
    
    number++;
    UIImageView *newImage;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        newImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    else if([UIScreen mainScreen].bounds.size.height == 568)
        newImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    else
        newImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    newImage.image = self.backImage;
    UIImage *_maskingImage;
    
    NSString *biteName;
    if (biteNumber == 3) {
        biteNumber = 0;
    }
    if (biteNumber ==0) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)biteName = [NSString stringWithFormat:@"biteMask-iPad"];
        else biteName = [NSString stringWithFormat:@"biteMask"];
        
    }
    else
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)biteName = [NSString stringWithFormat:@"biteMask%d-iPad",biteNumber+1];
        else biteName = [NSString stringWithFormat:@"biteMask%d",biteNumber+1];
    }
    biteNumber ++;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        _maskingImage = [UIImage imageNamed:biteName];
    else
        _maskingImage = [UIImage imageNamed:biteName];
    
    
    CALayer *_maskingLayer = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        _maskingLayer.frame = CGRectMake(xPoint-75, yPoint-75, 150, 150);
    else
        _maskingLayer.frame = CGRectMake(xPoint-30, yPoint-30, 60, 60);
    
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [newImage.layer setMask:_maskingLayer];
    [self.fullImage addSubview:newImage];
   
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    if(actionSheet.tag == 17)
    {
        if (buttonIndex == 0)
        {
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                NSString *shareText = FACEBOOK_TEXT;
                [mySLComposerSheet setInitialText:shareText];
                [mySLComposerSheet addImage:backgroundImage];
                [mySLComposerSheet addURL:[NSURL URLWithString:ITUNES_LINK]];
                
                [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result)
                 {
                     switch(result)
                     {
                         case SLComposeViewControllerResultCancelled:
                             NSLog(@"Post Canceled");
                             break;
                         case SLComposeViewControllerResultDone:
                             NSLog(@"Post Sucessful");
                             break;
                         default:
                             break;
                     }
                 }];
                
                [self presentViewController:mySLComposerSheet animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please log in on Facebook before using this feature" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }
        else if(buttonIndex == 1)
        {
            [self shareToEmail:nil];
        }
    }
    else if(actionSheet.tag == 16)
    {
        if(buttonIndex == 0)
        {
            [self saveToGallery:nil];
        }
        else if (buttonIndex == 1)
        {
            [self saveToPhotos:nil];
        }
    }
}

- (void) saveToGallery:(NSTimer *) theTimer
{
    self.isSaved = YES;
    if (self.isSavedOnFridge) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Already Saved" message:@"You already saved this candy! Enjoy it from the fridge!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        
        self.isSavedOnFridge = YES;
    NSUserDefaults * standard = [NSUserDefaults standardUserDefaults];
    NSMutableArray * array ;
    if ([standard objectForKey:@"savedCandy"]) {
        array =[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCandy"]];
    }
    if (array ) {
        
        if ([array count] >0) {
            
            
            
        }
        
    }
    else
    {
        array = [[NSMutableArray alloc]init];
    }
    
    NSString * nameOfCandy = [NSString stringWithFormat:@"lollipop%d",[array count]];
    NSString * CandyBackImage = [NSString stringWithFormat:@"lollipopBack%d",[array count]];
    NSString * maskImage2 = [NSString stringWithFormat:@"lollipopMask%d",[array count]];
    NSMutableDictionary * newCandy = [[NSMutableDictionary alloc]init];
    [newCandy setObject:@"6" forKey:@"type"];
    [newCandy setObject:nameOfCandy forKey:@"picName"];
    [newCandy setObject:CandyBackImage forKey:@"backImage"];
    [newCandy setObject:maskImage2 forKey:@"mask"];
    
    NSData *imageData = UIImagePNGRepresentation(self.transparetImage);
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",nameOfCandy]];
    [imageData writeToFile:imagePath atomically:YES];
    
    
    NSData *imageData2 = UIImagePNGRepresentation(backgroundImage);
    NSString *imagePath2 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",CandyBackImage]];
    [imageData2 writeToFile:imagePath2 atomically:YES];
    
    NSData *imageData3 = UIImagePNGRepresentation(backImage);
    NSString *imagePath3 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",maskImage2]];
    [imageData3 writeToFile:imagePath3 atomically:YES];
    
    
    
    
    [array addObject:newCandy];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [standard setObject:data forKey:@"savedCandy"];
    [standard synchronize];
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"The Candy Is Saved! You can find it in the fridge!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    [Flurry logEvent:@"Saved_To_Gallery"];
    }
    
}

- (void) saveToPhotos:(NSTimer *) theTimer; {
    self.isSaved = YES;
    UIImageWriteToSavedPhotosAlbum(backgroundImage, nil, nil, nil);
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"The Candy Is Saved! You can find it in the Photos App!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [Flurry logEvent:@"Saved_To_Photos"];
}
- (IBAction)Save:(id)sender
{
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Save Your Candy" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save to Fridge", @"Save to Photos", nil];
    actionSheet.tag = 16;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet showInView:self.view];
    
}


- (void)shareToEmail:(NSTimer*)theTimer
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:EMAIL_SUBJECT];
        
        
        NSData *imageData = UIImagePNGRepresentation(backgroundImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"Slushie"];
        NSString *emailBody = EMAIL_MESSAGE;
        [mailer setMessageBody:emailBody isHTML:YES];
        
        [self presentViewController:mailer animated:YES completion:nil];
        
        //[Flurry logEvent:@"Shared_With_Email"];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support this feature."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)viewWillAppear:(BOOL)animated
{
    self.fullImage.image = backgroundImage;
    
        if (eatingScreen) {
            [eatingScreen stop];
            eatingScreen = nil;
        }
    
    BOOL hasSounds = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).hasSounds;
    
    if(hasSounds == YES)
    {
        NSURL *soundPath2 = nil;
        soundPath2 = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CompleteMusic3_CF(2)" ofType:@"mp3"]];
        eatingScreen = [[AVAudioPlayer alloc]initWithContentsOfURL:soundPath2 error:NULL];
        
        eatingScreen.volume = 6.0;
        [eatingScreen setDelegate:nil];
        [eatingScreen prepareToPlay];
        [eatingScreen play];
    }
   
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] lollipopsPurchased] || [(AppDelegate *)[[UIApplication sharedApplication] delegate] everythingPurchased] ) {
        
    }
    else{
        if (!self.fromFridge) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] showFullScreenAd];
        }
    }

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.confetti = [[SFSConfettiScreen alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    }
    else
    {
        self.confetti = [[SFSConfettiScreen alloc]initWithFrame:CGRectMake(0, 0, 320, 437)];
    }
    
    [self.view addSubview:self.confetti];
    [self.confetti decayOverTime:2.5];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
//
//-(IBAction)Home:(id)sender
//{
//    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
-(IBAction)Back:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
