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
}

@end
