//
//  TTTGameState.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/24/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTGameState.h"
#import "TTTGameBoard.h"
#import "TTTConstants.h"

@implementation TTTGameState

- (instancetype)initWithGameBoard:(TTTGameBoard *)gameBoard
{
    self = [super init];
    
    if (self) {
        self.gameBoard = gameBoard;
    }
    
    return self;
}

- (TTTGameState *)newGameStateForType:(TTTBoardPiece)type withMove:(NSInteger)move
{
    TTTGameState *newGameState = [[TTTGameState alloc] init];
    newGameState.gameBoard = [self.gameBoard copyBoard];
    
    [newGameState makeMoveWith:type atIndex:move];
    
    return newGameState;
}

- (void)resetState
{
    [self.gameBoard resetBoard];
}

#pragma mark - Game movement

- (BOOL)isSlotOpen:(NSInteger)index
{
    return [self.gameBoard isSlotOpen:index];
}

- (void)makeMoveWith:(TTTBoardPiece)type atIndex:(NSInteger)index
{
    [self.gameBoard setPiece:type atIndex:index];
}

- (TTTBoardPiece)getPieceAtIndex:(NSInteger)index
{
    return [self.gameBoard pieceAtIndex:index];
}

- (NSArray *)getAvailableMoves
{
    NSMutableArray *moves = [NSMutableArray array];
    
    for (int i = 0; i < TTTGameBoardSize; i++) {
        if ([self.gameBoard isSlotOpen:i]) {
            [moves addObject:@(i)];
        }
    }
    
    return moves;
}

- (void)setPlayerTurn:(BOOL)truthVal
{
    self.isPlayerTurn = truthVal;
}

#pragma mark - End game

- (BOOL)isFinished
{
    for (int i = 0; i < TTTGameBoardSize; i++) {
        if ([self.gameBoard pieceAtIndex:i] == TTTBoardPieceNone) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)hasWonPlayer:(TTTBoardPiece)type
{
    return [self checkRowsForWinner] == type || [self checkColsForWinner] == type || [self checkDiagForWinner] == type;
}

- (TTTBoardPiece)checkRowsForWinner
{
    for (int i = 0; i < TTTGameBoardRows; i++) {
        int xCount = 0;
        int oCount = 0;
        
        for (int j = 0; j < TTTGameBoardCols; j++) {
            NSInteger currIndex = i * TTTGameBoardRows + j;
            
            TTTBoardPiece currPiece = [self.gameBoard pieceAtIndex:currIndex];
            
            if (currPiece == TTTBoardPieceX) {
                xCount++;
            }
            
            if (currPiece == TTTBoardPieceO) {
                oCount++;
            }
            
            if (xCount == 3) {
                return TTTBoardPieceX;
            }
            
            if (oCount == 3) {
                return TTTBoardPieceO;
            }
            
        }
    }
    
    return TTTBoardPieceNone;
}

- (TTTBoardPiece)checkColsForWinner
{
    for (int i = 0; i < TTTGameBoardCols; i++) {
        int xCount = 0;
        int oCount = 0;
        
        for (int j = 0; j < TTTGameBoardRows; j++) {
            NSInteger currIndex = i + j * 3;
            
            TTTBoardPiece currPiece = [self.gameBoard pieceAtIndex:currIndex];
            
            if (currPiece == TTTBoardPieceX) {
                xCount++;
            }
            
            if (currPiece == TTTBoardPieceO) {
                oCount++;
            }
            
            if (xCount == 3) {
                return TTTBoardPieceX;
            }
            
            if (oCount == 3) {
                return TTTBoardPieceO;
            }
            
        }
    }
    
    return TTTBoardPieceNone;
}

- (TTTBoardPiece)checkDiagForWinner
{
    // Upper left to lower right
    int xCount = 0;
    int oCount = 0;
    
    for (int i = 0; i < 9; i += 4) {
        TTTBoardPiece currPiece = [self.gameBoard pieceAtIndex:i];
        
        if (currPiece == TTTBoardPieceX) {
            xCount++;
        }
        
        if (currPiece == TTTBoardPieceO) {
            oCount++;
        }
        
        if (xCount == 3) {
            return TTTBoardPieceX;
        }
        
        if (oCount == 3) {
            return TTTBoardPieceO;
        }
    }
    
    xCount = 0;
    oCount = 0;
    
    // Upper right to lower left
    for (int i = 2; i < 7; i += 2) {
        TTTBoardPiece currPiece = [self.gameBoard pieceAtIndex:i];
        
        if (currPiece == TTTBoardPieceX) {
            xCount++;
        }
        
        if (currPiece == TTTBoardPieceO) {
            oCount++;
        }
        
        if (xCount == 3) {
            return TTTBoardPieceX;
        }
        
        if (oCount == 3) {
            return TTTBoardPieceO;
        }
    }
    
    return TTTBoardPieceNone;
}

- (NSInteger)scoreAtDepth:(NSInteger)depth
{
    if ([self hasWonPlayer:TTTBoardPieceX]) {
        return 10 - depth;
    } else if ([self hasWonPlayer:TTTBoardPieceO]) {
        return depth - 10;
    } else {
        return 0;
    }
}


@end
