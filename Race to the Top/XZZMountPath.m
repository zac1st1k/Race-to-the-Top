//
//  XZZMountPath.m
//  Race to the Top
//
//  Created by Zac on 1/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZMountPath.h"

@implementation XZZMountPath

+ (NSArray *)mountainPathsForRect:(CGRect)rect;
{
    NSMutableArray *variousPaths = [@[] mutableCopy];
    CGPoint firstPoint = CGPointMake(rect.size.width * (1/6.0), CGRectGetMaxY(rect));
    CGPoint secondPoint = CGPointMake(rect.size.width * (1/3.0), rect.size.height * (5/6.0));
    UIBezierPath *labyrinthPath = [UIBezierPath bezierPath];
    labyrinthPath.lineWidth = 4.0;
    [labyrinthPath moveToPoint:firstPoint];
    [labyrinthPath addLineToPoint:secondPoint];
    [variousPaths addObject:labyrinthPath];
    
    return variousPaths;
}

@end
