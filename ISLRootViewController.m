//
//  ISLRootViewController.m
//  MySplitCamera
//
//  Created by alvin zheng on 5/29/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "ISLRootViewController.h"
//#import "ISLEditViewContollerViewController.h"
#import "ISLViewController.h"
#import "UIImage+FixedOrientation.h"
#import "EditViewContrller_Three.h"
@interface ISLRootViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *mainView;
@property (nonatomic, strong) IBOutlet  UIToolbar   *mainToolbar;

@property (nonatomic, strong) ISLOverlayViewController *overlayViewController;


@property (nonatomic, strong)NSMutableArray *capturedPhotoes;




//toolbar buttons actions
-(IBAction)takePhotoesFromAlbum:(id)sender;
-(IBAction)cameraAction:(id)sender;
-(IBAction)savePhoto:(id)sender;

@end

#pragma mark -
#pragma mark view controller

@implementation ISLRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.overlayViewController = [[ISLOverlayViewController alloc]initWithNibName:@"ISLOverlayViewController" bundle:nil];
    
    self.overlayViewController.delegate = self;
    self.capturedPhotoes = [NSMutableArray array];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        NSMutableArray *toolbarItems = [NSMutableArray arrayWithCapacity:self.mainToolbar.items.count];
        [toolbarItems addObjectsFromArray:self.mainToolbar.items];
        [toolbarItems removeObjectAtIndex:3];
        [self.mainToolbar setItems:toolbarItems animated:NO];
        
        
    }
    
    //go to edit picture
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showImageSource:(UIImagePickerControllerSourceType) sourceType{
    
    if (self.mainView.isAnimating) {
        
        [self.mainView stopAnimating];
        
    }
    
    if (self.capturedPhotoes.count > 0) {
        
        [self.capturedPhotoes removeAllObjects];
        
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self.overlayViewController setupImagePicker:sourceType];
        [self presentViewController:self.overlayViewController.imagePickerController animated:YES completion:NULL];
    }
    
    
}


-(void)editTapped{
    
    
    
    
    //if ([self.capturedPhotoes count] > 0) {
        

    NSMutableArray * editImages =[[NSMutableArray alloc]init];
    for (id obj in self.capturedPhotoes) {
        [editImages addObject:[obj fixOrientation]];
    }
    /*
    //method three
    EditViewContrller_Three *editController = [[EditViewContrller_Three alloc]initWithImages:editImages];
    [self.capturedPhotoes removeAllObjects];
    [self presentViewController:editController animated:YES
                     completion:NULL];
    */
    
    
    //another method
    ISLViewController *editController =[[ISLViewController alloc]initWithPictures:editImages] ;
    
    [self.capturedPhotoes removeAllObjects];
    [self presentViewController:editController animated:YES completion:NULL];
    
    
    
    /*one method
    ISLEditViewContollerViewController *editContoller = [[ISLEditViewContollerViewController alloc]initWithImages:editImages];//[self.capturedPhotoes objectAtIndex:0]];
    
    [self.capturedPhotoes removeAllObjects];
    
    [self presentViewController:editContoller animated:YES completion:NULL];
    */
    //}
}

#pragma mark -
#pragma mark toolbar actions


-(IBAction)takePhotoesFromAlbum:(id)sender{
    
    NSLog(@"now read photo from file");
    [self showImageSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(IBAction)cameraAction:(id)sender{
    [self showImageSource:UIImagePickerControllerSourceTypeCamera];
    
    
    
}
-(IBAction)savePhoto:(id)sender{
    
    NSLog(@"saved the photo to file");
}

#pragma mark -
#pragma mark overlayViewControllerDelegate

-(void)didFinishedTakePhoto:(UIImage *)photo{
    [self.capturedPhotoes addObject:photo];
}

-(void)doneWithCamera{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if ([self.capturedPhotoes count]>0) {
        
      
        
        if ([self.capturedPhotoes count] ==1) {
            [self.mainView setImage:[self.capturedPhotoes objectAtIndex:0]];
        }
        else if([self.capturedPhotoes count] == 3)
        {
            self.mainView.animationImages = self.capturedPhotoes;
            
            //if (self.capturedPhotoes.count >0) {
             //   [self.capturedPhotoes removeAllObjects];
            //}
            self.mainView.animationDuration = 7.0;
            
            self.mainView.animationRepeatCount = 0;
            [self.mainView startAnimating];
            
            // can be edit
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTapped)];
            [self.mainView addGestureRecognizer:tap];
            
        }
        
        
        
    }
    
  
    
}

















@end
