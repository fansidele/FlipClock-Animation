//
//  MyDelegateHelper.m
//  ClockAnimation
//
//  Created by zack on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyDelegateHelper.h"
#import "QuartzCore/QuartzCore.h"
//#import "CoreImage/CoreImage.h"

@implementation MyDelegateHelper
@synthesize FlipNr;

- (id)initWithImages:(NSArray*)_images frame:(CGRect)_LayerFrame{
    self = [super init];
    if (self) {
        images = [[NSArray alloc]initWithArray:_images];
         LayerFrame = _LayerFrame;
    }
    return self;
}

//- (void)displayLayer:(CALayer *)theLayer
//{
// 
//
//    theLayer.contents = (id)[[images objectAtIndex:1]CGImage];
//   
//    
//}


-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{

   UIImage*img = [images objectAtIndex:FlipNr];
    CGContextDrawImage(ctx, LayerFrame,img.CGImage);
}



@end
