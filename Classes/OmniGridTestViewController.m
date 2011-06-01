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
    
    OmniGridView *gridView = [[OmniGridView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    gridView.gridDelegate = self;
    gridView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:gridView];
    [gridView release];
}
 
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
    
    gridCell.textLabel.text = [NSString stringWithFormat:@"(%d,%d)", gridLoc.row, gridLoc.col];
    
    return gridCell;
}

- (float)gridCellHeightInGridView:(OmniGridView *)gridView {
    return 200.0f;
}

- (float)gridCellWidthInGridView:(OmniGridView *)gridView {
    return 200.0f;
}

- (int)numberOfGridCellsInRow:(int)row inGridView:(OmniGridView *)gridView {
    return 12;
}

- (int)numberOfRowsInGridView:(OmniGridView *)gridView {
    return 12;
}

@end

