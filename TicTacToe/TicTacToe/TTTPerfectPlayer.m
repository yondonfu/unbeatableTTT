//
//  TTTPerfectPlayer.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/24/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTPerfectPlayer.h"
#import "TTTGamePlayController.h"

@implementation TTTPerfectPlayer

- (void)takeTurn
{
    if (![[TTTGamePlayController sharedInstance] isFinished]) {
        
    }
}

//- (NSInteger)minimaxAtDepth:(int)depth
//{
//    if (![[TTTGamePlayController sharedInstance] isFinished]) {
//        return [[TTTGamePlayController sharedInstance] scoreAtDepth:depth];
//    }
//    
//    NSMutableArray *scores = [NSMutableArray array];
//    NSMutableArray *moves = [NSMutableArray array];
//    
//    depth += 1;
//    
//    NSArray *availableMoves = [[TTTGamePlayController sharedInstance] getAvailableMoves];
//    
//    for (int i = 0; i < availableMoves.count; i++) {
//        
//    }
//}


@end
