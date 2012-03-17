//
//  FlipTensDigit.m
//  ClockAnimation
//
//  Created by zack on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipTensDigit.h"

        
@interface FlipTensDigit () 
-(NSArray*)Images;
-(int)UnitDigitFrom:(int)Number;
-(int)TensDigitFrom:(int)Number;
@end


@implementation FlipTensDigit

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        CGRect rect;
        rect = CGRectMake(0,0, frame.size.width/2, frame.size.height);
            Tens = [[FlipUnit alloc]initWithFrame:rect Images:[self Images]];
        rect = CGRectMake(frame.size.width/2,0, frame.size.width/2,frame.size.height);
            Unit = [[FlipUnit alloc]initWithFrame:rect Images:[self Images]];
        
        [self addSubview:Unit];
        [self addSubview:Tens];
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(NSArray*)Images
{
    
    NSMutableArray * array =[[[NSMutableArray alloc]init] autorelease];
    for(int i=0;i<10;i++)
    {
        NSString * str = [NSString stringWithFormat:@"%d.jpeg",i];
        UIImage * img =[UIImage imageNamed:str];
        [array addObject:img];
    }
    return (NSArray*)array;
}


-(int)TensDigitFrom:(int)Number
{
    if(Number == 0) return 0;
    return (int)Number/10;
    
}

-(int)UnitDigitFrom:(int)Number
{
    return Number%10;
}

-(void)FlipToNumber:(int)Number
{
    if(Number>99) return;
    
    static int prevUnit;
  
    int tensDigit = [self TensDigitFrom:Number];
    int unitDigit = [self UnitDigitFrom:Number]; 
    
    
    [Unit FlipToVal:unitDigit];
    
    if(prevUnit==9)
    [Tens FlipToVal:tensDigit];
    
    prevUnit=unitDigit;
}


@end
