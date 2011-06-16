//
//  OmniGridViewDelegate.h
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

@class OmniGridLoc;
@class OmniGridCell;
@class OmniGridView;

@protocol OmniGridViewDelegate

@required
- (OmniGridCell *)gridCellAt:(OmniGridLoc *)gridLoc inGridView:(OmniGridView *)gridView;
- (float)gridCellHeightInGridView:(OmniGridView *)gridView;
- (float)gridCellWidthInGridView:(OmniGridView *)gridView;
- (int)numberOfGridCellsInRow:(int)row inGridView:(OmniGridView *)gridView;
- (int)numberOfRowsInGridView:(OmniGridView *)gridView;

@optional
- (void)gridView:(OmniGridView *)gridView willDisplayCell:(OmniGridCell *)cell forGridLoc:(OmniGridLoc *)gridLoc;
- (void)gridView:(OmniGridView *)gridView didSelectCellAtLoc:(OmniGridLoc *)gridLoc;
- (BOOL)gridView:(OmniGridView *)gridView shouldEditCellAtLoc:(OmniGridLoc *)gridLoc;

@end
