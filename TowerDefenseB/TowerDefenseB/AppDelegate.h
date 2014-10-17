//
//  AppDelegate.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-11-22.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
	
	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
    
    int _typeTheme;
    int _typeBg;
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@property (nonatomic, assign) int typeTheme;
@property (nonatomic, assign) int typeBg;
+ (AppController *)sharedAppDelegate;
@end
