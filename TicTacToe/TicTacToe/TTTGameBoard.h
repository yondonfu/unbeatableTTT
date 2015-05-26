//
//  TTTGameBoard.h
//  TicTacToe
//
//  Created by Yondon Fu on 5/23/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTConstants.h"

@interface TTTGameBoard : NSObject

@property (strong, nonatomic) NSMutableArray *gameMatrix;

- (void)setPiece:(TTTBoardPiece)type atIndex:(NSInteger)index;
- (BOOL)isSlotOpen:(NSInteger)index;
- (void)resetBoard;

@end
