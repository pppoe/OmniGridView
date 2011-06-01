//
//  OmniGridView.h
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OmniGridViewDelegate;
@class OmniGridCell;

@interface OmniGridView : UIScrollView <UIScrollViewDelegate> {
    id<OmniGridViewDelegate> _gridDelegate;
    NSMutableDictionary *_gridCellsDict;
    NSMutableArray *_reusableGridCells;
}

@property (nonatomic, assign) id<OmniGridViewDelegate> gridDelegate;

- (void)reloadData;

- (OmniGridCell *)dequeueReusableGridCell;

@end
