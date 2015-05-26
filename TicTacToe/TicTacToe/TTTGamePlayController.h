//
//  TTTGamePlayController.h
//  TicTacToe
//
//  Created by Yondon Fu on 5/23/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTConstants.h"
#import "TTTGameState.h"
#import "TTTPerfectPlayer.h"

@interface TTTGamePlayController : NSObject

@property (strong, nonatomic) TTTGameState *currGameState;
@property (strong, nonatomic) TTTPerfectPlayer *perfectComputer;

+ (instancetype)sharedInstance;
- (void)startGameWithPlayer:(BOOL)playerFirst;
- (void)resetGame;

@end
