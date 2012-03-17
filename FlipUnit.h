//
//  FlipNumber.h
//  ClockAnimation
//
//  Created by zack on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyDelegateHelper;
@class CABasicAnimation;

@interface FlipUnit : UIView
{
    CALayer * flipLayer,*bottomLayer,*topLayer;
    CALayer * tempLayer;
    NSArray * Images;
    NSMutableArray * BottomImages;
    NSMutableArray * TopImages;
    
    MyDelegateHelper * helper;
}



-(id)initWithFrame:(CGRect)frame Images:(NSArray*)images;
-(void)FlipToVal:(int)Value;

@end
