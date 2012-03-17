//
//  projectViewController.m
//  ClockAnimation
//
//  Created by zack on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "projectViewController.h"
#import "FlipTensDigit.h"

@implementation projectViewController


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
   
                    fliper =[[FlipTensDigit alloc]
                                initWithFrame:CGRectMake(0, 50, 150,200)];
    [self.view addSubview:fliper];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(UpdateClock:) userInfo:nil repeats:YES];
} 

-(void)UpdateClock:(NSTimer*)sender
{   
    static int i  =0;

    [fliper FlipToNumber:i];
    i++;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




@end
