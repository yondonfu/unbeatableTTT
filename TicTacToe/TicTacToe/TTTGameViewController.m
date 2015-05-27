//
//  TTTGameViewController.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/21/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTGameViewController.h"
#import "TTTGridView.h"
#import "TTTCircleView.h"
#import "TTTXView.h"
#import "TTTCircleView.h"
#import "TTTGamePlayController.h"

@interface TTTGameViewController ()

@property (strong, nonatomic) TTTGridView *gridView;
@property (strong, nonatomic) UILabel *playerLabel;
@property (strong, nonatomic) TTTXView *playerIcon;
@property (strong, nonatomic) UILabel *computerLabel;
@property (strong, nonatomic) TTTCircleView *computerIcon;
@property (strong, nonatomic) UILabel *promptLabel;

@end

@implementation TTTGameViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    
    return self;
}

- (void)setupView
{
    self.gridView = [[TTTGridView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.gridView setBackgroundColor:[UIColor whiteColor]];
    self.gridView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:self.gridView];
    
    self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    self.promptLabel.text = @"Select who goes first:";
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    self.promptLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    self.promptLabel.center = CGPointMake(self.view.center.x, self.gridView.center.y + self.gridView.bounds.size.height / 2 + 30);
    [self.view addSubview:self.promptLabel];
    
    self.computerIcon = [[TTTCircleView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 20, self.promptLabel.center.y + 20, 30, 30)];
    [self.view addSubview:self.computerIcon];
    
    self.computerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 20, self.computerIcon.center.y, 100, 70)];
    self.computerLabel.text = @"You";
    self.computerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.computerLabel setUserInteractionEnabled:YES];
    [self.view addSubview:self.computerLabel];
    
    UITapGestureRecognizer *computerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectComputer:)];
    [self.computerLabel addGestureRecognizer:computerRecognizer];
    
    self.playerIcon = [[TTTXView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + self.view.bounds.size.width - 50, self.promptLabel.center.y + 20, 30, 30)];
    [self.view addSubview:self.playerIcon];
    
    self.playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + self.view.bounds.size.width - 120, self.playerIcon.center.y, 100, 70)];
    self.playerLabel.text = @"Me";
    self.playerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    self.playerLabel.textAlignment = NSTextAlignmentRight;
    [self.playerLabel setUserInteractionEnabled:YES];
    [self.view addSubview:self.playerLabel];
    
    UITapGestureRecognizer *playerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPlayer:)];
    [self.playerLabel addGestureRecognizer:playerRecognizer];
    
}

- (void)selectComputer:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Selected computer");
    self.computerLabel.textColor = [UIColor blueColor];
    self.playerLabel.textColor = [UIColor blackColor];
    
    [[TTTGamePlayController sharedInstance] startGameWithPlayer:NO];
    
    [self.gridView clearGrid];
    
    UITapGestureRecognizer *gridRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleGridTap:)];
    [self.gridView addGestureRecognizer:gridRecognizer];
}

- (void)selectPlayer:(UITapGestureRecognizer *)recgonizer
{
    NSLog(@"Selected player");
    self.playerLabel.textColor = [UIColor blueColor];
    self.computerLabel.textColor = [UIColor blackColor];
    
    [[TTTGamePlayController sharedInstance] startGameWithPlayer:YES];
    
    [self.gridView clearGrid];
    
    UITapGestureRecognizer *gridRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleGridTap:)];
    [self.gridView addGestureRecognizer:gridRecognizer];
}

- (void)singleGridTap:(UIGestureRecognizer *)gestureRecognizer
{
    if ([TTTGamePlayController sharedInstance].currGameState.isPlayerTurn) {
        CGPoint tapLoc = [gestureRecognizer locationInView:self.gridView];
        
        TTTXView *xView = [[TTTXView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        if (tapLoc.x > 0 && tapLoc.x < kCellSize) {
            if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
                NSLog(@"Top left");
                
                xView.center = CGPointMake(kCellSize / 2, kCellSize / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:0];
                
            } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
                NSLog(@"Middle left");
                
                xView.center = CGPointMake(kCellSize / 2, (kCellSize + (2 * kCellSize)) / 2);
            
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:3];
                
            } else {
                NSLog(@"Bottom left");
                
                xView.center = CGPointMake(kCellSize / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:6];
            }
        } else if (tapLoc.x > kCellSize && tapLoc.x < 2 * kCellSize) {
            if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
                NSLog(@"Top middle");
                
                xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, kCellSize / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:1];
                
            } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
                NSLog(@"Middle middle");
                
                xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:4];
                
            } else {
                NSLog(@"Bottom middle");
                
                xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:7];
                
            }
        } else {
            if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
                NSLog(@"Top right");
                
                xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, kCellSize / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:2];
                
            } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
                NSLog(@"Middle right");
                
                xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:5];
                
            } else {
                NSLog(@"Bottom right");
                
                xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
                
                [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:8];
                
            }
        }
        
        [self.gridView addSubview:xView];
        
        [[TTTGamePlayController sharedInstance].currGameState setPlayerTurn:NO];
        
        if ([[TTTGamePlayController sharedInstance].currGameState isFinished]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Draw" message:@"Better luck next time!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.gridView clearGrid];
                [[TTTGamePlayController sharedInstance] resetGame];
            }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            NSLog(@"Board filled, removing gesture recognizer");
            [self.gridView removeGestureRecognizer:gestureRecognizer];
            
            self.playerLabel.textColor = [UIColor blackColor];
            self.computerLabel.textColor = [UIColor blackColor];
        }
        
        if ([[TTTGamePlayController sharedInstance].currGameState hasWonPlayer:TTTBoardPieceX]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:@"You Won!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.gridView clearGrid];
                [[TTTGamePlayController sharedInstance] resetGame];
            }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            [self.gridView removeGestureRecognizer:gestureRecognizer];
            
            self.playerLabel.textColor = [UIColor blackColor];
            self.computerLabel.textColor = [UIColor blackColor];
        }
        
        if ([[TTTGamePlayController sharedInstance].currGameState hasWonPlayer:TTTBoardPieceO]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"The computer Won" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.gridView clearGrid];
                [[TTTGamePlayController sharedInstance] resetGame];
            }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            [self.gridView removeGestureRecognizer:gestureRecognizer];
            
            self.playerLabel.textColor = [UIColor blackColor];
            self.computerLabel.textColor = [UIColor blackColor];
        }
        
        [self computerResponse];

    }
    
}

- (void)computerResponse
{
    if (![TTTGamePlayController sharedInstance].currGameState.isPlayerTurn) {
        NSInteger move = [[TTTGamePlayController sharedInstance].perfectComputer takeTurn];
        NSLog(@"Computer response: %lu", move);
        
        TTTCircleView *oView = [[TTTCircleView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        if (move == 0) {
            oView.center = CGPointMake(kCellSize / 2, kCellSize / 2);
        } else if (move == 1) {
            oView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, kCellSize / 2);
        } else if (move == 2) {
            oView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, kCellSize / 2);
        } else if (move == 3) {
            oView.center = CGPointMake(kCellSize / 2, (kCellSize + (2 * kCellSize)) / 2);
        } else if (move == 4) {
            oView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
        } else if (move == 5) {
            oView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
        } else if (move == 6) {
            oView.center = CGPointMake(kCellSize / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
        } else if (move == 7) {
            oView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
        } else if (move == 8) {
            oView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
        }
        
        [self.gridView addSubview:oView];
        
        [[TTTGamePlayController sharedInstance].currGameState setPlayerTurn:YES];
    }
    
    
}




@end
