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
    if ([game isFinished]) {
        return [game scoreAtDepth:depth];
    }
    
//    depth += 1;
    
    NSArray *availableMoves = [game getAvailableMoves];
    NSLog(@"Available moves: %lu", availableMoves.count);
    
    NSMutableArray *childrenGameStates = [NSMutableArray array];
    NSMutableArray *choices = [NSMutableArray array];
    
    for (NSNumber *move in availableMoves) {
        TTTGameState *possibleGameState = nil;
        if (game.isPlayerTurn) {
            possibleGameState = [game newGameStateForType:TTTBoardPieceX withMove:[move intValue]];
            [game setIsPlayerTurn:NO];
        } else {
            possibleGameState = [game newGameStateForType:TTTBoardPieceO withMove:[move intValue]];
            [game setIsPlayerTurn:YES];
        }
        
        [childrenGameStates insertObject:possibleGameState atIndex:0];
        [choices insertObject:move atIndex:0];
    }
    
    if (game.isPlayerTurn) {
        NSInteger bestScore = -INFINITY;
        NSInteger bestIndex = 0;
        
        for (int i = 0; i < childrenGameStates.count; i++) {
            NSInteger score = [self minimax:[childrenGameStates objectAtIndex:i] atDepth:depth];
            if (score > bestScore) {
                bestScore = score;
                NSLog(@"Score change: %lu", bestScore);
                bestIndex = i;
            }
        }
        
        self.nextMove = [[choices objectAtIndex:bestIndex] intValue];
        
        return bestScore;
        
    } else {
        NSInteger bestScore = INFINITY;
        NSInteger bestIndex = 0;
        
        for (int i = 0; i < childrenGameStates.count; i++) {
            NSInteger score = [self minimax:[childrenGameStates objectAtIndex:i] atDepth:depth];
            if (score < bestScore) {
                bestScore = score;
                NSLog(@"Score change: %lu", bestScore);
                bestIndex = i;
            }
        }
        
        self.nextMove = [[choices objectAtIndex:bestIndex] intValue];
        
        return bestScore;
    }
    
//    NSMutableArray *scores = [NSMutableArray array];
//    NSMutableArray *moves = [NSMutableArray array];
//    
//    depth += 1;
//    
//    NSArray *availableMoves = [game getAvailableMoves];
//    NSLog(@"Available moves: %@", availableMoves);
//    
//    for (int i = 0; i < availableMoves.count; i++) {
//        TTTGameState *possibleGameState = [game newGameStateForType:TTTBoardPieceX withMove:[[availableMoves objectAtIndex:i] intValue]];
//        
//        [scores insertObject:@([self minimax:possibleGameState atDepth:depth]) atIndex:0];
//        [moves insertObject:[availableMoves objectAtIndex:i] atIndex:0];
//    }
//    
//    if (game.isPlayerTurn) {
//        __block NSUInteger maxIndex;
//        __block NSNumber *maxValue = [NSNumber numberWithInt:0];
//        
//        [scores enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            NSNumber *newValue = obj;
//            if ([newValue intValue] > [newValue intValue]) {
//                maxValue = newValue;
//                maxIndex = idx;
//            }
//        }];
//        
//        NSLog(@"maxIndex %lu", maxIndex);
//        self.nextMove = [[moves objectAtIndex:maxIndex] intValue];
//        
//        return [maxValue intValue];
//    } else {
//        NSLog(@"size of scores %lu", scores.count);
//        __block NSUInteger minIndex;
//        __block NSNumber *minValue = [NSNumber numberWithInt:0];
//        
//        [scores enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            NSNumber *newValue = obj;
//            if ([newValue intValue] < [newValue intValue]) {
//                minValue = newValue;
//                minIndex = idx;
//            }
//        }];
//        
//        NSLog(@"minIndex %lu", minIndex);
//        self.nextMove = [[moves objectAtIndex:minIndex] intValue];
//        
//        return [minValue intValue];
//    }
}


@end
