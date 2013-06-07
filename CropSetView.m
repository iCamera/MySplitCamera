//
//  CropView.m
//  MySplitCamera
//
//  Created by alvin zheng on 6/4/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "CropSetView.h"

@implementation CropSetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)done:(id)sender{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
