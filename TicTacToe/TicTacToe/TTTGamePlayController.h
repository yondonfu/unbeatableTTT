//
//  TTTGamePlayController.h
//  TicTacToe
//
//  Created by Yondon Fu on 5/23/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTConstants.h"

@interface TTTGamePlayController : NSObject

+ (instancetype)sharedInstance;
- (void)startGame;
- (void)setPiece:(TTTBoardPiece)type atIndex:(NSInteger)index;
- (BOOL)isFinished;
- (BOOL)hasWonPlayer:(TTTBoardPiece)type;
- (NSArray *)getAvailableMoves;
- (NSInteger)scoreAtDepth:(int)depth;

@end
