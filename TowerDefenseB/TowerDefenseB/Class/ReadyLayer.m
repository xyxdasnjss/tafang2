//
//  ReadyLayer.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "ReadyLayer.h"
#import "GameConfig.h"
#import "GameScene.h"
#import "SimpleAudioEngine.h"
@implementation ReadyLayer
@synthesize bg = _bg;
@synthesize circle = _circle;
@synthesize time = _time;
@synthesize gameLayer = _gameLayer;

- (id) init
{
    if ((self = [super init])) {
       
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        //re circle
        _bg = [CCSprite spriteWithSpriteFrameName:@"countdown_11.png"];
        _bg.position = ccp(winSize.width*.5, winSize.height*.5);
        [self addChild:_bg z:kZMapChild];
        
        
        
        _circle = [CCSprite spriteWithSpriteFrameName:@"countdown_12.png"];
        _circle.position = ccp(winSize.width*.5, winSize.height*.5);
        [self addChild:_circle z:kZMapChild];
        id rotateAction = [CCRotateTo actionWithDuration:.8*10 angle:-360*10];
        [_circle runAction:[CCSequence actions:rotateAction, nil]];

        
        //3,2,1,go
        //01 "3",02 "2",03 "3",13 "go"
        //11 "bg",12 "cricle"
        _time = [CCSprite spriteWithSpriteFrameName:@"countdown_01.png"];
        _time.position = ccp(winSize.width*.5, winSize.height*.5);
        [self addChild:_time z:kZMapChild];
        
        NSMutableArray *temArray = [NSMutableArray array];
        CCSpriteFrame *spriteFrame;
        int i = 1;
        while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                                [NSString stringWithFormat:@"countdown_0%d.png", i]])) {
            [temArray addObject:spriteFrame];
            i++;
        }
        
        spriteFrame = nil;
        [temArray addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"countdown_13.png"]];
        
        
        
        
        
        CCAnimation *djsAnim = [CCAnimation animationWithSpriteFrames:temArray delay:.8];
        id djsAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:djsAnim] times:1];
        id djsOver = [CCCallFuncN actionWithTarget:self selector:@selector(djsFinished:)];
        [_time runAction:[CCSequence actions:djsAction,djsOver, nil]];

        [[SimpleAudioEngine sharedEngine] playEffect:@"CountDown.caf"];
        
        
        
    }
    
    return self;
}


- (void) djsFinished:(id)sender
{
    CCSprite *sprite = (CCSprite*)sender;
    [self removeChild:sprite cleanup:YES];
    
    
    [self removeChild:_bg cleanup:YES];
    
    [_circle stopAllActions];
    [self removeChild:_circle cleanup:YES];
    

    [self.gameLayer begin];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}


- (void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kPriorityGameReady swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
    //取消触摸协议
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
    [super onExit];
}

@end
