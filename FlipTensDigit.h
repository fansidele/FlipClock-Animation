//
//  FlipTensDigit.h
//  ClockAnimation
//
//  Created by zack on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipUnit.h"

@interface FlipTensDigit : UIView
{
    FlipUnit * Unit;
    FlipUnit * Tens;
    
}
- (id)initWithFrame:(CGRect)frame;
-(void)FlipToNumber:(int)Number;

@end
