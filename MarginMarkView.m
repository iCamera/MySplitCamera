//
//  MarginMarkView.m
//  Excersize
//
//  Created by alvin zheng on 6/3/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "MarginMarkView.h"
@interface MarginMarkView ()

//@property UIView *visibleLineView;

@end


@implementation MarginMarkView

- (id)initWithFrame:(CGRect)frame
{
    CGRect suitFrame = frame;
    suitFrame.size.width = 28.0;
    
    self = [super initWithFrame:suitFrame];
    if (self) {
        
        [self initialVisibleLineView];
        
        
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)initialVisibleLineView{
    CGRect upLineRect = CGRectMake(14, 0, 2, self.frame.size.height*0.05);
    CGRect lowLineRect = CGRectMake(14, self.frame.size.height*0.95+self.frame.origin.y, 2, self.frame.size.height*0.05);
    
    UIView *upLineView = [[UIView alloc]initWithFrame:upLineRect];
    UIView *lowLineView = [[UIView alloc]initWithFrame:lowLineRect];
    
    [upLineView setBackgroundColor:[UIColor redColor]];
    [lowLineView setBackgroundColor:[UIColor redColor]];
    
    [upLineView setAlpha:0.6];
    [lowLineView setAlpha:0.6];
    
    
    [self addSubview:upLineView];
    [self addSubview:lowLineView];
   
    
    
    /*
    _visibleLineView = [[UIView alloc]initWithFrame:lineViewRect];
    [_visibleLineView setBackgroundColor:[UIColor blueColor]];
    [_visibleLineView setAlpha:0.8];
    
    
    [self addSubview:_visibleLineView];
    
    */
    
    
}




@end
