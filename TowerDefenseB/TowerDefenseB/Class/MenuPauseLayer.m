//
//  MenuPauseLayer.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-10.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "MenuPauseLayer.h"
#import "ThemeStagesScene.h"
#import "LoadingScene.h"

@interface MenuPauseLayer ()
{
    CGSize winSize;
}

@end

@implementation MenuPauseLayer
@synthesize bg = _bg;
@synthesize menu = _menu;

- (id) init
{
    if ((self = [super init])) {
        
        winSize = [[CCDirector sharedDirector] winSize];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gamemenu.plist"];
        CCSpriteBatchNode *spritesBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"gamemenu.pvr.ccz"];
        [self addChild:spritesBatchNode z:kZMenuBg];
        
        _bg = [CCSprite spriteWithSpriteFrameName:@"menu_bg.png"];
        _bg.position = ccp(winSize.width*.5, winSize.height*.5);
        [self addChild:_bg];
        
        CCSprite *resume = [CCSprite spriteWithSpriteFrameName:@"menu_resume_normal_CN.png"];
        CCSprite *resumeP = [CCSprite spriteWithSpriteFrameName:@"menu_resume_pressed_CN.png"];
        CCMenuItemSprite *reusmeItem = [CCMenuItemSprite itemWithNormalSprite:resume selectedSprite:resumeP block:^(id sender)
                                        {
                                            [[CCDirector sharedDirector] resume];
                                            [self.parent removeChild:self cleanup:YES];
                                        }];
        
        CCSprite *restart = [CCSprite spriteWithSpriteFrameName:@"menu_restart_normal_CN.png"];
        CCSprite *restartP = [CCSprite spriteWithSpriteFrameName:@"menu_restart_pressed_CN.png"];
        CCMenuItemSprite *restartItem = [CCMenuItemSprite itemWithNormalSprite:restart selectedSprite:restartP block:^(id sender)
                                         {
                                             
                                             [[CCDirector sharedDirector] resume];
                                             [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneGameScene]];
                                             
                                             
                                         }];
        
        
        CCSprite *quit = [CCSprite spriteWithSpriteFrameName:@"menu_quit_normal_CN.png"];
        CCSprite *quitP = [CCSprite spriteWithSpriteFrameName:@"menu_quit_pressed_CN.png"];
        CCMenuItemSprite *quitItem = [CCMenuItemSprite itemWithNormalSprite:quit selectedSprite:quitP block:^(id sender)
                                      {
                                          
                                          [[CCDirector sharedDirector] resume];
                                          [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneThemeStages]];
                                          
                                          
                                      }];
        
        _menu = [CCMenu menuWithItems:reusmeItem,restartItem,quitItem, nil];
        _menu.position = _bg.position;
        [self.menu alignItemsVertically];
        [self addChild:_menu];
        
        
        //         [[CCDirector sharedDirector] stopAnimation];
        
        
        
    }
    
    return self;
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}



- (void) onEnter
{
    [[CCDirector sharedDirector] pause];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kPriorityGamePause swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
    //取消触摸协议
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
    [super onExit];
}


@end
