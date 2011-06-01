//
//  OmniGridLoc.h
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OmniGridLoc : NSObject {
    int _row;
    int _col;
}

@property (nonatomic, readonly) int row;
@property (nonatomic, readonly) int col;

+ (OmniGridLoc *)locAtRow:(int)row andColumn:(int)col;

- (id)initWithRow:(int)row andColumn:(int)col;

@end
