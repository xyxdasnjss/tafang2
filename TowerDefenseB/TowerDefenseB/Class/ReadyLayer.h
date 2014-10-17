//
//  ReadyLayer.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCLayer.h"
@class GameScene;
@interface ReadyLayer : CCLayer
<CCTargetedTouchDelegate>
{
    CCSprite *_bg;
    CCSprite *_circle;
    CCSprite *_time;
    GameScene *_gameLayer;
}
@property (retain, nonatomic) CCSprite *bg;
@property (retain, nonatomic) CCSprite *circle;
@property (retain, nonatomic) CCSprite *time;
@property (retain, nonatomic) GameScene *gameLayer;


@end
