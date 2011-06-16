//
//  OmniGridViewAppDelegate.h
//  OmniGridView
//
//  Created by Haoxiang on 5/17/11.
//  Copyright 2011 Dev.Mr.pppoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OmniGridViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

