//
//  Jigaw.m
//  MySplitCamera
//
//  Created by alvin zheng on 5/30/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "Jigaw.h"

@implementation Jigaw

-(id)initWithImages:(NSArray *)images{
    
    if (self = [super init]) {
        self.rawPictures = [images copy];
    }
    return self;
}



-(UIImage *)combineImageWithRectOne:(CGRect)zoneOne zoneTwo:(CGRect)zoneTwo zoneThree:(CGRect)zoneThree{
    
    UIImage *newImage = nil;
    zoneTwo.origin.x =zoneTwo.origin.x - 0.01;
    zoneTwo.size.width = zoneTwo.size.width + 0.02;
    
    zoneThree.origin.x = zoneThree.origin.x - 0.02;
    zoneThree.size.width += 0.03;
    
    if ([self.rawPictures count] == 3) {
         UIImage    *imageOne = [[self.rawPictures objectAtIndex:0]
                                                               imageAtRect:zoneOne];
         UIImage    *imageTwo = [[self.rawPictures objectAtIndex:1]
                                                               imageAtRect:zoneTwo];
         UIImage    *imageThree = [[self.rawPictures objectAtIndex:2]
                                                               imageAtRect:zoneThree];
        
        CGSize totalSize = CGSizeZero;
        totalSize.width  = zoneOne.size.width + zoneTwo.size.width +zoneThree.size.width;
        totalSize.height = zoneOne.size.height;//(zoneOne.size.height + zoneTwo.size.height + zoneThree.size.height)/3;
        
        CGPoint originP = CGPointMake(0.0, 0.0);

        UIGraphicsBeginImageContext(totalSize);
        
        CGRect totalRect = CGRectZero;
        totalRect.origin = originP;
        totalRect.size = totalSize;
        CGRect subRectOne = zoneOne;
        CGRect subRectTwo = zoneTwo;
        CGRect subRectThree = zoneThree;
        
        [imageOne drawInRect:subRectOne];
        [imageTwo drawInRect:subRectTwo];
        [imageThree drawInRect:subRectThree];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
             
    }
    
    return newImage;
    
}


@end
