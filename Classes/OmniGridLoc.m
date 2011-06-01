//
//  OmniGridLoc.m
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import "OmniGridLoc.h"

@implementation OmniGridLoc
@synthesize row = _row;
@synthesize col = _col;

- (id)initWithRow:(int)row andColumn:(int)col {
    if ((self = [super init]))
    {
        _row = row;
        _col = col;
    }
    return self;
}

+ (OmniGridLoc *)locAtRow:(int)row andColumn:(int)col {
    return [[[OmniGridLoc alloc] initWithRow:row andColumn:col] autorelease];
}

@end
