//
//  TTTXView.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/22/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTXView.h"

@implementation TTTXView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(bounds.origin.x, bounds.origin.y)];
    [path addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height)];
    
    [path moveToPoint:CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height)];
    [path addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y)];
    
    path.lineWidth = 10;
    
    [[UIColor lightGrayColor] setStroke];
    
    [path stroke];
}

@end
