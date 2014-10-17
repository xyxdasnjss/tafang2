//
//  Wave.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Wave : CCNode
{
    float _spawnRate;
	int _totalMonsters;
	MonsterType _monsterType;
}

@property (nonatomic, assign) float spawnRate;
@property (nonatomic, assign) int totalMonsters;
@property (nonatomic, assign) MonsterType monsterType;

- (id)initWithMonster:(MonsterType)monster
            SpawnRate:(float)spawnrate
        TotalMonsters:(int)totalMonsters;


@end
