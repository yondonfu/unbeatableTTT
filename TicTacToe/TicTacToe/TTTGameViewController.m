//
//  TTTGameViewController.m
//  TicTacToe
//
//  Created by Yondon Fu on 5/21/15.
//  Copyright (c) 2015 TicTacToe. All rights reserved.
//

#import "TTTGameViewController.h"
#import "TTTGridView.h"

@interface TTTGameViewController ()

@property (strong, nonatomic) TTTGridView *gridView;
@property (strong, nonatomic) UILabel *playerLabel;
@property (strong, nonatomic) UILabel *computerLabel;
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
    
    self.computerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.view.bounds.size.height - 100, 100, 100)];
    self.computerLabel.text = @"You";
    self.computerLabel.textAlignment = NSTextAlignmentCenter;
    self.computerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.computerLabel setUserInteractionEnabled:YES];
    [self.view addSubview:self.computerLabel];
    
    UITapGestureRecognizer *computerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectComputer:)];
    [self.computerLabel addGestureRecognizer:computerRecognizer];
    
    self.playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + self.view.bounds.size.width - 90, self.view.bounds.origin.y + self.view.bounds.size.height - 100, 100, 100)];
    self.playerLabel.text = @"Me";
    self.playerLabel.textAlignment = NSTextAlignmentCenter;
    self.playerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.playerLabel setUserInteractionEnabled:YES];
    [self.view addSubview:self.playerLabel];
    
    UITapGestureRecognizer *playerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPlayer:)];
    [self.playerLabel addGestureRecognizer:playerRecognizer];
    
    self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    self.promptLabel.text = @"Select who goes first:";
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    self.promptLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    self.promptLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 220);
    [self.view addSubview:self.promptLabel];
}

- (void)selectComputer:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Selected computer");
}

- (void)selectPlayer:(UITapGestureRecognizer *)recgonizer
{
    NSLog(@"Selected player");
}

@end
