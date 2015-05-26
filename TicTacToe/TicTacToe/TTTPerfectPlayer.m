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



- (void)takeTurn
{
    if (![[TTTGamePlayController sharedInstance].currGameState isFinished]) {
        NSInteger move = [self chooseMove];
        
        [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceO atIndex:move];
    }
}

- (NSInteger)chooseMove
{
    return [self minimax:[TTTGamePlayController sharedInstance].currGameState atDepth:0];
}

- (NSInteger)minimax:(TTTGameState *)game atDepth:(NSInteger)depth
{
    if (![[TTTGamePlayController sharedInstance].currGameState isFinished]) {
        return [game scoreAtDepth:depth];
    }
    
    NSMutableArray *scores = [NSMutableArray array];
    NSMutableArray *moves = [NSMutableArray array];
    
    depth += 1;
    
    NSArray *availableMoves = [game getAvailableMoves];
    
    for (int i = 0; i < availableMoves.count; i++) {
        TTTGameState *possibleGameState = [game newGameStateForType:TTTBoardPieceX withMove:[[availableMoves objectAtIndex:i] intValue]];
        
        [scores insertObject:@([self minimax:possibleGameState atDepth:depth]) atIndex:0];
        [moves insertObject:[availableMoves objectAtIndex:i] atIndex:0];
    }
    
    if (game.isPlayerTurn) {
        __block NSUInteger maxIndex;
        __block NSNumber *maxValue = [NSNumber numberWithInt:0];
        
        [scores enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *newValue = obj;
            if ([newValue intValue] > [newValue intValue]) {
                maxValue = newValue;
                maxIndex = idx;
            }
        }];
        
        self.nextMove = maxIndex;
        
        return [maxValue intValue];
    } else {
        __block NSUInteger minIndex;
        __block NSNumber *minValue = [NSNumber numberWithInt:0];
        
        [scores enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *newValue = obj;
            if ([newValue intValue] < [newValue intValue]) {
                minValue = newValue;
                minIndex = idx;
            }
        }];
        
        self.nextMove = minIndex;
        
        return [minValue intValue];
    }
}


@end
