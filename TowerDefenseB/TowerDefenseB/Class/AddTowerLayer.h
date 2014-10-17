//
//  AddTowerLayer.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-6.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCLayer.h"
@class GameScene;

@interface AddTowerLayer : CCLayer
<CCTargetedTouchDelegate>

{
    CCSprite *_select;
    CCMenu *_menu;
    
    GameScene *_gameLayer;
}
@property (retain, nonatomic) CCSprite *select;
@property (retain, nonatomic) CCMenu *menu;
@property (retain, nonatomic) GameScene *gameLayer;
+ (AddTowerLayer*) sharedLayer;
- (void) setMPosition:(CGPoint)mPosition;
+ (void) mReset;
@end
