//
//  TTTPerfectPlayer.h
//  TicTacToe
//
//  Created by Yondon Fu on 5/24/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTGameState.h"

@interface TTTPerfectPlayer : NSObject

- (NSInteger)minimax:(TTTGameState *)game atDepth:(NSInteger)depth;

@end
