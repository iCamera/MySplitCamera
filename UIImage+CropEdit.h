//
//  UIImage+CropEdit.h
//  MySplitCamera
//
//  Created by alvin zheng on 5/30/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CropEdit)

-(UIImage *)imageAtRect:(CGRect)rect;
//-(UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
//-(UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
//-(UIImage *)imageByScalingToSize:(CGSize)targetSize;
//-(UIImage *)imageRotateByRadians:(CGFloat)radians;
//-(UIImage *)imageRotateByDegree:(CGFloat)degree;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

@end
