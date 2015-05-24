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
}

- (void)selectPlayer:(UITapGestureRecognizer *)recgonizer
{
    NSLog(@"Selected player");
    self.playerLabel.textColor = [UIColor blueColor];
}



@end
