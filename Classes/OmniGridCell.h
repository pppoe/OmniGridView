//
//  OmniGridCell.h
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OmniGridView;

@interface OmniGridCell : UIView {
//    OmniGridLoc *_gridLoc;  
    UIView *_contentView;   
    UILabel *_textLabel;
    int _state;
}

@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, readonly) UILabel *textLabel;

//- (id)initWithGridLoc:(OmniGridLoc *)gridLoc;

@end
