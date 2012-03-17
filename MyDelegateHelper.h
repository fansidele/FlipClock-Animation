//
//  MyDelegateHelper.h
//  ClockAnimation
//
//  Created by zack on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyDelegateHelper : NSObject
{
    NSArray * images;
    CGRect  LayerFrame;
}
@property(nonatomic,assign)int FlipNr;
- (id)initWithImages:(NSArray*)_images frame:(CGRect)_LayerFrame;
@end
