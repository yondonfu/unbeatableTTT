//
//  TTTConstants.h
//  TicTacToe
//
//  Created by Yondon Fu on 5/23/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSInteger TTTGameBoardSize;
extern const NSInteger TTTGameBoardRows;
extern const NSInteger TTTGameBoardCols;

typedef NS_ENUM(NSInteger, TTTBoardPiece) {
    TTTBoardPieceNone = 0,
    TTTBoardPieceO = 1,
    TTTBoardPieceX = 2
};
