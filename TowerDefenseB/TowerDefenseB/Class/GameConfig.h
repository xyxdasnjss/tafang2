//
//  GameConfig.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-4.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#ifndef TowerDefenseB_GameConfig_h
#define TowerDefenseB_GameConfig_h

enum ThemeType {
    kTypeSkyLine = 1,
    kTypeJungle,
    kTypeDesert,
    kTypeExtreme,
    kTypeDeepSea,
};


#define kZMapBg         0
#define kZMenuBg        1
#define kZMenuChild     2
#define kZMapChild      3
//#define kZTowerAndMonster  4
#define kZHigh          99

typedef enum _MonsterType{
    kMonsterTypeBossBig = 1,
    kMonsterTypeFatBossGreen,
    kMonsterTypeFatGreen,
    kMonsterTypeFlyBlue,
    kMonsterTypeFlyBossBlue,
    kMonsterTypeFlyBossYellow,
    kMonsterTypeFlyYellow,
    kMonsterTypeLandBossNima,
    kMonsterTypeLandBossPink,
    kMonsterTypeLandBossStar,
    kMonsterTypeLandNima,
    kMonsterTypeLandPink,
    kMonsterTypeLandStar,
}MonsterType;

#endif
