//
//  ISLOverlayViewController.m
//  MySplitCamera
//
//  Created by alvin zheng on 5/29/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "ISLOverlayViewController.h"

#define Auto_time_intervel 4
enum{
    TakePhoto_One_Shot,
    TakePhoto_Two_Shot,
    TakePhoto_Three_Shot,
    TakePhoto_Five_Shot,
    TakePhoto_Ten_Shot
};
@interface ISLOverlayViewController ()

@property (assign) SystemSoundID tickSound;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *manualButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *autoButton;

@property (nonatomic, strong) NSTimer  *tickTimer;
@property (nonatomic, strong) NSTimer  *cameraTimer;
@property (nonatomic,assign)  NSInteger validCameraTimerCount;

//overlay view action
-(IBAction)done:(id)sender;
-(IBAction)manualTakePhoto:(id)sender;
-(IBAction)autoTakePhoto:(id)sender;

@end


#pragma mark -
#pragma make OverlayViewController
@implementation ISLOverlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AudioServicesCreateSystemSoundID(( CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:
                                                                      [[NSBundle mainBundle]
                                                                       pathForResource:@"tick"
                                                                       ofType:@"aiff"]]),
                                         &_tickSound);
        self.imagePickerController = [[UIImagePickerController alloc]init];
        self.imagePickerController.delegate = self;
        self.validCameraTimerCount = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self.cameraTimer invalidate];
    self.cameraTimer = nil;
    
    
    [self.tickTimer invalidate];
    self.tickTimer = nil;
}


-(void)refreshButtonState{
    
    [self.delegate doneWithCamera];//tell delegate ,do not use the camera now
    
    //restore button state
    self.doneButton.enabled = YES;
    self.manualButton.enabled = YES;
    self.autoButton.enabled = YES;
    self.autoButton.title =@"Auto";
    
    
}

-(void)timedPhotoFire:(NSTimer *)timer{
    if (self.validCameraTimerCount>0) {
        
        [self.imagePickerController takePicture];
        self.validCameraTimerCount -=1;
        
    }
    else{
        
        [self.cameraTimer invalidate];
        self.cameraTimer = nil;
        
        [self.tickTimer invalidate];
        self.tickTimer = nil;
        
        [self refreshButtonState];
    }
    
    /*
     NSInteger shotTimes = [[self.cameraTimer userInfo]intValue];
     switch (shotTimes) {
     case TakePhoto_One_Shot:
     [self.cameraTimer invalidate];
     self.cameraTimer = nil;
     break;
     case
     default:
     break;
     }
     */
    
}

-(void)tickFire:(NSTimer *)timer{
    
    AudioServicesPlaySystemSound(self.tickSound);
    
}



#pragma mark -
#pragma mark Camera Actions


-(IBAction)done:(id)sender{
    if (![self.cameraTimer isValid]) {
        [self refreshButtonState];
    }
    
}

-(IBAction)manualTakePhoto:(id)sender{
    
    [self.imagePickerController takePicture];
    
}
-(IBAction)autoTakePhoto:(id)sender{
    if ([self.autoButton.title isEqualToString: @"Stop"]) {
        [self.cameraTimer invalidate];
        [self.tickTimer invalidate];
        self.cameraTimer = nil;
        self.tickTimer = nil;
        self.validCameraTimerCount = 0;
        [self refreshButtonState];
    }
    else{
        self.autoButton.title = @"Stop";
        self.doneButton.enabled = NO;
        self.manualButton.enabled = NO;
        self.validCameraTimerCount = 3;
        
        self.cameraTimer =  [NSTimer scheduledTimerWithTimeInterval:Auto_time_intervel target:self selector:@selector(timedPhotoFire:) userInfo:[NSNumber numberWithInt:TakePhoto_One_Shot] repeats:YES]
        ;
        if (self.tickTimer != nil) {
            [self.tickTimer invalidate];
        }
        self.tickTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickFire:) userInfo:nil repeats:YES];
        
        
        
        //set invalid camera timer counts
        
        
        [self.cameraTimer fire];
        //[self.tickTimer fire];
        
    }
    
}
#pragma mark -
#pragma public method

-(void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType{
    self.imagePickerController.sourceType = sourceType;
    
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        self.imagePickerController.showsCameraControls = NO;
        
        if ([[self.imagePickerController.cameraOverlayView subviews] count] == 0) {
            
            
            CGRect overlayViewRect = self.imagePickerController.cameraOverlayView.frame;
            CGRect newFrame = CGRectMake(0.0, CGRectGetHeight(overlayViewRect)-self.view.frame.size.height - 10, CGRectGetWidth(overlayViewRect), self.view.frame.size.height +10.0);
            self.view.frame = newFrame;
            [self.imagePickerController.cameraOverlayView addSubview:self.view];
            
        }
        
        
        
    }
    
    
    
    
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate
//when image has been chosen from the librarr of catched from camera, called this delegate method

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    if (self.delegate) {
        [self.delegate didFinishedTakePhoto:image];
    }
    if (![self.cameraTimer isValid]) {
        [self refreshButtonState];
    }

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.delegate doneWithCamera];
    
}
@end
