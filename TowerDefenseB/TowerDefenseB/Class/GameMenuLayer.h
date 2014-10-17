//
//  GameMenuLayer.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-7.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCLayer.h"

@interface GameMenuLayer : CCLayer
<CCTargetedTouchDelegate>
{
    CCSprite *_menuBg;
    CCLabelTTF *_moneyLabel;
    CCLabelTTF *_waveCountLabel;
    CCLabelTTF *_waveTotalCountLabel;
    CCMenu *_menu;
    int _waveCount;
    CCSprite *_waveStatus;
}

@property (nonatomic, retain) CCSprite *menuBg;
@property (nonatomic, retain) CCSprite *waveStatus;
@property (nonatomic, retain) CCLabelTTF *moneyLabel;
@property (nonatomic, retain) CCLabelTTF *waveCountLabel;
@property (nonatomic, retain) CCLabelTTF *waveTotalCountLabel;
@property (nonatomic, retain) CCMenu *menu;
@property (nonatomic, assign) int waveCount;

- (void) updateWaveCount;
- (void) newWaveApproaching;
- (void) newWaveApproachingEnd;


- (void) updateMoney:(int)money;
- (void) updateHealth;

@end
