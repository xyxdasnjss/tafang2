//
//  GameOverLayer.m
//  TowerDefenseB
//
//  Created by xyxd on 12-12-11.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameScene.h"
#import "LoadingScene.h"

@interface GameOverLayer ()
{
    CGSize winSize;
}

@end

@implementation GameOverLayer
@synthesize bg = _bg;
@synthesize title = _title;
@synthesize menu = _menu;


- (id) initWithResultType:(gameResultType)type
{
    if ((self = [super init])) {
        
        winSize = [[CCDirector sharedDirector] winSize];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameover0.plist"];
        CCSpriteBatchNode *spritesBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"gameover0.pvr.ccz"];
        [self addChild:spritesBatchNode z:kZMenuBg];
        
        if (type == kResultTypeWin) {
            _bg = [CCSprite spriteWithSpriteFrameName:@"win_bg.png"];
        }else if (type == kResultTypeLose) {
            _bg = [CCSprite spriteWithSpriteFrameName:@"lose_bg.png"];
        }
        _bg.position = ccp(winSize.width*.5, winSize.height*.5);
        
        [spritesBatchNode addChild:_bg];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameover.plist"];
        CCSpriteBatchNode *spritesBatchNodeBtn = [CCSpriteBatchNode batchNodeWithFile:@"gameover.pvr.ccz"];
        [self addChild:spritesBatchNodeBtn z:kZMenuBg];
        
        
        CCSprite *continueSprite = [CCSprite spriteWithSpriteFrameName:@"continue_normal_CN.png"];
        CCSprite *continueSpriteP = [CCSprite spriteWithSpriteFrameName:@"continue_pressed_CN.png"];
        CCMenuItemSprite *continueItem = [CCMenuItemSprite itemWithNormalSprite:continueSprite selectedSprite:continueSpriteP block:^(id sender)
                                          {
                                              [[CCDirector sharedDirector] resume];
                                              [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneThemeStages]];
                                          }];
        
        CCSprite *retrySprite = [CCSprite spriteWithSpriteFrameName:@"retry_normal_CN.png"];
        CCSprite *retrySpriteP = [CCSprite spriteWithSpriteFrameName:@"retry_pressed_CN.png"];
        CCMenuItemSprite *retryItem = [CCMenuItemSprite itemWithNormalSprite:retrySprite selectedSprite:retrySpriteP block:^(id sender)
                                       {
                                           
                                           [[CCDirector sharedDirector] resume];
                                           [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneGameScene]];
//                                           [self.parent removeChild:self cleanup:YES];
                                       }];
        
        _menu = [CCMenu menuWithItems:continueItem,retryItem, nil];
        _menu.position = ccp(winSize.width*.5, winSize.height*2/7);
        [self addChild:_menu z:kZMapChild];
        [_menu alignItemsHorizontally];
        
        
        
        
    }
    
    return self;
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kPriorityGameOver swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
    //取消触摸协议
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
    [super onExit];
}

@end
