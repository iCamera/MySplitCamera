//
//  ISLOverlayViewController.h
//  MySplitCamera
//
//  Created by alvin zheng on 5/29/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
@protocol ISLOverlayViewControllerDelegate;
@interface ISLOverlayViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, assign) id <ISLOverlayViewControllerDelegate> delegate;


-(void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType;
 



@end
@protocol ISLOverlayViewControllerDelegate
-(void)didFinishedTakePhoto:(UIImage *)photo;
-(void)doneWithCamera;



@end