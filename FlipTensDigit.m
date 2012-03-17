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

-(void)FlipToNumber:(int)Number
{
    if(Number>99)
        Number=Number%100;
    
    int tensDigit = [self TensDigitFrom:Number];
    int unitDigit = [self UnitDigitFrom:Number]; 
    
    [Unit FlipToVal:unitDigit];
    
    if(Number>9 && unitDigit==0)
        [Tens FlipToVal:tensDigit];
}


// Private methods
//----------------------------------------------------------------------

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
    return (int)Number/10;    
}

-(int)UnitDigitFrom:(int)Number
{
    return Number%10;
}

<<<<<<< HEAD
-(void)FlipToNumber:(int)Number
{
    int tensDigit = [self TensDigitFrom:Number];
    int unitDigit = [self UnitDigitFrom:Number]; 

    [Unit FlipToVal:unitDigit];
    
    [Tens FlipToVal:tensDigit];
}


=======
>>>>>>> c1a2598da55e01f4a6af1c873df9dcdab710d9ac
@end
