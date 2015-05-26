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
#import "TTTGameState.h"
#import "TTTPerfectPlayer.h"

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

- (void)startGameWithPlayer:(BOOL)playerFirst
{
    TTTGameBoard *gameBoard = [[TTTGameBoard alloc] init];
    self.currGameState = [[TTTGameState alloc] initWithGameBoard:gameBoard];
    
    self.perfectComputer = [[TTTPerfectPlayer alloc] init];

    [self.currGameState setPlayerTurn:playerFirst];
    
    NSLog(@"%@", self.currGameState.gameBoard.gameMatrix);

}

- (void)resetGame
{
    [self.currGameState resetState];
}


@end
