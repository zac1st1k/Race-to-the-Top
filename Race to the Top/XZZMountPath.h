//
//  XZZMountPath.h
//  Race to the Top
//
//  Created by Zac on 1/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZZMountPath : NSObject

+ (NSArray *)mountainPathsForRect:(CGRect)rect;

+ (UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;

@end
