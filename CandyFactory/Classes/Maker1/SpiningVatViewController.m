//
//  SpiningVatViewController.m
//  CandyFactory
//
//  Created by Ana-Maria Stoica on 12/20/12.
//  Copyright (c) 2012 Ana-Maria Stoica. All rights reserved.
//

#import "SpiningVatViewController.h"
#import "CottonCandyEatingViewController.h"
#import "DecoratingCottonViewController.h"
#import "AppDelegate.h"
#import "ChooseSugarCottonViewController.h"

@interface SpiningVatViewController ()
{
    BOOL once;
    
}
@end

@implementation SpiningVatViewController

@synthesize spining;
@synthesize stick;
@synthesize timer;
@synthesize vat1;
@synthesize vat2;
@synthesize vat3;
@synthesize vat4;
@synthesize spin1;
@synthesize spin2;
@synthesize spin3;
@synthesize spin4;
@synthesize allview;
@synthesize stickName;
@synthesize rgbs;
@synthesize backPressed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        once = YES;
        backPressed = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        stick.transform =  CGAffineTransformRotate(stick.transform,-0.5*M_PI/3);
    else
        stick.transform =  CGAffineTransformRotate(stick.transform,-0.5*M_PI/4);
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.allview.frame = CGRectMake(touchPoint.x - 250, touchPoint.y - 350, 354, 378);
    else
         self.allview.frame = CGRectMake(touchPoint.x - 180, touchPoint.y - 280, 253, 288);
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.allview.frame = CGRectMake(touchPoint.x - 250, touchPoint.y - 350, 354, 378);
    else
        self.allview.frame = CGRectMake(touchPoint.x - 180, touchPoint.y - 280, 253, 288);
    
    if(once == YES)
    {        
        if((touchPoint.x > spining.frame.origin.x )&& (touchPoint.x < spining.frame.origin.x+spining.frame.size.width))
        {
            if((touchPoint.y > spining.frame.origin.y) && (touchPoint.y < spining.frame.origin.y+spining.frame.size.height))
            {                
                if (vat4.alpha < 1.0)
                {
                    vat4.alpha += 0.01;
                }
                else if(vat3.alpha < 1.0)
                {
                    vat3.alpha += 0.01;
                }
                else if(vat2.alpha < 1.0)
                {
                    vat2.alpha += 0.01;
                }
                else if(vat1.alpha < 1.0)
                {
                    vat1.alpha += 0.01;
                }
                else
                {
                    once = NO;
                    if([timer isValid])
                    {
                        [timer invalidate];
                    }
                    //allview.userInteractionEnabled = NO;
                    [self performSelector:@selector(NextPage:) withObject:nil afterDelay:0.2];
                }
            }
        }
    }
}


- (UIImage*)imageWithImage:(UIImage*) source rotatedByHue:(NSMutableDictionary *) rgb;
{
//    UIColor * color = [UIColor colorWithRed:[[rgb objectForKey:@"red"] floatValue]/255.0 green:[[rgb objectForKey:@"green"] floatValue]/255.0 blue:[[rgb objectForKey:@"blue"] floatValue]/255.0 alpha:0.5f];
//    UIGraphicsBeginImageContext(source.size);
//    
//    // get a reference to that context we created
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // set the fill color
//    [color setFill];
//    
//    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
//    CGContextTranslateCTM(context, 0, source.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    
//    // set the blend mode to color burn, and the original image
//    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
//    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
//    CGContextDrawImage(context, rect, source.CGImage);
//    
//    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
//    CGContextClipToMask(context, rect, source.CGImage);
//    CGContextAddRect(context, rect);
//    CGContextDrawPath(context,kCGPathFill);
//    
//    // generate a new UIImage from the graphics context we drew onto
//    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return coloredImg;

    // Create a Core Image version of the image.
    UIColor * color = [UIColor colorWithRed:[[rgb objectForKey:@"red"] floatValue]/255.0 green:[[rgb objectForKey:@"green"] floatValue]/255.0 blue:[[rgb objectForKey:@"blue"] floatValue]/255.0 alpha:1.0f];
    CGImageRef maskImage = source.CGImage;
    CGFloat width = source.size.width;
    CGFloat height = source.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, maskImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(bitmapContext);
    CGContextRelease(bitmapContext);
    
    UIImage *result = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    return result;
//    CIImage *sourceCore = [CIImage imageWithCGImage:[source CGImage]];
//    
//    // Apply a CIHueAdjust filter
//    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIColorMonochrome"];
//    [hueAdjust setDefaults];
//    [hueAdjust setValue:[NSNumber numberWithFloat:0.7] forKey:@"inputIntensity"];
//    
//    [hueAdjust setValue: sourceCore forKey: @"inputImage"];
//    [hueAdjust setValue: [[CIColor alloc]initWithColor:[UIColor colorWithRed:[[rgb objectForKey:@"red"] floatValue]/255.0 green:[[rgb objectForKey:@"green"] floatValue]/255.0 blue:[[rgb objectForKey:@"blue"] floatValue]/255.0 alpha:1.0f]] forKey: @"inputColor"];
//    CIImage *resultCore = [hueAdjust valueForKey: @"outputImage"];
//    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef resultRef = [context createCGImage:resultCore fromRect:[resultCore extent]];
//    UIImage *result = [UIImage imageWithCGImage:resultRef];
//    //CGImageRelease(resultRef);
//    
//    return result;
}
-(void)viewDidAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:15];
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    
    if(backPressed == NO)
    {
        if([timer isValid])
        {
            [timer invalidate];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(rotate:) userInfo:nil repeats:YES];
        
        self.vat1.image = [UIImage imageNamed:@"cottonClump1Collecting2.png"];
        
        self.vat1.image = [self imageWithImage:self.vat1.image rotatedByHue:[rgbs objectForKey:@"0"]];
        self.vat1.image = [self imageWithImage:self.vat1.image rotatedByHue:[rgbs objectForKey:@"0"]];
        self.vat1.image = [self imageWithImage:self.vat1.image rotatedByHue:[rgbs objectForKey:@"0"]];
        self.vat2.image = [self imageWithImage:self.vat2.image rotatedByHue:[rgbs objectForKey:@"1"]];
        self.vat3.image = [self imageWithImage:self.vat3.image rotatedByHue:[rgbs objectForKey:@"2"]];
        self.vat4.image = [self imageWithImage:self.vat4.image rotatedByHue:[rgbs objectForKey:@"3"]];
        self.vat2.image = [self imageWithImage:self.vat2.image rotatedByHue:[rgbs objectForKey:@"1"]];
        self.vat3.image = [self imageWithImage:self.vat3.image rotatedByHue:[rgbs objectForKey:@"2"]];
        self.vat4.image = [self imageWithImage:self.vat4.image rotatedByHue:[rgbs objectForKey:@"3"]];
//        self.vat4.image = [self changeImageBrightness:self.vat4.image withFactor:0.8];
//        self.vat3.image = [self changeImageBrightness:self.vat3.image withFactor:0.8];
//        self.vat2.image = [self changeImageBrightness:self.vat2.image withFactor:0.8];
//        self.vat1.image = [self changeImageBrightness:self.vat1.image withFactor:0.8];
        
        
        vata1.image = [self imageWithImage:vata1.image rotatedByHue:[rgbs objectForKey:@"0"]];
        vata1.image = [self imageWithImage:vata1.image rotatedByHue:[rgbs objectForKey:@"0"]];
        //vata1.image = [self imageWithImage:vata1.image rotatedByHue:[rgbs objectForKey:@"0"]];
        vata2.image = [self imageWithImage:vata2.image rotatedByHue:[rgbs objectForKey:@"1"]];
        vata3.image = [self imageWithImage:vata3.image rotatedByHue:[rgbs objectForKey:@"2"]];
        vata4.image = [self imageWithImage:vata4.image rotatedByHue:[rgbs objectForKey:@"3"]];
        vata2.image = [self imageWithImage:vata2.image rotatedByHue:[rgbs objectForKey:@"1"]];
        vata3.image = [self imageWithImage:vata3.image rotatedByHue:[rgbs objectForKey:@"2"]];
        vata4.image = [self imageWithImage:vata4.image rotatedByHue:[rgbs objectForKey:@"3"]];
        vata5.image = [self imageWithImage:vata5.image rotatedByHue:[rgbs objectForKey:@"3"]];
        vata5.image = [self imageWithImage:vata5.image rotatedByHue:[rgbs objectForKey:@"3"]];
        
        
        vat1.alpha = 0.0;
        vat2.alpha = 0.0;
        vat3.alpha = 0.0;
        vat4.alpha = 0.0;
        
        allview.userInteractionEnabled = YES;
        self.stick.image = [UIImage imageNamed:self.stickName];
    }
    else
    {
        backPressed = NO;
        
        once = YES;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(rotate:) userInfo:nil repeats:YES];
        
        vat1.alpha = 0.0;
        vat2.alpha = 0.0;
        vat3.alpha = 0.0;
        vat4.alpha = 0.0;
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            allview.frame = CGRectMake(378, 511, 354, 378);
        else
            allview.frame = CGRectMake(93, 144, 253, 288);
    }
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

static void addGlossPath(CGContextRef context, CGRect rect) {
    CGFloat quarterHeight = CGRectGetMidY(rect) / 2;
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, -20, 0);
    
    CGContextAddLineToPoint(context, -20, quarterHeight);
    CGContextAddQuadCurveToPoint(context, CGRectGetMidX(rect), quarterHeight * 3, CGRectGetMaxX(rect) + 20, quarterHeight);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect) + 20, 0);
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

-(UIImage *)applyIconHighlightToImage:(UIImage *)icon {
    UIImage *newImage;
    CGContextRef context;
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    CGRect currentBounds = CGRectMake(0, 0, icon.size.width, icon.size.height);
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {1.0, 1.0, 1.0, 0.75, 1.0, 1.0, 1.0, 0.2};
    
    UIGraphicsBeginImageContext(icon.size);
    context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    addRoundedRectToPath(context, currentBounds, 10, 10);
    CGContextClosePath(context);
    CGContextClip(context);
    [icon drawInRect:currentBounds];
    
    addGlossPath(context, currentBounds);
    CGContextClip(context);
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, 2);
    
    CGContextDrawLinearGradient(context, glossGradient, topCenter, midCenter, 0);
    
    UIGraphicsPopContext();
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(UIImage *) changeImageBrightness:(UIImage *)aInputImage withFactor:(float)aFactor
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:aInputImage]; //your input image
    
    CIFilter *filter= [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:0.2] forKey:@"inputBrightness"];
    
    UIImage *outputImage =  [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
    return outputImage;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:15];
    [super viewDidDisappear:animated];
}

- (void)rotate:(NSTimer*)theTimer
{
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:0.01];
    spining.transform =  CGAffineTransformRotate(spining.transform,M_PI/4);
    [UIView commitAnimations];
}

- (void)NextPage:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:15];
    DecoratingCottonViewController *eating;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        eating = [[DecoratingCottonViewController alloc]initWithNibName:@"DecoratingCottonViewController-iPad" bundle:nil];
    }
    else
    {
        if([UIScreen mainScreen].bounds.size.height == 568)
            eating = [[DecoratingCottonViewController alloc]initWithNibName:@"DecoratingCottonViewController-5" bundle:nil];
        else
            eating = [[DecoratingCottonViewController alloc]initWithNibName:@"DecoratingCottonViewController" bundle:nil];
    }
    eating.stickName = self.stickName;
    eating.rgbs  = self.rgbs;
    [self.navigationController pushViewController:eating animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (IBAction)Back:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] stopSoundEffect:15];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resetClick:(id)sender
{
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:0];
    once = YES;
        
    vat1.alpha = 0.0;
    vat2.alpha = 0.0;
    vat3.alpha = 0.0;
    vat4.alpha = 0.0;

    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        allview.frame = CGRectMake(378, 511, 354, 378);
    else
        allview.frame = CGRectMake(93, 144, 253, 288);
}

@end
