//
//  TTTGridView.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/21/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTGridView.h"

@implementation TTTGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        tapRecognizer.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:tapRecognizer];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int xStart = 0;
    int yStart = 0;
    int gridSize = 300;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Vertical lines
    for (int x = 1; x <= 2; x++) {
        int xPos = xStart + x * gridSize / 3;
        [path moveToPoint:CGPointMake(xPos, yStart)];
        [path addLineToPoint:CGPointMake(xPos, yStart + gridSize)];
    }
    
    // Horizontal lines
    for (int y = 1; y <= 2; y++) {
        int yPos = yStart + y * gridSize / 3;
        [path moveToPoint:CGPointMake(xStart, yPos)];
        [path addLineToPoint:CGPointMake(xStart + gridSize, yPos)];
    }
    
    [[UIColor grayColor] setStroke];
    
    [path stroke];
}

- (void)singleTap:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Single Tap");
    CGPoint tapLoc = [gestureRecognizer locationInView:self];
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(tapLoc.x, tapLoc.y, 60, 60)];
    circleView.alpha = 0.5;
    circleView.layer.cornerRadius = 30;
    circleView.backgroundColor = [UIColor blueColor];
    [self addSubview:circleView];
}

@end
