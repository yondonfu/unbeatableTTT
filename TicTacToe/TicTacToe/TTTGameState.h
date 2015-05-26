//
//  TTTGameState.h
//  TicTacToe
//
//  Created by Yondon Fu on 5/24/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTConstants.h"
#import "TTTGameBoard.h"

@interface TTTGameState : NSObject

@property (strong, nonatomic) TTTGameBoard *gameBoard;
@property (assign, nonatomic) BOOL isPlayerTurn;

- (instancetype)initWithGameBoard:(TTTGameBoard *)gameBoard;
- (TTTGameState *)newGameStateForType:(TTTBoardPiece)type withMove:(NSInteger)move;
- (void)resetState;
- (BOOL)isSlotOpen:(NSInteger)index;
- (void)makeMoveWith:(TTTBoardPiece)type atIndex:(NSInteger)index;
- (TTTBoardPiece)getPieceAtIndex:(NSInteger)index;
- (NSArray *)getAvailableMoves;
- (void)setPlayerTurn:(BOOL)truthVal;
- (BOOL)isFinished;
- (BOOL)hasWonPlayer:(TTTBoardPiece)type;
- (NSInteger)scoreAtDepth:(NSInteger)depth;

@end
