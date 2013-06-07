//
//  ISLmyView.h
//  Excersize
//
//  Created by alvin zheng on 5/31/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ISLmyView : UIView <UIScrollViewDelegate>

@property UIScrollView *scrollView;
@property UIImageView *imageView;
//@property UIImage     *image;
//@property UIToolbar   *toolBar;

-(id)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

@end
