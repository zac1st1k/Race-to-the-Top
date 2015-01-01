//
//  XZZPathView.m
//  Race to the Top
//
//  Created by Zac on 1/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZPathView.h"
#import "XZZMountPath.h"

@implementation XZZPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    for (UIBezierPath *path in [XZZMountPath mountainPathsForRect:self.bounds]) {
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}

@end
