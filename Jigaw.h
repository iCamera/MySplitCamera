//
//  Jigaw.h
//  MySplitCamera
//
//  Created by alvin zheng on 5/30/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+CropEdit.h"
@interface Jigaw : NSObject


@property (nonatomic,strong) NSMutableArray *rawPictures;
//@property (nonatomic,assign) NSInteger regionCount;

///-(NSInteger)regionCount;
//-(CGFloat)regionWidth;
-(id)initWithImages:(NSArray *)images;
-(UIImage *)combineImageWithRectOne:(CGRect)zoneOne zoneTwo:(CGRect)zoneTwo zoneThree:(CGRect)zoneThree;


@end
