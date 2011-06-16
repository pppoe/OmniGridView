//
//  OmniGridView.m
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import "OmniGridView.h"
#import "OmniGridCell.h"
#import "OmniGridLoc.h"
#import "OmniGridViewDelegate.h"

#import <QuartzCore/QuartzCore.h>

@interface OmniGridView (Private)

- (NSString *)keyFromGridLoc:(OmniGridLoc *)gridLoc;

@end

@implementation OmniGridView
@synthesize gridDelegate = _gridDelegate;
@synthesize editing = _editing;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.delegate = self;
        
        _gridCellsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        _reusableGridCells = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)dealloc {
    [_gridCellsDict release];
    [_reusableGridCells release];
    [super dealloc];
}

- (void)layoutSubviews {
    if (self.gridDelegate)
    {
        int rowCount = [self.gridDelegate numberOfRowsInGridView:self];
        NSAssert((rowCount > 0), @"OmniGridView required numberOfRowsInGridView > 0");
        
        float gridCellWidth = [self.gridDelegate gridCellWidthInGridView:self];
        NSAssert((gridCellWidth > 0), @"OmniGridView required gridCellWidthInGridView: > 0");
        
        float gridCellHeight = [self.gridDelegate gridCellHeightInGridView:self];
        NSAssert((gridCellHeight > 0), @"OmniGridView required gridCellHeightInGridView: > 0");
        
        float maxPointX = gridCellWidth * rowCount;
        float maxPointY = 0.0f;
        
        //< Content Size
        for (int row = 0; row < rowCount; row++)
        {
            int colCount = [self.gridDelegate numberOfGridCellsInRow:row inGridView:self];
            if (maxPointY < (gridCellHeight * colCount))
            {
                maxPointY = (gridCellHeight * colCount);
            }
        }
        
        self.contentSize = CGSizeMake(maxPointX, maxPointY);
    }    

    //< Initialization
    if ([_gridCellsDict count] == 0)
    {
        float gridCellWidth = [self.gridDelegate gridCellWidthInGridView:self];
        NSAssert((gridCellWidth > 0), @"OmniGridView required gridCellWidthInGridView: > 0");
        
        float gridCellHeight = [self.gridDelegate gridCellHeightInGridView:self];
        NSAssert((gridCellHeight > 0), @"OmniGridView required gridCellHeightInGridView: > 0");
        
        //< Visible Cells
        int cellMaxIdxX = ceil(self.frame.size.width/gridCellWidth);        
        int cellMaxIdxY = ceil(self.frame.size.height/gridCellHeight);
        
        for (int r = 0; r < cellMaxIdxY; r++)
        {
            for (int c = 0; c < cellMaxIdxX; c++)
            {
                OmniGridLoc *gridLoc = [OmniGridLoc locAtRow:r andColumn:c];
                OmniGridCell *gridCell = [self.gridDelegate gridCellAt:gridLoc inGridView:self];
                gridCell.frame = CGRectMake(c * gridCellWidth, r * gridCellHeight, gridCellWidth, gridCellHeight);
                [_gridCellsDict setObject:gridCell forKey:[self keyFromGridLoc:gridLoc]];
                [self addSubview:gridCell];
            }
        }
    }

    [self performSelector:@selector(scrollViewDidScroll:) 
               withObject:self
               afterDelay:0.0f];
}

#pragma mark Methods
- (void)setEditing:(BOOL)editing {
    _editing = editing;
}

- (void)reloadData {
    [self reloadDataAnimated:NO];
}

- (void)reloadDataAnimated:(BOOL)animated {
    for (OmniGridCell *gridCell in [_gridCellsDict allValues])
    {
        [gridCell removeFromSuperview];
    }
    [_gridCellsDict removeAllObjects];
    [_reusableGridCells removeAllObjects];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    [self.layer addAnimation:animation forKey:@"reloadData"];
    [self setNeedsLayout];    
}

- (OmniGridCell *)dequeueReusableGridCell {
    OmniGridCell *gridCell = [_reusableGridCells lastObject];
    if (gridCell)
    {
        [_reusableGridCells removeLastObject];
    }
    return gridCell;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    
    float gridCellWidth = [self.gridDelegate gridCellWidthInGridView:self];
    NSAssert((gridCellWidth > 0), @"OmniGridView required gridCellWidthInGridView: > 0");
    
    float gridCellHeight = [self.gridDelegate gridCellHeightInGridView:self];
    NSAssert((gridCellHeight > 0), @"OmniGridView required gridCellHeightInGridView: > 0");    

    for (OmniGridCell *gridCell in [_gridCellsDict allValues])
    {
        if (!CGRectIntersectsRect(gridCell.frame, CGRectMake(offset.x, offset.y, scrollView.frame.size.width, scrollView.frame.size.height)))
        {
            int c = floor(CGRectGetMinX(gridCell.frame)/gridCellWidth);
            int r = floor(CGRectGetMinY(gridCell.frame)/gridCellHeight);
            OmniGridLoc *gridLoc = [OmniGridLoc locAtRow:r andColumn:c];
            [gridCell removeFromSuperview];
            [_gridCellsDict removeObjectForKey:[self keyFromGridLoc:gridLoc]];
            [_reusableGridCells addObject:gridCell];
        }
    }
    
    int cellColIdxMin = floor(offset.x/gridCellWidth);
    int cellColIdxMax = ceil((offset.x + self.frame.size.width)/gridCellWidth);

    int cellRowIdxMin = floor(offset.y/gridCellHeight);
    int cellRowIdxMax = ceil((offset.y + self.frame.size.height)/gridCellHeight);
    
    for (int r = cellRowIdxMin; r < cellRowIdxMax; r++)
    {
        for (int c = cellColIdxMin; c < cellColIdxMax; c++)
        {
            OmniGridLoc *gridLoc = [OmniGridLoc locAtRow:r andColumn:c];
            if (![_gridCellsDict objectForKey:[self keyFromGridLoc:gridLoc]])
            {
                OmniGridCell *gridCell = [self.gridDelegate gridCellAt:gridLoc inGridView:self];
                gridCell.frame = CGRectMake(c * gridCellWidth, r * gridCellHeight, gridCellWidth, gridCellHeight);
                [_gridCellsDict setObject:gridCell forKey:[self keyFromGridLoc:gridLoc]];
                [self addSubview:gridCell];
            }
        }
    }
    
}

@end

@implementation OmniGridView (Private)

- (NSString *)keyFromGridLoc:(OmniGridLoc *)gridLoc {
    return [NSString stringWithFormat:@"%dx%d", gridLoc.row, gridLoc.col];
}

@end

