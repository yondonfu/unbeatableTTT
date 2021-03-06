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

@property (strong, nonatomic) UIGestureRecognizer *gridTapRecognizer;
@property (strong, nonatomic) UIGestureRecognizer *computerRecognizer;
@property (strong, nonatomic) UIGestureRecognizer *playerRecognizer;

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
    
    self.computerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectComputer:)];
    [self.computerIcon addGestureRecognizer:self.computerRecognizer];
    [self.computerLabel addGestureRecognizer:self.computerRecognizer];
    
    self.playerIcon = [[TTTXView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + self.view.bounds.size.width - 50, self.promptLabel.center.y + 20, 30, 30)];
    [self.view addSubview:self.playerIcon];
    
    self.playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + self.view.bounds.size.width - 120, self.playerIcon.center.y, 100, 70)];
    self.playerLabel.text = @"Me";
    self.playerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    self.playerLabel.textAlignment = NSTextAlignmentRight;
    [self.playerLabel setUserInteractionEnabled:YES];
    [self.view addSubview:self.playerLabel];
    
    self.playerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPlayer:)];
    [self.playerIcon addGestureRecognizer:self.playerRecognizer];
    [self.playerLabel addGestureRecognizer:self.playerRecognizer];
    
}

- (void)selectComputer:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Selected computer");
    self.computerLabel.textColor = [UIColor blueColor];
    self.playerLabel.textColor = [UIColor blackColor];
    
    [[TTTGamePlayController sharedInstance] startGameWithPlayer:NO];
    
    [self.gridView clearGrid];
    
    self.gridTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleGridTap:)];
    [self.gridView addGestureRecognizer:self.gridTapRecognizer];
    
    [self computerResponse];
}

- (void)selectPlayer:(UITapGestureRecognizer *)recgonizer
{
    NSLog(@"Selected player");
    self.playerLabel.textColor = [UIColor blueColor];
    self.computerLabel.textColor = [UIColor blackColor];
    
    [[TTTGamePlayController sharedInstance] startGameWithPlayer:YES];
    
    [self.gridView clearGrid];
    
    self.gridTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleGridTap:)];
    [self.gridView addGestureRecognizer:self.gridTapRecognizer];
}

- (void)singleGridTap:(UIGestureRecognizer *)gestureRecognizer
{
    if ([TTTGamePlayController sharedInstance].currGameState.isPlayerTurn) {
        CGPoint tapLoc = [gestureRecognizer locationInView:self.gridView];
        NSInteger moveIndex = -1;
        
        TTTXView *xView = [[TTTXView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        if (tapLoc.x > 0 && tapLoc.x < kCellSize) {
            if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
                NSLog(@"Top left");
                
                xView.center = CGPointMake(kCellSize / 2, kCellSize / 2);
                
                moveIndex = 0;
                
            } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
                NSLog(@"Middle left");
                
                xView.center = CGPointMake(kCellSize / 2, (kCellSize + (2 * kCellSize)) / 2);
                
                moveIndex = 3;
                
            } else {
                NSLog(@"Bottom left");
                
                xView.center = CGPointMake(kCellSize / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
                
                moveIndex = 6;
            
            }
        } else if (tapLoc.x > kCellSize && tapLoc.x < 2 * kCellSize) {
            if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
                NSLog(@"Top middle");
                
                xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, kCellSize / 2);
                
                moveIndex = 1;
                
            } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
                NSLog(@"Middle middle");
                
                xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
                
                moveIndex = 4;
                
            } else {
                NSLog(@"Bottom middle");
                
                xView.center = CGPointMake((kCellSize + (2 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
                
                moveIndex = 7;
                
            }
        } else {
            if (tapLoc.y > 0 && tapLoc.y < kCellSize) {
                NSLog(@"Top right");
                
                xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, kCellSize / 2);
                
                moveIndex = 2;
                
            } else if (tapLoc.y > kCellSize && tapLoc.y < 2 * kCellSize) {
                NSLog(@"Middle right");
                
                xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, (kCellSize + (2 * kCellSize)) / 2);
                
                moveIndex = 5;
                
            } else {
                NSLog(@"Bottom right");
                
                xView.center = CGPointMake(((2 * kCellSize) + (3 * kCellSize)) / 2, ((2 * kCellSize) + (3 * kCellSize)) / 2);
                
                moveIndex = 8;
                
            }
        }
        
        if ([[TTTGamePlayController sharedInstance].currGameState isSlotOpen:moveIndex]) {
            [[TTTGamePlayController sharedInstance].currGameState makeMoveWith:TTTBoardPieceX atIndex:moveIndex];
            
            [self.gridView addSubview:xView];
            
            [[TTTGamePlayController sharedInstance].currGameState setPlayerTurn:NO];
            
            if (![self checkEndGame]) {
                [self computerResponse];
            }
        }

    }
    
}

- (void)computerResponse
{
    if (![TTTGamePlayController sharedInstance].currGameState.isPlayerTurn) {
        
        [self.computerIcon removeGestureRecognizer:self.computerRecognizer];
        [self.computerLabel removeGestureRecognizer:self.computerRecognizer];
        [self.playerIcon removeGestureRecognizer:self.playerRecognizer];
        [self.playerLabel removeGestureRecognizer:self.playerRecognizer];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0, 0, 100, 100);
        indicator.center = CGPointMake(self.view.center.x, self.promptLabel.center.y + self.promptLabel.bounds.size.height / 2);
        [self.view addSubview:indicator];
        [indicator bringSubviewToFront:self.view];
        
        [indicator startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSInteger move = [[TTTGamePlayController sharedInstance].perfectComputer takeTurn];
            NSLog(@"Computer response: %lu", move);
            
            dispatch_async(dispatch_get_main_queue(), ^{
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
                
                [indicator stopAnimating];
                
                self.computerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectComputer:)];
                [self.computerIcon addGestureRecognizer:self.computerRecognizer];
                [self.computerLabel addGestureRecognizer:self.computerRecognizer];
                
                self.playerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPlayer:)];
                [self.playerIcon addGestureRecognizer:self.playerRecognizer];
                [self.playerLabel addGestureRecognizer:self.playerRecognizer];
                
                [self checkEndGame];
            });
        });
        
    }
    
    
}

- (BOOL)checkEndGame
{
    if ([[TTTGamePlayController sharedInstance].currGameState isFinished]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Draw" message:@"Better luck next time!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.gridView clearGrid];
            [[TTTGamePlayController sharedInstance] resetGame];
        }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        [self removeGridTapRecognizer];
        
        self.playerLabel.textColor = [UIColor blackColor];
        self.computerLabel.textColor = [UIColor blackColor];
        
        return YES;
    }
    
    if ([[TTTGamePlayController sharedInstance].currGameState hasWonPlayer:TTTBoardPieceX]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:@"You Won!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.gridView clearGrid];
            [[TTTGamePlayController sharedInstance] resetGame];
        }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        [self removeGridTapRecognizer];
        
        self.playerLabel.textColor = [UIColor blackColor];
        self.computerLabel.textColor = [UIColor blackColor];
        
        return YES;
    }
    
    if ([[TTTGamePlayController sharedInstance].currGameState hasWonPlayer:TTTBoardPieceO]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"The Computer Won" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.gridView clearGrid];
            [[TTTGamePlayController sharedInstance] resetGame];
        }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        [self removeGridTapRecognizer];
        
        self.playerLabel.textColor = [UIColor blackColor];
        self.computerLabel.textColor = [UIColor blackColor];
        
        return YES;
    }
    
    return NO;
}

- (void)removeGridTapRecognizer
{
    [self.gridView removeGestureRecognizer:self.gridTapRecognizer];
}




@end
