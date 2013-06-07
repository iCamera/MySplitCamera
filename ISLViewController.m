//
//  ISLViewController.m
//  Excersize
//
//  Created by alvin zheng on 5/31/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "ISLViewController.h"
#import "ISLmyView.h"
#import "MarginMarkView.h"
#define GestureView_Width 14
@interface ISLViewController ()<UIGestureRecognizerDelegate>

@property ISLmyView *myViewOne;
@property ISLmyView *myVewTwo;
@property ISLmyView *myViewThree;

@property MarginMarkView  *moveableLineView_Left;
@property MarginMarkView  *moveableLineView_Right;

@property NSArray *editPictures;


@property UIImageView *imageView;

@end

@implementation ISLViewController{
    
    
    CGPoint panGesturePoint;
    CGPoint gestureEndP;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //------
       
    }
    return self;
}

-(id)initWithPictures:(NSArray *)pictures{
    
    if (self = [super init]) {
        self.editPictures =[[NSArray alloc] initWithArray: pictures];
    }
    return self;
}


-(void)initialPanGesture{
    UIPanGestureRecognizer *panGestureLeft = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(lineMoved:)];
    UIPanGestureRecognizer *panGestureRight = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(lineMoved:)];
    
    [panGestureLeft setDelegate:self];
    [panGestureRight setDelegate:self];
    
    [self.moveableLineView_Left setUserInteractionEnabled:YES];
    [self.moveableLineView_Right setUserInteractionEnabled:YES];
    
    [self.moveableLineView_Left addGestureRecognizer:panGestureLeft];
    [self.moveableLineView_Right addGestureRecognizer:panGestureRight];
    
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen]bounds];
    CGFloat xStep =screen.size.width/3;
    CGFloat height = screen.size.height;
    
    
    //set mark lines
    CGRect markRect_Left = CGRectMake(xStep-GestureView_Width, 0, 20, height);
    CGRect markRect_Right = CGRectMake(2*xStep-GestureView_Width, 0, 20, height);
    
    self.moveableLineView_Left = [[MarginMarkView alloc]initWithFrame:markRect_Left];
    self.moveableLineView_Right = [[MarginMarkView alloc]initWithFrame:markRect_Right];
      
    //set scoll views
    self.myViewOne =[[ISLmyView alloc]initWithFrame:CGRectMake(0 , 0 , markRect_Left.origin.x + GestureView_Width , height) andImage:[self.editPictures objectAtIndex:0]];
    self.myVewTwo =[[ISLmyView alloc]initWithFrame:CGRectMake(markRect_Left.origin.x + GestureView_Width, 0 , markRect_Right.origin.x - markRect_Left.origin.x , height) andImage:[self.editPictures objectAtIndex:1]];
    self.myViewThree =[[ISLmyView alloc]initWithFrame:CGRectMake(markRect_Right.origin.x + GestureView_Width, 0 , screen.size.width - markRect_Right.origin.x - GestureView_Width , height) andImage:[self.editPictures objectAtIndex:2]];
    
    [self.view addSubview:_myViewOne];
    [self.view addSubview:_myVewTwo];
    [self.view addSubview:_myViewThree];

    [self.view addSubview:_moveableLineView_Right];
    [self.view addSubview:_moveableLineView_Left];
    
    [self initialPanGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)moveline:(UIView*)line ToPoint:(CGPoint)point{
    
    CGPoint endPoint;
   
    endPoint = CGPointMake(point.x + panGesturePoint.x,line.frame.origin.y);
    
    
    CGFloat movDistance = gestureEndP.x - panGesturePoint.x;
   // NSLog(@"moved distance: %f",movDistance);
    
    CGRect frame = line.frame;
    
    if (endPoint.x<0 ||
        endPoint.x > (self.view.frame.size.width - self.moveableLineView_Right.frame.size.width)) return;
    if ((line == _moveableLineView_Left) &&
        (endPoint.x >_moveableLineView_Right.frame.origin.x - _moveableLineView_Right.frame.size.width * 0.5)) {
        return;
    }
    else if (line == _moveableLineView_Right &&
             endPoint.x < _moveableLineView_Left.frame.origin.x +_moveableLineView_Left.frame.size.width){
        
        return;
    }
    frame.origin.x = endPoint.x;
    
    line.frame = frame;
    
    //set scroll view
    
    /*
    CGRect rectOne = self.myViewOne.frame;
    CGRect rectTwo = self.myVewTwo.frame;
    CGRect rectThree = self.myViewThree.frame;
   */
   
    CGRect leftLineRct; //= self.moveableLineView_Left.frame;
    CGRect rightLineRct; //= self.moveableLineView_Right.frame;
    CGFloat height = frame.size.height;
    
    if (line == self.moveableLineView_Left) {
        leftLineRct = frame;
        rightLineRct = self.moveableLineView_Right.frame;
       // rectOne.size.width += movDistance;
       // rectTwo.origin.x   += movDistance;
       // rectTwo.size.width -= movDistance;
    }
    if (line == self.moveableLineView_Right) {
        rightLineRct = frame;
        leftLineRct = self.moveableLineView_Left.frame;
       // rectTwo.size.width += movDistance;
        //rectThree.origin.x += movDistance;
       // rectThree.size.width -= movDistance;
    }

    
  

    CGRect screen = [[UIScreen mainScreen]bounds];
    
    CGRect rectOne = CGRectMake(0 , 0 ,leftLineRct.origin.x + GestureView_Width, height);
    NSLog(@"%f",leftLineRct.origin.x + GestureView_Width);
    
    CGRect rectTwo = CGRectMake(leftLineRct.origin.x +GestureView_Width, 0 , rightLineRct.origin.x - leftLineRct.origin.x , height);
    CGRect rectThree = CGRectMake(rightLineRct.origin.x +GestureView_Width, 0 , screen.size.width - rightLineRct.origin.x - GestureView_Width , height);
   

    self.myViewOne.frame = rectOne;
    self.myVewTwo.frame = rectTwo;
    self.myViewThree.frame = rectThree;
    [self.myViewOne setNeedsDisplay];
    [self.myVewTwo setNeedsDisplay];
    [self.myViewThree setNeedsDisplay];
    
    
    
    
    

}


-(void)lineMoved:(UIPanGestureRecognizer *)pan{
    if (self.myViewOne.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        self.myViewOne.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged ||
        self.myVewTwo.scrollView.panGestureRecognizer.state  == UIGestureRecognizerStateBegan ||
        self.myVewTwo.scrollView.panGestureRecognizer.state  == UIGestureRecognizerStateChanged ||
        self.myViewThree.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        self.myViewThree.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        return;
    }
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        panGesturePoint = [pan locationInView:self.view];
        
    }
    //else if (pan.state == UIGestureRecognizerStateEnded){
        
        gestureEndP = [pan locationInView:self.view];
    
    //}
    
    [self moveline:pan.view ToPoint:[pan translationInView:self.view]];
    
    
    
}




@end
