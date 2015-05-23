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

- (BOOL)isFinished
{
    for (int i = 0; i < TTTGameBoardSize; i++) {
        if ([self.gameBoard.gameMatrix[i] intValue] == TTTBoardPieceNone) {
            return NO;
        }
    }
    
    return YES;
}

@end
