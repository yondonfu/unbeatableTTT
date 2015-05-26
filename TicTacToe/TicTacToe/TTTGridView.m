//
//  TTTGridView.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/21/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTGridView.h"
#import "TTTCircleView.h"
#import "TTTXView.h"
#import "TTTGamePlayController.h"

@implementation TTTGridView

- (void)drawRect:(CGRect)rect
{
    int xStart = 0;
    int yStart = 0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Vertical lines
    for (int x = 1; x <= 2; x++) {
        int xPos = xStart + x * kCellSize;
        [path moveToPoint:CGPointMake(xPos, yStart)];
        [path addLineToPoint:CGPointMake(xPos, yStart + kGridSize)];
    }
    
    // Horizontal lines
    for (int y = 1; y <= 2; y++) {
        int yPos = yStart + y * kCellSize;
        [path moveToPoint:CGPointMake(xStart, yPos)];
        [path addLineToPoint:CGPointMake(xStart + kGridSize, yPos)];
    }
    
    [[UIColor grayColor] setStroke];
    
    [path stroke];
}

- (void)clearGrid
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
