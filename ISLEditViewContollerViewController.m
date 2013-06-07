//
//  ISLEditViewContollerViewController.m
//  MySplitCamera
//
//  Created by alvin zheng on 5/30/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "ISLEditViewContollerViewController.h"
#import "Jigaw.h"
@interface ISLEditViewContollerViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView       *drawView;
@property (nonatomic, strong) IBOutlet UIImageView  *imageView;
@property (nonatomic, strong) Jigaw *jigaw;


@end

@implementation ISLEditViewContollerViewController{
    
    IBOutlet UIView *leftLine;
    //IBOutlet UIView *middleLine;
    IBOutlet UIView *righLine;
    
    CGPoint panGestureStartPoin;
    
    NSArray *editEmages;
}

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
         editEmages = [[NSArray alloc]initWithArray:[images copy]];
       // self.jigaw = [[Jigaw alloc]initWithImages:jigawImages];
    }  
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.imageView setImage:self.resultimage];
    
    //[self setPicture:self.resultimage];
    //self.scrollView.contentSize = self.imageView.frame.size;
    //self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.minimumZoomScale = 1.0f;
    self.scrollView.maximumZoomScale = 5.0f;
    CGFloat width = self.imageView.frame.size.width/3;
    CGFloat height = self.imageView.frame.size.height;
    CGRect rectOne = CGRectMake(0, 0, width, height);
    CGRect rectTwo = CGRectMake(width, 0, width, height);
    CGRect rectThree = CGRectMake(width*2, 0, width, height);
    
    NSMutableArray *scalImages=[[NSMutableArray alloc]init];
    CGSize scalSize = self.imageView.frame.size;
    for(UIImage *image in editEmages){
        [scalImages addObject:[image imageByScalingProportionallyToMinimumSize:scalSize]];
        
    }
    
    self.jigaw = [[Jigaw alloc]initWithImages:scalImages];
    
    [self.imageView setImage:[self.jigaw  combineImageWithRectOne:rectOne zoneTwo:rectTwo zoneThree:rectThree]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPicture:(UIImage *)image{
    
    self.imageView.image = image;
    CGPoint center = self.scrollView.center;
    CGFloat heightWillBe;
    CGFloat widthWillBe;
    CGSize size;
    CGFloat widthKoef = self.scrollView.frame.size.width/self.imageView.image.size.width;
    CGFloat heightKoef = self.scrollView.frame.size.height/self.imageView.image.size.height;
    if ( widthKoef < heightKoef){
        // width is bigger than height
        heightWillBe  = self.imageView.image.size.height * self.imageView.frame.size.width/self.imageView.image.size.width;
        size = CGSizeMake(self.imageView.frame.size.width, heightWillBe);
    } else {
        // height is bigger than width
        widthWillBe  = self.imageView.image.size.width * self.imageView.frame.size.height/self.imageView.image.size.height;
        size = CGSizeMake(widthWillBe, self.imageView.frame.size.height);
    }
    [self.scrollView setBounds:CGRectMake(0, 0, size.width, size.height)];
    [self.imageView setFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.scrollView setCenter:center];
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.alwaysBounceVertical = NO;
    
    
    //try no scroll
    self.scrollView.scrollEnabled = NO;
    
    
}


-(void)initialLines{
    
}


-(void)configLines{
    
    leftLine.frame = CGRectMake(leftLine.frame.origin.x, self.drawView.frame.origin.y, leftLine.frame.size.width, self.drawView.frame.size.height);
    righLine.frame = CGRectMake(righLine.frame.origin.x, self.drawView.frame.origin.y, righLine.frame.size.width, self.drawView.frame.size.height);
    
    
}
#pragma mark -
#pragma mark line gestures set

-(void)setLineGesturesEnabled:(BOOL)enableLineGestures{
    
    [[leftLine.gestureRecognizers objectAtIndex:0] setEnabled:enableLineGestures];
    [[righLine.gestureRecognizers objectAtIndex:0] setEnabled:enableLineGestures];
    
}


-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)done{
    
}



//move line action

-(void)moveLine:(UIView *)line withPoint:(CGPoint)point{
    
    CGPoint finalPoint;
    
    point = CGPointMake(point.x, line.frame.origin.y);
    finalPoint = CGPointMake(point.x+panGestureStartPoin.x,point.y);
    
    
    CGRect frame = line.frame;
    /*
    CGFloat halfWidth = leftLine.frame.size.width/2;
    
    
    if (line == leftLine) {
        frame.origin.x = MAX(-halfWidth, MIN(leftLine.center.x-halfWidth*3, finalPoint.x));
      }
    else if (line == righLine){
        
     frame.origin.x = MIN(self.imageView.frame.size.width-halfWidth, MAX(finalPoint.x, leftLine.center.x+halfWidth));
    }
    */
    
    if (finalPoint.x < 0 ||
        finalPoint.x > (self.drawView.frame.size.width - righLine.frame.size.width )) return;
    
    if ((line == leftLine) &&
        
             (finalPoint.x > righLine.frame.origin.x - righLine.frame.size.width/2) ) {
            
            return;
        }
          
    
    else if (line == righLine &&
      
             finalPoint.x < leftLine.frame.origin.x + leftLine.frame.size.width){
        
        return;
    }
    
    
    frame.origin.x = finalPoint.x;
    line.frame = frame;
    
    
}




-(IBAction)lineMoved:(UIPanGestureRecognizer *)pan{
    
    if (self.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        self.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged) return;
    self.scrollView.scrollEnabled = NO;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.scrollView.scrollEnabled = NO;//YES
    }
    if (pan.state == UIGestureRecognizerStateBegan) {
        panGestureStartPoin = pan.view.frame.origin;
    }
    
     [self moveLine:pan.view withPoint:[pan translationInView:self.drawView] ];

    //[self configLines];
}


#pragma mark -
#pragma mark UIScoll view delegate


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    if (self.scrollView.scrollEnabled) {
        return  self.drawView;
    }
    
    else return nil;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    
    [scrollView setZoomScale:scale + 0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
    
    
}




#pragma mark -
#pragma mark UIGestcherRecognizeDelegate


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        self.scrollView.scrollEnabled = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(allowScrollingAndZooming) object:nil];
        
        [self performSelector:@selector(allowScrollingAndZooming) withObject:nil afterDelay:0.2];
    }
    return YES;
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    
    return YES;
    
}


-(void)allowScrollingAndZooming{
    self.scrollView.scrollEnabled = YES;
    
}















@end
