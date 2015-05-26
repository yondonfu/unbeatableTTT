//
//  TTTGamePlayController.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/23/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTGamePlayController.h"
#import "TTTGameBoard.h"
#import "TTTConstants.h"

@interface TTTGamePlayController ()

@property (strong, nonatomic) TTTGameBoard *gameBoard;

@end

@implementation TTTGamePlayController

+ (instancetype)sharedInstance
{
    static TTTGamePlayController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TTTGamePlayController alloc] init];
    });
    
    return sharedInstance;
}

- (void)startGame
{
    self.gameBoard = [[TTTGameBoard alloc] init];
    NSLog(@"%@", self.gameBoard.gameMatrix);
}

- (void)resetGame
{
    [self.gameBoard resetBoard];
}

- (void)setPiece:(TTTBoardPiece)type atIndex:(NSInteger)index
{
    [self.gameBoard setPiece:type atIndex:index];
    
    NSLog(@"%@", self.gameBoard.gameMatrix);
}


- (BOOL)isFinished
{
    for (int i = 0; i < TTTGameBoardSize; i++) {
        if ([self.gameBoard.gameMatrix[i] intValue] == TTTBoardPieceNone) {
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
            
            TTTBoardPiece currPiece = [self.gameBoard.gameMatrix[currIndex] intValue];
            
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
            
            TTTBoardPiece currPiece = [self.gameBoard.gameMatrix[currIndex] intValue];
            
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
        TTTBoardPiece currPiece = [self.gameBoard.gameMatrix[i] intValue];
        
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
        TTTBoardPiece currPiece = [self.gameBoard.gameMatrix[i] intValue];
        
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

- (NSInteger)scoreAtDepth:(int)depth
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
