//
//  OmniGridTestViewController.m
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import "OmniGridTestViewController.h"
#import "OmniGrid.h"

#import <QuartzCore/QuartzCore.h>

@interface OmniGridTestViewController (Private) <OmniGridViewDelegate>

@end

@implementation OmniGridTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                 target:self
                                                                                 action:@selector(refresh)];
    self.navigationItem.leftBarButtonItem = refreshItem;
    [refreshItem release];

    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                 target:self
                                                                                 action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = editItem;
    [editItem release];
    
    OmniGridView *gridView = [[OmniGridView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
    gridView.gridDelegate = self;
    gridView.backgroundColor = [UIColor lightGrayColor];
    
    _gridView = gridView;
    
    [self.view addSubview:gridView];
    [gridView release];
}

- (void)refresh {
    [_gridView reloadData];
}

- (void)edit {
}
 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

@end

#pragma mark OmniGridViewDelegate
@implementation OmniGridTestViewController (Private)

- (OmniGridCell *)gridCellAt:(OmniGridLoc *)gridLoc inGridView:(OmniGridView *)gridView {
    OmniGridCell *gridCell = [gridView dequeueReusableGridCell];
    if (!gridCell)
    {
        gridCell = [[OmniGridCell alloc] init];
        gridCell.layer.borderColor = [UIColor blackColor].CGColor;
        gridCell.layer.borderWidth = 1.0f;
        gridCell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    gridCell.textLabel.text = [NSString stringWithFormat:@"(%d,%d), %d", gridLoc.row, gridLoc.col, random()%10];
    
    return gridCell;
}

- (float)gridCellHeightInGridView:(OmniGridView *)gridView {
    return 100.0f;
}

- (float)gridCellWidthInGridView:(OmniGridView *)gridView {
    return 100.0f;
}

- (int)numberOfGridCellsInRow:(int)row inGridView:(OmniGridView *)gridView {
    return 12;
}

- (int)numberOfRowsInGridView:(OmniGridView *)gridView {
    return 12;
}

@end

