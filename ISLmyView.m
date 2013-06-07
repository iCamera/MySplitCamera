//
//  ISLmyView.m
//  Excersize
//
//  Created by alvin zheng on 5/31/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "ISLmyView.h"

@implementation ISLmyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{   
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    //CGContextSetRGBStrokeColor(context, 0.6, 0.9, 0, 1.0);
    //[[UIColor whiteColor]set];
    CGPoint verticalPointStart = CGPointMake(0, 60);
    CGPoint verticalPointEnd = CGPointMake(40,60);//(self.frame.size.width, 60);
    CGPoint horizonPointStart = CGPointMake(50,0);//(self.frame.size.width*0.5, 0);
    CGPoint horizonPointEnd = CGPointMake(50,100);//(self.frame.size.width*0.5 ,self.frame.size.height);
    
    CGContextMoveToPoint(context, verticalPointStart.x, verticalPointStart.y);
    CGContextAddLineToPoint(context, verticalPointEnd.x, verticalPointEnd.y);
    
    CGContextMoveToPoint(context, horizonPointStart.x, horizonPointStart.y);
    CGContextAddLineToPoint(context, horizonPointEnd.x, horizonPointEnd.y);
    
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    
    
    // Drawing code
}
 */

-(id)initWithFrame:(CGRect)frame andImage:(UIImage *)image{
    
    if (self = [super initWithFrame:frame]) {
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView = [[UIImageView alloc]initWithImage:image];
        
        [self setInsideProperty];
    }
    return self;
    
}


-(void)setInsideProperty{
    
    
    [self.scrollView setContentSize:self.imageView.frame.size];
    [self.scrollView addSubview:self.imageView];
    _scrollView.bounces = NO;
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setDelegate:self];
    _scrollView.minimumZoomScale = 0.1;
    _scrollView.maximumZoomScale = 5.0;
    
    
    [self addSubview:self.scrollView];
    
   /*
     CALayer *grayCover = [[CALayer alloc] init];
    grayCover.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2]CGColor];
    [self.layer addSublayer:grayCover];
    
    */
}


#pragma mark -
#pragma mark UIScoll view delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    CGFloat centerX = scrollView.center.x;
    CGFloat centerY = scrollView.center.y;
    
    centerX = scrollView.contentSize.width > scrollView.frame.size.width ?    scrollView.contentSize.width/2 : centerX;
    centerY = scrollView.contentSize.height > scrollView.frame.size.height ?  scrollView.contentSize.height/2 : centerY;
    
    
    
    [_imageView setCenter:CGPointMake(centerX, centerY)];
    
    
}

@end
