//
//  TTTPerfectPlayer.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/24/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTPerfectPlayer.h"
#import "TTTGamePlayController.h"
#import "TTTGameState.h"

@interface TTTPerfectPlayer ()

@property (assign, nonatomic) NSInteger nextMove;

@end

@implementation TTTPerfectPlayer

- (NSInteger)takeTurn
{
    if (![[TTTGamePlayController sharedInstance].currGameState isFinished]) {
        NSLog(@"Best score for move: %lu", [self chooseMove]);
        
        [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceO atIndex:self.nextMove];
        
        return self.nextMove;
    }
    
    return -1;
}

- (NSInteger)chooseMove
{
    return [self minimax:[TTTGamePlayController sharedInstance].currGameState atDepth:0];
}

- (NSInteger)minimax:(TTTGameState *)game atDepth:(NSInteger)depth
{
    if ([game hasWonPlayer:TTTBoardPieceX] || [game hasWonPlayer:TTTBoardPieceO] || [game isFinished]) {
        return [game scoreAtDepth:depth];
    }
    
    depth += 1;
    
    NSMutableArray *gameStates = [NSMutableArray array];
    NSMutableArray *choices = [NSMutableArray array];
    
    for (NSNumber *move in [game getAvailableMoves]) {
        TTTGameState *possibleState;
        if (game.isPlayerTurn) {
            possibleState = [game newGameStateForType:TTTBoardPieceX withMove:[move intValue]];
            [possibleState setIsPlayerTurn:NO];
        } else {
            possibleState = [game newGameStateForType:TTTBoardPieceO withMove:[move intValue]];
            [possibleState setIsPlayerTurn:YES];
        }
        
        [gameStates addObject:possibleState];
        [choices addObject:move];
    }
    
    if (game.isPlayerTurn) {
        NSInteger maxScore = -INFINITY;
        NSInteger maxIndex = 0;
        
        for (int i = 0; i < gameStates.count; i++) {
            NSInteger score = [self minimax:[gameStates objectAtIndex:i] atDepth:depth];
            if (score > maxScore) {
                maxScore = score;
                maxIndex = i;
            }
        }
        
        self.nextMove = [[choices objectAtIndex:maxIndex] intValue];
        
        return maxScore;
        
    } else {
        NSInteger minScore = INFINITY;
        NSInteger minIndex = 0;
        
        for (int i = 0; i < gameStates.count; i++) {
            NSInteger score = [self minimax:[gameStates objectAtIndex:i] atDepth:depth];
            if (score < minScore) {
                minScore = score;
                minIndex = i;
            }
        }
        
        self.nextMove = [[choices objectAtIndex:minIndex] intValue];
        
        return minScore;
        
    }    
}


@end
