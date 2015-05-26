//
//  TTTGameBoard.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/23/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTGameBoard.h"
#import "TTTConstants.h"

@implementation TTTGameBoard

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self resetBoard];
    }
    
    return self;
}

- (BOOL)isSlotOpen:(NSInteger)index
{
    return [self pieceAtIndex:index] == TTTBoardPieceNone;
}

- (void)setPiece:(TTTBoardPiece)type atIndex:(NSInteger)index
{
    if (index < 0 || index > TTTGameBoardSize) {
        NSLog(@"Index out of bounds for game board");
    } else if (![self isSlotOpen:index]) {
        NSLog(@"Slot on game board is already occupied");
    } else {
        self.gameMatrix[index] = @(type);
    }
}

- (TTTBoardPiece)pieceAtIndex:(NSInteger)index
{
    if (index < 0 || index > TTTGameBoardSize) {
        NSLog(@"Index out of bounds for game board");
        return -1;
    }
    
    return [self.gameMatrix[index] intValue];
}


- (void)resetBoard
{
    NSMutableArray *slots = [NSMutableArray array];
    
    for (int i = 0; i < TTTGameBoardSize; i++) {
        [slots addObject:@(TTTBoardPieceNone)];
    }
    
    self.gameMatrix = slots;
}

- (TTTGameBoard *)copyBoard
{
    TTTGameBoard *newBoard = [[TTTGameBoard alloc] init];
    
    NSMutableArray *slots = [NSMutableArray array];
    
    for (int i = 0; i < TTTGameBoardSize; i++) {
        [slots addObject:[self.gameMatrix objectAtIndex:i]];
    }
    
    newBoard.gameMatrix = slots;
    
    return newBoard;
}

@end
