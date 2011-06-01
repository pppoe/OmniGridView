//
//  OmniGridViewAppDelegate.h
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OmniGridTestViewController;

@interface OmniGridViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    OmniGridTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

