//
//  EditViewContrller_Three.m
//  MySplitCamera
//
//  Created by alvin zheng on 6/4/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "EditViewContrller_Three.h"
#import "UIImage+CropEdit.h"
#import "CropSetView.h"
@interface EditViewContrller_Three ()<UIScrollViewDelegate>

@property UIScrollView *scrollView;
@property UIPageControl *pageControl;
@property UIView *roomView;
@property UIImageView *cropView;
@property NSMutableArray *editImages;
//@property NSMutableArray *cropedImage;

@property UIView *cropSetView;



@end

@implementation EditViewContrller_Three

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithImages:(NSArray *)images{
    if (self = [super init]) {
        self.editImages = [[NSMutableArray alloc]initWithArray:images];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    CGRect screen = [[UIScreen mainScreen]bounds];
   // UIImage *image = [_editImages objectAtIndex:0];
    CGFloat width =screen.size.width;//image.size.width;
    CGFloat height =screen.size.height;//image.size.height;
    
    //add crop view
    _cropView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //[_cropView setBackgroundColor:[UIColor blueColor]];
    _cropView.contentMode = UIViewContentModeScaleAspectFit;
    [_cropView setImage:[UIImage imageNamed:@"cropIcon.png"]];
   
    [_cropView sizeToFit];
    
    [_cropView setAlpha:0.5];
    [_cropView setContentMode:UIViewContentModeCenter];
    _cropView.exclusiveTouch = YES;
    _cropView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture_crop = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(crop)];
    tapGesture_crop.numberOfTapsRequired = 2;
    [_cropView addGestureRecognizer:tapGesture_crop];
    
    UITapGestureRecognizer *tapGesture_set = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setFrameOfCropView)];
    tapGesture_set.numberOfTapsRequired = 1;
    [_cropView addGestureRecognizer:tapGesture_set];

    [self.view addSubview:_cropView];
    
    
    //init scroll view
    _scrollView = [[UIScrollView alloc]initWithFrame:screen];
    [_scrollView setContentSize:CGSizeMake(width*3, height)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setDelegate:self];
    
    _roomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width*3, height)];
    [_scrollView addSubview:_roomView];
    
    //add images
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*width, 0, width, height)];
        //imageView.contentMode = UIViewContentModeCenter;
        [imageView setImage:[_editImages objectAtIndex:i]];
        //[imageView sizeToFit];
        [_roomView addSubview:imageView];

    }
    
    [self.view addSubview: _scrollView];
    
    //page control
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, screen.size.height, self.view.frame.size.width, 20)];
    [_pageControl setNumberOfPages:3];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    [self.view bringSubviewToFront:_cropView];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)changePage:(id)sender{
    NSLog(@"page changed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark scroll view delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_pageControl setCurrentPage:fabs(scrollView.contentOffset.x/self.view.frame.size.width)];
    //NSLog(@"scrolling x-axis:%f",scrollView.contentOffset.x);
    //NSLog(@"scrolling y-axis:%f",scrollView.contentOffset.y);
    NSLog(@"current page:%d",_pageControl.currentPage);
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.roomView;
}






#pragma mark -
#pragma mark crop view touch handling
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in touches){
        if(CGRectContainsPoint(self.cropView.frame, [touch locationInView:self.view]))
        [self animateFirstTouchAtPoint:[touch locationInView:self.view] forView:self.cropView];
        
    }
    
    
}
*/
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        if(CGRectContainsPoint(self.cropView.frame, [touch locationInView:self.view]))
        
        self.cropView.center = [touch locationInView:self.view];
    }
    
    
}
/*
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    for(UITouch *touch in touches){
        if(CGRectContainsPoint(self.cropView.frame, [touch locationInView:self.view]))
        [self animateView:self.cropView toPosition:[touch locationInView:self.view]];
        
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for(UITouch *touch in touches){
        if(CGRectContainsPoint(self.cropView.frame, [touch locationInView:self.view]))
        [self animateView:self.cropView toPosition:[touch locationInView:self.view]];
        
    }
}

//animate
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.15];
	theView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
    
}

-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.15];
    theView.center = thePosition;
    
    theView.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
    
}

*/
#pragma mark -
#pragma mark crop handling
-(void)setFrameOfCropView{
   // CropSetView *cropSetView = [[CropSetView alloc]init];
    //UIButton *okButton = [[UIButton alloc]initWithFrame:CGRectMake(cropSetView.frame.size.width-30, cropSetView.frame.size.height-80, 60, 40)];
    //[cropSetView addSubview:okButton];
    //[self.view addSubview:cropSetView];
    //if (!self.cropSetView) {

    if(!self.cropSetView){
        
        //set slider
    _cropSetView = [[UIView alloc]initWithFrame:CGRectMake(0, 200,self.view.frame.size.width, 300)];
    UISlider *widthSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 23)];
    UISlider *heightSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 23)];
        CGFloat maxWidth = self.view.frame.size.width*0.8;
        CGFloat maxHeight = self.view.frame.size.height*0.8;
    [widthSlider setMaximumValue:maxWidth];
    [widthSlider setMinimumValue:1];
    [heightSlider setMaximumValue:maxHeight];
    [heightSlider setMinimumValue:1];
    [widthSlider setValue:_cropView.frame.size.width];
    [heightSlider setValue:_cropView.frame.size.height];
        widthSlider.continuous = NO;
        heightSlider.continuous = NO;
    
    [widthSlider addTarget:self action:@selector(changeCropWidth:) forControlEvents:UIControlEventAllEvents];
    [heightSlider addTarget:self action:@selector(changeCropHeight:) forControlEvents:UIControlEventAllEvents];
        
     //set button
    UIButton *cancelButton =[[UIButton alloc]initWithFrame:CGRectMake(_cropSetView.frame.size.width/2-20,_cropSetView.frame.size.height-80, 50, 40)];
    [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(finishSettingCropFrame) forControlEvents:UIControlEventTouchDown];
    
    UIButton *cropButton = [[UIButton alloc]initWithFrame:CGRectMake(cancelButton.frame.origin.x,cancelButton.frame.origin.y-60,40,40)];
    [cropButton setTitle:@"crop" forState:UIControlStateNormal];
    [cropButton addTarget:self action:@selector(crop) forControlEvents:UIControlEventTouchDown];
     
        CGPoint centerPoint = CGPointMake(cancelButton.frame.size.width/2+20, (cancelButton.frame.origin.y-cropButton.frame.origin.y)/2+cropButton.frame.origin.y);
        
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(centerPoint.x-40, centerPoint.y, 30, 30)];
        [leftButton setTitle:@"<--" forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchDown];
        
        UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(centerPoint.x+40, centerPoint.y, 30, 30)];
        [rightButton setTitle:@"-->" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchDown];
        
        UIButton *upButton = [[UIButton alloc]initWithFrame:CGRectMake(centerPoint.x, centerPoint.y-40, 30, 30)];
        [upButton setTitle:@"up" forState:UIControlStateNormal];
        [upButton addTarget:self action:@selector(upButtonPressed) forControlEvents:UIControlEventTouchDown];
        
        UIButton *downButton = [[UIButton alloc]initWithFrame:CGRectMake(centerPoint.x, centerPoint.y+40, 30, 30)];
        [downButton setTitle:@"v" forState:UIControlStateNormal];
        [downButton addTarget:self action:@selector(downButtonPressed) forControlEvents:UIControlEventTouchDown];
        
    [_cropSetView addSubview:widthSlider];
    [_cropSetView addSubview:heightSlider];
    [_cropSetView addSubview:cancelButton];
    [_cropSetView addSubview:cropButton];
        [_cropSetView addSubview:leftButton];
        [_cropSetView addSubview:rightButton];
        [_cropSetView addSubview:upButton];
        [_cropSetView addSubview:downButton];
    
    [self.view addSubview:_cropSetView];
    //}
   // else{
    //    [self.view  bringSubviewToFront:self.cropSetView];
    //}
    }
    else if (!self.cropSetView.superview){
        
           // [self.view  bringSubviewToFront:self.cropSetView];
        [self.view addSubview:_cropSetView];
    }
    
    NSLog(@"single taped");
}

-(void)changeCropWidth:(UISlider *)sender{
    CGFloat width = self.cropView.frame.size.width;
    NSLog(@"now width :%f",width);
    CGFloat rate=sender.value;
    NSLog(@"rate :%f",rate);
    width = rate;
    NSLog(@"width changed to %f",width);
    CGRect rect = self.cropView.frame;
    rect.size.width = width;
    self.cropView.frame = rect;
    [self.cropView setNeedsDisplay];
    
}
-(void)changeCropHeight:(UISlider *)sender{
    CGFloat height = self.cropView.frame.size.height;
    NSLog(@"nowheight: %f",height);
    CGFloat rate=sender.value;
    height = rate;
    NSLog(@"rate :%f",rate);
    NSLog(@"height changed to %f",height);
    CGRect rect = self.cropView.frame;
    rect.size.height = height;
    self.cropView.frame = rect;
    [self.cropView setNeedsDisplay];

}
-(void)finishSettingCropFrame{
    [self.cropSetView removeFromSuperview];
    //[self.view bringSubviewToFront:self.scrollView];
    //[self.view bringSubviewToFront:<#(UIView *)#>]
}


-(void)leftButtonPressed{
    CGPoint newCenter = self.cropView.center;
    newCenter.x  =self.cropView.center.x - 1;
    self.cropView.center = newCenter;
    
}
-(void)rightButtonPressed{
    CGPoint newCenter = self.cropView.center;
    newCenter.x  =self.cropView.center.x + 1;
    self.cropView.center = newCenter;
    
}
-(void)upButtonPressed{
    
    CGPoint newCenter = self.cropView.center;
    newCenter.y  =self.cropView.center.y - 1;
    self.cropView.center = newCenter;
}
-(void)downButtonPressed{
    CGPoint newCenter = self.cropView.center;
    newCenter.y  =self.cropView.center.y + 1;
    self.cropView.center = newCenter;
    
}

-(void)crop{
    
    NSLog(@"double tapped!");
    NSInteger currentPage = self.pageControl.currentPage;
    
    CGRect rect = self.cropView.frame;
     UIImage *underEditImage = [self.editImages objectAtIndex:currentPage];
    
    CGRect cropRect = [self coordinateRelativeChange:rect ofRect:[[UIScreen mainScreen]bounds] toSize:underEditImage.size];
    
   
    UIImage *cropImage = [underEditImage imageAtRect:cropRect];
    
    
    self.cropView.alpha = 1.0;
    self.cropView.image=[cropImage imageByScalingToSize:rect.size];
    
    
}

-(CGRect)coordinateRelativeChange:(CGRect)rect ofRect:(CGRect)motherRect toSize:(CGSize)destinationRect{
    
    double xRate = destinationRect.width/motherRect.size.width;
    double yRate = destinationRect.height/motherRect.size.height;
    CGRect resultRect = CGRectZero;
    resultRect = CGRectMake(rect.origin.x*xRate, rect.origin.y*yRate, rect.size.width*xRate, rect.size.height*yRate);
    return resultRect;
    
    
}


-(UIImage *)addImage:(UIImage *)image1 to:(UIImage *)image2{
    
    CGSize size = CGSizeMake(image1.size.width*0.5, image1.size.height);
    CGRect rect1 = CGRectZero;
    rect1.origin = CGPointMake(0, 0);
    rect1.size = size;
    
    CGRect rect2 = CGRectMake(size.width, 0, image2.size.width-size.width, size.height);
    
    UIImage *halfImage1 = [image1 imageAtRect:rect1];
    
    UIImage *halfImage2 = [image2 imageAtRect:rect2];
    
    
    UIGraphicsBeginImageContext(image2.size);
    
    [halfImage1 drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [halfImage2 drawInRect:CGRectMake(size.width, 0, halfImage2.size.width, halfImage2.size.height)];
    //[image2 drawInRect:CGRectMake(0, image1.size.width, image2.size.width, image2.size.height)];
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return resultImage;
    
    
    
}


-(UIImage *)replaceRect:(CGRect)replaceRect ofImage:(UIImage *)sourceImage withImage:(UIImage *)replaceImage{
    
    CGSize resultSize = sourceImage.size;
    CGRect resultRect = CGRectZero;
    resultRect.origin = CGPointMake(0, 0);
    resultRect.size = resultSize;
    
    UIImage *cutImage = [replaceImage imageAtRect:replaceRect];
    
    
    UIGraphicsBeginImageContext(resultSize);
    [sourceImage drawInRect:resultRect];
    [cutImage drawInRect:replaceRect];
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
    
    
}







@end
