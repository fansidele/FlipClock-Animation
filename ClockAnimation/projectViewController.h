//
//  projectViewController.h
//  ClockAnimation
//
//  Created by zack on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDelegateHelper.h"

@class FlipTensDigit;
@interface projectViewController : UIViewController
{

    
    
    NSMutableArray * imagesTop;
    NSMutableArray * imagesBottom;
    

    FlipTensDigit * fliper ;
}



@end
