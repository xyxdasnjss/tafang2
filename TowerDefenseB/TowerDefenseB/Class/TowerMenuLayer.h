//
//  TowerMenuLayer.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-11-28.
//
//

#import "CCLayer.h"
@class GameScene;
@class Tower;

@interface TowerMenuLayer : CCLayer

{
    CCSprite *_select;
    CCMenu *_menu;
    
    GameScene *_gameLayer;
    
    Tower *_mTower;
}

@property (retain, nonatomic) CCSprite *select;
@property (retain, nonatomic) CCMenu *menu;
@property (retain, nonatomic) GameScene *gameLayer;
@property (retain, nonatomic) Tower *mTower;

+ (TowerMenuLayer*) sharedLayer;
- (void) setMPosition:(CGPoint)mPosition;

@end
