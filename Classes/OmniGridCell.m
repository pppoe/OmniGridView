//
//  OmniGridCell.m
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import "OmniGridCell.h"
//#import "OmniGridView.h"

@implementation OmniGridCell
@dynamic contentView;
@dynamic textLabel;

//- (id)initWithGridLoc:(OmniGridView *)gridView {
//    
//    if ((self = [super init])) {
//        // Initialization code.
//    }
//    return self;
//}

- (void)dealloc {
    [super dealloc];
}

- (UIView *)contentView {
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_contentView];
        [_contentView release];
    }
    return _contentView;
}

- (UILabel *)textLabel {
    if (!_textLabel)
    {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textLabel];
        [_textLabel release];
    }
    return _textLabel;
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    _contentView.frame = self.bounds;
    _textLabel.frame = self.bounds;
}

@end
