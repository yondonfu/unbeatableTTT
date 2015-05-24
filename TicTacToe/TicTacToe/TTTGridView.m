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

- (void)allowTaps
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tapRecognizer];
}

- (void)singleTap:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint tapLoc = [gestureRecognizer locationInView:self];
    
    TTTXView *xView = [[TTTXView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    if (tapLoc.x > 0 && tapLoc.x < kCellSize) {
        if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
            NSLog(@"Top left");
            
            xView.center = CGPointMake(kCellSize / 2, kCellSize / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:0];
            
        } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
            NSLog(@"Middle left");
            
            xView.center = CGPointMake(kCellSize / 2, (kCellSize + (2 * kCellSize)) / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:3];
            
        } else {
            NSLog(@"Bottom left");
            
            xView.center = CGPointMake(kCellSize / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:6];
        }
    } else if (tapLoc.x > kCellSize && tapLoc.x < 2 * kCellSize) {
        if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
            NSLog(@"Top middle");
            
            xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, kCellSize / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:1];
            
        } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
            NSLog(@"Middle middle");
            
            xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:4];
            
        } else {
            NSLog(@"Bottom middle");
            
            xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:7];
            
        }
    } else {
        if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
            NSLog(@"Top right");
            
            xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, kCellSize / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:2];
            
        } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
            NSLog(@"Middle right");
            
            xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:5];
            
        } else {
            NSLog(@"Bottom right");
            
            xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
            
            [[TTTGamePlayController sharedInstance] setPiece:TTTBoardPieceX atIndex:8];
            
        }
    }
    
    [self addSubview:xView];
    
    if ([[TTTGamePlayController sharedInstance] isFinished]) {
        NSLog(@"Board filled, removing gesture recognizer");
        [self removeGestureRecognizer:gestureRecognizer];
    }
    
}

@end
