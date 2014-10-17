//
//  GameScene.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-11-22.
//
//

#import "CCScene.h"
@class GameMenuLayer;
@class GameOverLayer;

@interface GameScene : CCLayer
<CCTargetedTouchDelegate>
{
    CCTMXTiledMap *_tileMap;
    //    CCTMXLayer *_background;
  
    int _typeTheme;//主题类型
    int _typeBG;//地图类型
    int _currentLevel;
    BOOL _isShowTowerLayer;
    BOOL _isShowTowerMenu;
    
    GameMenuLayer *_gameMenu;
    GameOverLayer *_gameOver;
}

@property (nonatomic, retain) GameMenuLayer *gameMenu;
@property (nonatomic, retain) GameOverLayer *gameOver;

@property (nonatomic, retain) CCTMXTiledMap *tileMap;
//@property (nonatomic, retain) CCTMXLayer *background;


@property (assign, nonatomic) int typeTheme;
@property (assign, nonatomic) int typeBG;
@property (assign, nonatomic) int currentLevel;
@property (assign, nonatomic) BOOL isShowTowerLayer;
@property (assign, nonatomic) BOOL isShowTowerMenu;


- (void) begin;
- (void) addTower: (CGPoint)pos withType:(int)towerType;


+(CCScene *) scene;
+(CCScene *) sceneWithTheme:(int)themeType withBg:(int)bg;

@end
