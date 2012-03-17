//
//  FlipNumber.m
//  ClockAnimation
//
//  Created by zack on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "FlipUnit.h"
#import "QuartzCore/QuartzCore.h"
#import "CoreImage/CoreImage.h"
#import "MyDelegateHelper.h"

#define NUMBER_OF_DIGITS 10
#define FLIP_DURATION 0.25   //half flip

#define TOP_TO_MIDDLE    @"TopToMidle"
#define MIDDLE_TO_BOTTOM @"MiddleToBottom"


@interface FlipUnit(private)

-(void)SetLayersByDefault;
-(void)SetLayer:(CALayer**)layer WithContent:(UIImage*)img frame:(CGRect)frame;

-(void)SplitImage:(UIImage*)image;
-(void)SplitImagesAndStoreInArray;


-(void)AddEffectToLayer:(CALayer*)layer;
-(void)AnimateWithKey:(NSString*)key;

@end



@implementation FlipUnit


- (id)initWithFrame:(CGRect)frame Images:(NSArray *)img
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        Images = [[NSArray alloc]initWithArray:img];
        [self SplitImagesAndStoreInArray];
        
        helper = [[MyDelegateHelper alloc]initWithImages:BottomImages frame:CGRectMake(0, 0, self.frame.size.width, frame.size.height/2)];
        
        [self SetLayersByDefault];
    
       
        [self.layer addSublayer:topLayer];
        [self.layer addSublayer:bottomLayer];
        [self.layer addSublayer:tempLayer];
        [self.layer addSublayer:flipLayer];
        
        CATransform3D aTransform = CATransform3DIdentity;
        float zDistance = 1000;
        aTransform.m34 = 1.0 / -zDistance;	
        [self layer].sublayerTransform = aTransform;
  
    }
    return self;
}



#pragma mark-SetContentLayers



-(void)SetLayersByDefault
{
    CGFloat Width = self.frame.size.width;
    CGFloat Height = self.frame.size.height;
    
    CGRect rect = CGRectMake(0,Height/4,Width, Height/2);
     flipLayer = [[CALayer layer]retain];
     [self SetLayer:&flipLayer WithContent:[TopImages objectAtIndex:0] frame:rect];
     [flipLayer setAnchorPoint:CGPointMake(0.5, 1.0)];
     [flipLayer setDelegate:helper];
  
    
    rect = CGRectMake(0, 0,Width, Height/2);
     topLayer = [[CALayer layer] retain];
     [self SetLayer:&topLayer WithContent:[TopImages objectAtIndex:0] frame:rect];
       
    
    rect =CGRectMake(0, Height/2, Width, Height/2);
     bottomLayer = [[CALayer layer]retain];
     [self SetLayer:&bottomLayer WithContent:[BottomImages objectAtIndex:0] frame:rect];
    
    rect =CGRectMake(0, 0, Width, Height/2);
    tempLayer = [[CALayer layer]retain];
    [self SetLayer:&tempLayer WithContent:[TopImages objectAtIndex:0] frame:rect];
    [tempLayer setHidden:YES];
}


-(void)SetLayer:(CALayer**)layer WithContent:(UIImage*)img frame:(CGRect)frame
{
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    CALayer * Thislayer = (*layer);

    Thislayer.contents = (id)img.CGImage;
    if(CGRectIsNull(frame) == NO)
    {
        Thislayer.frame  = frame;
    }
    
    
    [CATransaction commit];
    
}


#pragma mark-ProcessingDigitImages

-(void)SplitImagesAndStoreInArray
{
    TopImages  = [[NSMutableArray alloc]init];
    BottomImages = [[NSMutableArray alloc]init];
    
    for(int i=0;i<NUMBER_OF_DIGITS;i++)
    {
        NSString * str = [NSString stringWithFormat:@"%d.jpeg",i];
        UIImage * img =[UIImage imageNamed:str];
        [self SplitImage:img];
    }
    
}

-(void)SplitImage:(UIImage*)image
{
    // The size of each part is half the height of the whole image
    CGSize size = CGSizeMake([image size].width, [image size].height/2);
    
    // Create image-based graphics context for top half
    UIGraphicsBeginImageContext(size);
    
    // Draw into context, bottom half is cropped off
    [image drawAtPoint:CGPointMake(0.0,0.0)];
    // Grab the current contents of the context as a UIImage 
    // and add it to our array
    UIImage *top = [UIGraphicsGetImageFromCurrentImageContext() retain];			
    [TopImages addObject:top];
    
    // Now draw the image starting half way down, to get the bottom half
    [image drawAtPoint:CGPointMake(0.0,-[image size].height/2)];
    // And store that image in the array too
    UIImage *bottom = [UIGraphicsGetImageFromCurrentImageContext() retain];			
    [BottomImages addObject:bottom];
    
    UIGraphicsEndImageContext();
}

#pragma mark-Animating


-(void)FlipToVal:(int)Value
{
    [helper setFlipNr:Value]; 
        
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    [flipLayer setValue:[NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(-M_PI_2, 1, 0, 0)] 
             forKeyPath:@"transform"];
    [flipLayer setHidden:NO];
    [tempLayer setHidden:NO];
    [CATransaction commit];
 
       [self SetLayer:&topLayer WithContent:[TopImages objectAtIndex:Value] frame:CGRectNull];
            [self performSelector:@selector(ChangeLayerTop) withObject:nil afterDelay:0.01];    

    [self performSelector:@selector(AnimateWithKey:) 
               withObject:TOP_TO_MIDDLE afterDelay:0.0]; 
}

-(void)ChangeLayerTop
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [tempLayer setHidden:YES];
    [CATransaction commit];
}
-(void)AnimateWithKey:(NSString*)key
{

    CABasicAnimation *Animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    Animation.duration=FLIP_DURATION;
    Animation.repeatCount=1;
    Animation.delegate = self;
    Animation.removedOnCompletion = FALSE;


     if([key isEqualToString:TOP_TO_MIDDLE])
     {
         Animation.fromValue= [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0, 1, 0, 0)];
         float f = -M_PI/2;
         Animation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(f, 1, 0, 0)];
         [Animation setValue:[NSNumber numberWithInt:0]forKey:@"ID"];

     }else
     if([key isEqualToString:MIDDLE_TO_BOTTOM])
     {
 
         Animation.fromValue= 
                    [NSValue valueWithCATransform3D:
                     CATransform3DMakeRotation(-M_PI_2, 1, 0, 0)];

         
         Animation.toValue=
         [NSValue valueWithCATransform3D:
            CATransform3DMakeRotation(-M_PI, 1, 0, 0)];  
         
        [Animation setValue:
            [NSNumber numberWithInt:1]forKey:@"ID"];
         
        [self performSelector:@selector(ChangeLayerBottom) withObject:nil afterDelay:FLIP_DURATION-0.06];
   
     }
      [flipLayer addAnimation:Animation forKey:key];
}

-(void)ChangeLayerBottom
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    UIImage * img = [BottomImages objectAtIndex:helper.FlipNr];
    bottomLayer.contents = (id)img.CGImage;
    [flipLayer setHidden:YES];
    [CATransaction commit];

}


-(void)RedrawFlipLayer
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    [flipLayer setNeedsDisplay];
    [flipLayer displayIfNeeded];
    [CATransaction commit];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{ 
  int ID_Animation = (int)[[anim valueForKey:@"ID"]intValue];
     
         if(ID_Animation == 0)
         {

             [flipLayer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4, 1, 0, 0)] forKeyPath:@"transform"];
    
             [self RedrawFlipLayer];
             [self AnimateWithKey:MIDDLE_TO_BOTTOM];
         } 
         else
         {          
             [CATransaction begin];
             [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
  
            UIImage* img = [TopImages objectAtIndex:helper.FlipNr];
             flipLayer .contents =(id)img.CGImage;
             
                 [self SetLayer:&tempLayer WithContent:img frame:CGRectNull]; 
                 [tempLayer setHidden:NO];
             [CATransaction commit];

         }
}





@end
